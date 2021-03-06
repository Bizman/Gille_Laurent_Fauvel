package session;

import javax.annotation.PostConstruct;
import javax.ejb.Stateful;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import persistence.Player;

@Stateful
public class GameHandlerBean implements GameHandler {

   @PersistenceContext(unitName="GamePersistence")
   private EntityManager em;
     
   private int nbGame;
   private String player1;
   private String player2;
   private String choise1;
   private String choise2;
   private String oldChoise1;
   private String oldChoise2;
   private int score1;
   private int score2;
   private Boolean end;
   
   @PostConstruct
   public void initPlayer() {
        this.player1 = "player1";
        this.player2 = "player2";
        this.choise1 = "aucun";
        this.choise2 = "aucun";
        this.oldChoise1 = "aucun";
        this.oldChoise2 = "aucun";
        this.nbGame = 1;
        this.score1 = 0;
        this.score2 = 0;
        this.end = false;
   }

   @Override
   public void setPlayers(String player1, String player2) {
        this.player1 = player1;
        this.player2 = player2;
   }
    
     @Override
   public void setChoix(String c, String p) {
        if(p.equals(player1)) {
            this.choise1 = c;
        }
        else if (p.equals(player2)) {
            this.choise2 = c;
        }
   }
     
    @Override
   public String getChoix(String p) {
         if(p.equals(player1)) {
             return this.choise1;
         } else if (p.equals(player2)) {
             return this.choise2; 
         }   
         return "aucun";
   }
    @Override
    public String getOpponentChoix(String p) {
        if(p.equals(player1) && !choise1.isEmpty()) {
            return choise2;
        } else if(p.equals(player2) && !choise2.isEmpty()) {
            return choise1;
        }
        return "aucun";
    }
    @Override
   public String getOldChoix(String p) {
         if(p.equals(player1)) {
             return this.oldChoise1;
         }
         else if (p.equals(player2)) {
             return this.oldChoise2; 
         }   
         return "aucun";
   }
    
     @Override
   public int getScore(String p) {
         if(p.equals(player1)) {
             return this.score1;
         }
         else if (p.equals(player2)) {
             return this.score2; 
         }   
         return 0;
   }
   
    @Override
   public void play() {
        if(choise1.equalsIgnoreCase("aucun") || choise2.equalsIgnoreCase("aucun")) {
            return;
        } else {
            nbGame++;
            if(!choise1.equals(choise2)){
                if (choise1.equalsIgnoreCase("pierre")) {
                    if(choise2.equalsIgnoreCase("ciseaux")) {
                        score1++;
                    } else {
                        score2++;
                    }
                } else if (choise1.equalsIgnoreCase("ciseaux")) {
                    if(choise2.equalsIgnoreCase("feuille")) {
                        score1++;
                    } else {
                        score2++;
                    }
                } else if (choise1.equalsIgnoreCase("feuille")) {
                    if(choise2.equalsIgnoreCase("pierre")) {
                        score1++;
                    } else {
                        score2++;
                    }
                }
            }
            this.oldChoise1 = this.choise1;
            this.oldChoise2 = this.choise2;
        }
        choise1 = "aucun";
        choise2 = "aucun";
    }
    
    @Override
   public int checkScore(){
       if(score1 == 2){
           return 1;
       }
       else if(score2 == 2) {
           return 2;
       }
       else {
           return 0;
       } 
   }
    
    @Override
    public void end(String nick){
        if(end == false){
           end = true;
           if(!nick.equals("computer")) {
                Player p = em.find(Player.class, nick);
                p.setScore();
                em.merge(p);
           }
        }
    }
    
    @Override
    public void reinitialisation() {
        this.player1 = "player1";
        this.player2 = "player2";
        this.choise1 = "aucun";
        this.choise2 = "aucun";
        this.oldChoise1 = "aucun";
        this.oldChoise2 = "aucun";
        this.nbGame = 1;
        this.score1 = 0;
        this.score2 = 0;
        this.end = false;
    }
    
   @Override
   public int getTour(){
       return nbGame;
   }
}