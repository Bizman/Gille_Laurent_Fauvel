package session;

import javax.ejb.Stateless;
import javax.ejb.LocalBean;

@Stateless
@LocalBean
public class ConnectivityHandler {

    public void subscribe(String nick, String firstName, String lastName, String password, String email) {
        
    }

    public void connect(String nick, String password) {
        
    }
}
