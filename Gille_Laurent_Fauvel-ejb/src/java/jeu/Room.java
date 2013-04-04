package jeu;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import persistence.Player;
import session.PlayerSession;

public class Room {
    PlayerSession playerSession = lookupPlayerSessionBean();

    private List<PlayerSession> players;
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
   }

    private PlayerSession lookupPlayerSessionBean() {
        try {
            Context c = new InitialContext();
            return (PlayerSession) c.lookup("java:global/Gille_Laurent_Fauvel/Gille_Laurent_Fauvel-ejb/PlayerSession!session.PlayerSession");
        } catch (NamingException ne) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", ne);
            throw new RuntimeException(ne);
        }
    }
}