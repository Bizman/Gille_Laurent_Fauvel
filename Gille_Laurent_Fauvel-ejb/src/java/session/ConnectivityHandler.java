package session;

import javax.ejb.Stateless;

@Stateless
public class ConnectivityHandler implements ConnectivityHandlerInterface {

    @Override
    public int subscribe(String nick, String firstName, String lastName, String password, String email) {
        return ConnectivityHandlerInterface.SUBSCRIBE_OK;
    }

    @Override
    public int connect(String nick, String password) {
        return ConnectivityHandlerInterface.CONNECTION_OK;
    }
    
}
