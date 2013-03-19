/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package session;

import java.io.Serializable;
import javax.ejb.Remote;

/**
 *
 * @author Alex
 */
@Remote
public interface ConnectivityHandlerInterface extends Serializable {
    
    public static final int SUBSCRIBE_OK = 0;
    public static final int NICK_TAKEN = 1;
    public static final int MAIL_TAKEN = 2;
    public static final int CONNECTION_OK = 3;

    public int subscribe(String nick, String firstName, String lastName, String password, String email);

    public int connect(String nick, String password);
}
