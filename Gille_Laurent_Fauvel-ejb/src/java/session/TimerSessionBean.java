package session;

import java.util.Iterator;
import java.util.Date;
import java.util.HashMap;
import javax.ejb.Stateful;
import javax.persistence.*;
import persistence.Player;
   
@Stateful(mappedName = "ejb/TimerSession")
public class TimerSessionBean implements TimerSession{

    @PersistenceContext(unitName="GamePersistence")
    private EntityManager em;    
    private HashMap<String, Date> timeOut;
    private static int timeToDeco = 30;
    
    public TimerSessionBean() {
        timeOut = new HashMap<String, Date>();
    }
    
   @Override
    public boolean userExists(String nick) {   
        return em.find(Player.class, nick) != null;
    }
    
    @Override
    public Date getTimestamp(String nick) {
        try {
            return timeOut.get(nick);
        } catch(Exception e) {
            e.printStackTrace();
        }
        return null;
    }
     
    @Override
    public void clockIn(String nick) {
        if (userExists(nick)) {
            if (!timeOut.containsKey(nick)) {
                timeOut.put(nick, new Date(System.currentTimeMillis()));
            } else {
                timeOut.get(nick).setTime(System.currentTimeMillis());
            }
        }
    }
    
    @Override
    public long getDiffDate(String nick) {
        return (new Date(System.currentTimeMillis())).getTime() - timeOut.get(nick).getTime();
    }
    
    @Override
    public void deconnect(String nick) {
        if(userExists(nick)) {
            if (timeOut.containsKey(nick)) {
                timeOut.remove(nick);
            }
        }
    }
    
    @Override
    public String getList() {
        return timeOut.toString();
    }
    
    @Override
    public void endOfTime(ConnectivityHandler connectivityHandler) {
        Iterator it = timeOut.keySet().iterator();
        while(it.hasNext()) {
            String nick = (String) it.next();
            if(this.getDiffDate(nick) / 1000 >= timeToDeco) {
                connectivityHandler.disconnect(nick);
                timeOut.remove(nick);
            }
        }
    }
}
