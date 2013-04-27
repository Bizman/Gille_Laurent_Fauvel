package session;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import javax.ejb.Remote;

/**
 *
 * @author Alex
 */
@Remote
public interface GameHandler {

   public void setPlayers(String player1, String player2);
    
   public void setChoix(String c, String p);
     
   public String getOldChoix(String p);
   
   public String getChoix(String p);
   
   public String getOpponentChoix(String p);
    
   public int getScore(String p);
   
   public int getTour();
        
   public void play();
   
   public int checkScore();

   public void end(String nick);

   public void reinitialisation();
}
