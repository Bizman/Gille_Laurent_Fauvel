/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package session;

import javax.ejb.Singleton;
import javax.ejb.LocalBean;
import javax.ejb.Remote;
/**
 *
 * @author Olivier
 */
@Remote
public interface TimerSession {

    public boolean userExists(String nick);
    public int getTimestamp(String nick);
    public int clockIn(String nick);
    public boolean endOfTime(String nick);

}
