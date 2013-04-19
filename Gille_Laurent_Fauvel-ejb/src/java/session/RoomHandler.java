/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package session;

import java.util.List;
import javax.ejb.Remote;
import persistence.Defi;
import persistence.Player;

/**
 *
 * @author Alex
 */
@Remote
public interface RoomHandler {
    public static final int DISCONNECTED = 1;
    
    public int defier(String a, String b);
    public List<Player> getPlayers(String myNick);
    public List<Defi> getDefi(String myNick);
}
