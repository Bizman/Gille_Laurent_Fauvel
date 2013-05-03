/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package session;

import javax.ejb.Remote;
import java.util.Date;
/**
 *
 * @author Olivier
 */
@Remote
public interface TimerSession {
    
    public boolean userExists(String nick);
    public Date getTimestamp(String nick);
    public void clockIn(String nick);
    public long getDiffDate(String nick);
    public void deconnect(String nick);
    //public String getList();
    public void endOfTime(ConnectivityHandler connectivityHandler);   
    
}
