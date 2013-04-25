package session;

import javax.ejb.*;
import java.util.ArrayList;
import javax.persistence.EntityManager;

@Stateless
@LocalBean
public class PlayerSession {
    
    @javax.persistence.PersistenceContext(unitName="GamePersistence")
    private EntityManager em;
    private boolean defiAccept;
    private String nick;
    private ArrayList<String> defi;
    
    public PlayerSession() {
        defi = new ArrayList<String>();
        nick = new String();
    }
    
    public void setNick(String nick) {
        this.nick = nick;
    }
    
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void remove(Object obj){
        Object mergedObj = em.merge(obj);
        em.remove(mergedObj);
    }
    
    public void persist(Object obj){
        em.persist(obj);
    }
    
    public void addDefi(String nick) {
        if(!defi.contains(nick)) {
            defi.add(nick);
        }
    }
    
    public ArrayList getDefi() {
        return defi;
    }
    
    public boolean getDefiAck() {
        return defiAccept;
    }
    
    public void setDefiAck(boolean ack) {
        this.defiAccept = ack;
    }
}
