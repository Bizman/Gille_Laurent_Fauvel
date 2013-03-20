package session;

import javax.ejb.Stateless;
import javax.persistence.*;
import persistence.Player;

@Stateless
public class ConnectivityHandler implements ConnectivityHandlerInterface {
    
    @PersistenceContext(unitName="PlayerSessionPersistence")
    private EntityManager em;

    @Override
    public int subscribe(String nick, String firstName, String lastName, String password, String email) {
        Player p = new Player(firstName, lastName, nick, password, email, 0);
        
        if (em.find(Player.class, nick) != null) {
            return ConnectivityHandler.NICK_TAKEN;
        } else if (!em.createNamedQuery("checkEmail").getResultList().isEmpty()) {
            return ConnectivityHandler.MAIL_TAKEN;
        } else {
            em.persist(p);
            return ConnectivityHandler.SUBSCRIBE_OK;
        }
    }

    @Override
    public int connect(String nick, String password) {
        return ConnectivityHandlerInterface.CONNECTION_OK;
    }
    
}
