/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package session;

import javax.ejb.Stateless;
import javax.ejb.LocalBean;

/**
 *
 * @author Alex
 */
@Stateless
@LocalBean
public class ConnectivityHandler {

    public void subscribe(String nick, String firstName, String lastName, String password, String email) {
        
    }

    public void connect(String nick, String password) {
        
    }
}
