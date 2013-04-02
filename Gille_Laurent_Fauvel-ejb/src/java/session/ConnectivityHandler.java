package session;

import javax.ejb.Stateful;
import javax.persistence.*;
import persistence.Player;

@Stateful
public class ConnectivityHandler implements ConnectivityHandlerInterface {
    
    @PersistenceContext(unitName="PlayerSessionPersistence")
    private EntityManager em;
    private String user;
    
    
    @Override
    public int subscribe(String nick, String firstName, String lastName, String password, String email) {
        Player p = new Player(firstName, lastName, nick, password, email, 0);
        
        if (em.find(Player.class, nick) != null) {
            return ConnectivityHandler.NICK_TAKEN;
        } else if (!em.createNamedQuery("checkEmail").setParameter("mail", email).getResultList().isEmpty()) {
            return ConnectivityHandler.MAIL_TAKEN;
        } else {
            em.persist(p);
            return ConnectivityHandler.SUBSCRIBE_OK;
        }
    }

    @Override
    public int connect(String nick, String password) {
        if (em.createNamedQuery("verifyUserData").setParameter("nickName", nick).setParameter("password", password).getResultList().isEmpty()) {
            return ConnectivityHandler.BAD_INFO;
        } else {
            user = nick;
            return ConnectivityHandlerInterface.CONNECTION_OK;
        }
    }

    @Override
    public boolean userExists(String nick) {
        return em.find(Player.class, nick) != null;
    }
    
    @Override
    public String test() {
        System.err.println("Connecté: " + user);
        return user;
    }
    
}
