/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package session;

import javax.ejb.Remote;
import persistence.Player;

/**
 *
 * @author Alex
 */
@Remote
public interface ConnectivityHandler {
    
    public static final int SUBSCRIBE_OK = 0;
    public static final int NICK_TAKEN = 1;
    public static final int MAIL_TAKEN = 2;
    public static final int CONNECTION_OK = 3;
    public static final int BAD_INFO = 4;
    public static final int ALREADY_CONNECTED = 5;

    public int subscribe(String nick, String firstName, String lastName, String password, String email);
    public int connect(String nick, String password);
    public boolean userExists(String nick);
    public void disconnect(String nick);
    public Player getPlayer(String nick);
}