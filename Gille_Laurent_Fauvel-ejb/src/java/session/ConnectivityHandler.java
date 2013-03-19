package session;

import javax.ejb.Stateless;
import javax.persistence.*;
import persistence.Player;

@Stateless
public class ConnectivityHandler implements ConnectivityHandlerInterface {
    
    @PersistenceContext
    private EntityManager em;

    @Override
    public int subscribe(String nick, String firstName, String lastName, String password, String email) {
        Player p = new Player(firstName, lastName, nick, password, email, 0);
        em.persist(p);
        return ConnectivityHandlerInterface.SUBSCRIBE_OK;
    }

    @Override
    public int connect(String nick, String password) {
        return ConnectivityHandlerInterface.CONNECTION_OK;
    }
    
}
