/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package session;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import misc.PlayerState;
import persistence.Defi;
import persistence.Player;

/**
 *
 * @author Alex
 */
@Stateless
public class RoomHandlerBean implements RoomHandler {

    @PersistenceContext(unitName="GamePersistence")
    private EntityManager em;
    
    public RoomHandlerBean() {}

    @Override
    public int defier(String a, String b) {
        Player p1 = em.find(Player.class, a);
        Player p2 = em.find(Player.class, b);
        
        if (p2 != null && p1 != null) {
            Defi d = new Defi(p1, p2);
            em.persist(d);
            return 1;
        } else {
            return 0;
        }
    }
    
    @Override
    public List<Player> getPlayers(String myNick) {
        Query query = em.createNamedQuery("getConnectedPlayers").setParameter("etat", PlayerState.DISCONNECTED).setParameter("me", myNick);
        return query.getResultList();
    }
    
    @Override
    public List<Defi> getDefi(String myNick) {
        Query query = em.createNamedQuery("waitingDefi").setParameter("me", myNick);
        return query.getResultList();
    }
}
