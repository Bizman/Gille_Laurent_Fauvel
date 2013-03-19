/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package persistence;

/**
 *
 * @author Olivier
 */
public class Player {
    
   private String firstName;
   private String lastName;
   private String nickName;
   private String password;
   private String mail;
   private int score;
   
   public Player() {
       
   }
   public String getFirstName() {
       return firstName;
   }
   public String getLastName() {
       return lastName;
   }
   public String getNickName() {
       return nickName;
   }
   public String getPassword() {
       return password;
   }
   public String getMail() {
       return mail;
   }
   public int getScore() {
       return score;
   }
   public void setFirstName(String newFirstName) {
       firstName = newFirstName;
   }
   public void setLastName(String newLastName) {
       lastName = newLastName;
   }
   public void setNickName(String newNickName) {
       nickName = newNickName;
   }
   public void setPassword(String newPassword) {
       password = newPassword;
   }
   public void setMail(String newMail) {
       mail = newMail;
   }
   public void setScore(int newScore) {
       score = newScore;
   }
}
