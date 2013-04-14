/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package session;

import java.util.ArrayList;
import java.util.HashMap;
import javax.ejb.Remote;

/**
 *
 * @author Alex
 */
@Remote
public interface ConnectivityHandlerInterface {
    
    public static final int SUBSCRIBE_OK = 0;
    public static final int NICK_TAKEN = 1;
    public static final int MAIL_TAKEN = 2;
    public static final int CONNECTION_OK = 3;
    public static final int BAD_INFO = 4;

    public int subscribe(String nick, String firstName, String lastName, String password, String email);

    public int connect(String nick, String password);
    public boolean userExists(String nick);
    public HashMap getPlayerSession();
    public void addDefi(String nick, String name);
    public ArrayList getDefi(String nick);
    public boolean getDefiAck(String nick);
    public void setDefiAck(String nick, boolean ack);
}
