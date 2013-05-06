package session;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import misc.PlayerState;
import persistence.Defi;
import persistence.Player;

@Stateless
public class RoomHandlerBean implements RoomHandler {

    @PersistenceContext(unitName="GamePersistence")
    private EntityManager em;

    @Override
    public long defier(String a, String b) {
        Player p1 = em.find(Player.class, a);
        Player p2 = em.find(Player.class, b);

       if (p2 != null && p1 != null) {
            Defi d = new Defi(p1, p2);
            em.persist(d);
            return d.getId();
        } else {
            return 0;
        }
    }

    @Override
    public void accepterDefi(long id) {
        try {
            Defi d = getDefi(id);
            d.setEtat();
            em.merge(d);
        } catch(Exception e) {}
    }
    
    @Override
    public List<Player> getPlayers(String myNick) {
        Query query = em.createNamedQuery("getConnectedPlayers").setParameter("etat", PlayerState.DISCONNECTED).setParameter("me", myNick);
        return query.getResultList();
    }
    
    @Override
    public List<Defi> getDefis(String myNick) {
        Query query = em.createNamedQuery("waitingDefi").setParameter("me", myNick);
        return query.getResultList();
    }
    
    @Override
    public Defi getDefi(long id) {
        Query query = em.createNamedQuery("getDefi").setParameter("id", id);
        try {
            return (Defi) query.getSingleResult();
        } catch(Exception e) {
            return null;
        }
    }
    
    @Override
    public void removeDefi(long id) {
        em.clear();
        try {
            Defi defiToRemove = em.find(Defi.class, id);
            em.remove(defiToRemove);
        } catch(Exception e) {}
    }
}
