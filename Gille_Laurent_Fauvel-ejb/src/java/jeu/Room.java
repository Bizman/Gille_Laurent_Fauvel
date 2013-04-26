package jeu;

import session.GameHandlerBean;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;


public class Room {

    private HashMap<String, Boolean> players;
    //private List<GameHandlerBean> games;
     /** L'instance statique */
    private static Room room;
    
     /** Constructeur redéfini comme étant privé pour interdire
    * son appel et forcer à passer par la méthode <link
    */
    private Room() {    
        players = new HashMap<String, Boolean>();
    }
    
    public static Room getInstance() {
        if (null == room) { // Premier appel
            room = new Room();
        }
        return room;
    }

   public void Connexion(String nick){
       players.put(nick, false);
   }
   
   public String showPlayers(){
       String list = new String();
       Set cles = this.players.keySet();
       Iterator it = cles.iterator();
       while (it.hasNext()){
            String nickname = (String) it.next(); 
            Boolean etat = (Boolean) this.players.get(nickname);
            list += nickname + " " + etat + "\n";   
       }
       return list;
   }
   
   public HashMap showPlayers2() {
       return this.players;
   }
}