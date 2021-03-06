package session;

import javax.ejb.Stateful;
import javax.persistence.*;
import misc.PlayerState;
import persistence.Player;

@Stateful(mappedName = "ejb/ConnectivityHandler")
public class ConnectivityHandlerBean implements ConnectivityHandler {
    
    @PersistenceContext(unitName="GamePersistence")
    private EntityManager em;
        
    @Override
    public int subscribe(String nick, String firstName, String lastName, String password, String email) {
        Player p = new Player(firstName, lastName, nick, password, email, 0);
        
        //Si le joueur "ordinateur" n'existe pas dans la base
        if (em.find(Player.class, "computer") == null) {
            Player computer = new Player("computer");
            em.persist(computer);
        }
        if (em.find(Player.class, nick) != null) {
            return ConnectivityHandlerBean.NICK_TAKEN;
        } else if (!em.createNamedQuery("checkEmail").setParameter("mail", email).getResultList().isEmpty()) {
            return ConnectivityHandlerBean.MAIL_TAKEN;
        } else {
            p.setState(PlayerState.DISCONNECTED);
            em.persist(p);
            return ConnectivityHandlerBean.SUBSCRIBE_OK;
        }
    }

    @Override
    public int connect(String nick, String password) {
        try {
            Player player = (Player) em.createNamedQuery("verifyUserData").setParameter("nickName", nick).setParameter("password", password).getSingleResult();

            if (player.getEtat() == PlayerState.DISCONNECTED) {
                player.setState(PlayerState.CONNECTED);
                return ConnectivityHandler.CONNECTION_OK;
            } else {
                return ConnectivityHandlerBean.ALREADY_CONNECTED;
            }
        } catch(Exception e) {
            return ConnectivityHandler.BAD_INFO;
        }
    }
        
    @Override
    public boolean userExists(String nick) {   
        return em.find(Player.class, nick) != null;
    }
    
    @Override
    public void disconnect(String nick) {
        em.find(Player.class, nick).setState(PlayerState.DISCONNECTED);
    }
    
    @Override
    public Player getPlayer(String nick) {
        return em.find(Player.class, nick);
    }
}