package session;

import java.util.Date;
import java.util.HashMap;
import javax.ejb.Stateful;
import javax.persistence.*;
import persistence.Player;
   
@Stateful(mappedName = "ejb/TimerSession")
public class TimerSessionBean implements TimerSession{

    @PersistenceContext(unitName="GamePersistence")
    private EntityManager em;
    private HashMap<String, Integer> timeOut;
    
    public TimerSessionBean() {
        timeOut = new HashMap<String, Integer>();
    }
    
   @Override
    public boolean userExists(String nick) {   
        return em.find(Player.class, nick) != null;
    }
    
    @Override
    public int getTimestamp(String nick) {
        try {
            return timeOut.get(nick);
        } catch(Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    @Override
    public int clockIn(String nick) {
        if (userExists(nick)) {
            if (!timeOut.containsKey(nick)) {
                timeOut.put(nick, 0);
                return 1;
            } else {
                int time = timeOut.get(nick).intValue();
                time++;
                return timeOut.put(nick, time);
            }
        }
        return 0;
    }
        
    @Override
    public boolean endOfTime(String nick) {
        if(userExists(nick)) {
            if (timeOut.containsKey(nick)) {
                if(timeOut.get(nick).intValue() >= 5)
                    return true;
                }
            }        
        return false;
    }
}
