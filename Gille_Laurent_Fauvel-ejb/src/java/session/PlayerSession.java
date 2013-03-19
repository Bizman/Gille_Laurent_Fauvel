package session;

import javax.ejb.*;
import javax.persistence.EntityManager;

@Stateless
@LocalBean
public class PlayerSession {
    
    private EntityManager em;
    
    public PlayerSession() {
        
    }
    
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void remove(Object obj){
        Object mergedObj = em.merge(obj);
        em.remove(mergedObj);
    }
    
    public void persist(Object obj){
        em.persist(obj);
    }
}
