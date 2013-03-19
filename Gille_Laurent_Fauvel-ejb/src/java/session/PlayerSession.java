package session;

import javax.ejb.Stateless;
import javax.ejb.LocalBean;
import javax.persistence.*;
import javax.ejb.*;

import persistence.*;

@Stateless
@LocalBean
public class PlayerSession {
    
    @javax.persistence.PersistenceContext(unitName="PlayerSessionPersistence")
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
