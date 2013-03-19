/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package session;

import javax.ejb.Stateless;
import javax.ejb.LocalBean;
import javax.persistence.*;
import javax.ejb.*;

import persistence.*;

/**
 *
 * @author Olivier
 */
@Stateless
@LocalBean
public class PlayerSession {
    
    @javax.persistence.PersistenceContext(unitName="persistence_sample")
    private EntityManager em ;

    
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
