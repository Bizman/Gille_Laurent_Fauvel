package session;

import java.util.List;
import javax.ejb.EJB;
import javax.ejb.Stateful;
import javax.persistence.*;
import misc.PlayerState;
import persistence.Player;

@Stateful
public class ConnectivityHandlerBean implements ConnectivityHandler {
    
    @PersistenceContext(unitName="GamePersistence")
    private EntityManager em;
    
    public ConnectivityHandlerBean() {}
    
    @Override
    public int subscribe(String nick, String firstName, String lastName, String password, String email) {
        Player p = new Player(firstName, lastName, nick, password, email, 0);
        
        if (em.find(Player.class, nick) != null) {
            return ConnectivityHandlerBean.NICK_TAKEN;
        } else if (!em.createNamedQuery("checkEmail").setParameter("mail", email).getResultList().isEmpty()) {
            return ConnectivityHandlerBean.MAIL_TAKEN;
        } else {
            em.persist(p);
            return ConnectivityHandlerBean.SUBSCRIBE_OK;
        }
    }

    @Override
    public int connect(String nick, String password) {
        Player player = (Player) em.createNamedQuery("verifyUserData").setParameter("nickName", nick).setParameter("password", password).getSingleResult();
        
        if (player != null) {
            if (player.getEtat() == PlayerState.DISCONNECTED) {
                player.setState(PlayerState.CONNECTED);
                return ConnectivityHandler.CONNECTION_OK;
            } else {
                return ConnectivityHandlerBean.ALREADY_CONNECTED;
            }
        } else {
            return ConnectivityHandlerBean.BAD_INFO;
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
    
    
}