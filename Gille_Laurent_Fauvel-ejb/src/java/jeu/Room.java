package jeu;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import persistence.Player;
import session.PlayerSession;

public class Room {

    private HashMap<String, Boolean> players;
    //private List<Player> players;
    private List<Game> games;
     /** L'instance statique */
    private static Room room;
    
     /** Constructeur redéfini comme étant privé pour interdire
    * son appel et forcer à passer par la méthode <link
    */
    private Room() {    }
    
    public static Room getInstance() {
        if (null == room) { // Premier appel
            room = new Room();
        }
        return room;
    }

   public void Connexion(Player p){
       players.put(p.getNickName(), false);
   }
   
   public String showPlayers(){
       String list = new String();
       HashMap map = new HashMap();
       Set cles = map.keySet();
       Iterator it = cles.iterator();
       while (it.hasNext()){
            String nickname = (String) it.next(); 
            Boolean etat = (Boolean) map.get(nickname);
            list += nickname + "        " + etat + "\n";   
       }
       return list;
   }
}