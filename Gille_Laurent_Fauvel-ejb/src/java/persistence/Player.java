/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package persistence;

/**
 *
 * @author Olivier
 */
import javax.persistence.*;
//import javax.persistence.OneToMany;

@Entity

public class Player implements java.io.Serializable{
    
   private String firstName;
   private String lastName;
   private String nickName;
   private String password;
   private String mail;
   private int score;
   
   public Player() {
       
   }
   public Player(String firstName, String lastName, String nickName, String password, String mail, int score) {
       setFirstName(firstName);
       setLastName(lastName);
       setNickName(nickName);
       setPassword(password);
       setMail(mail);
       setScore(score);
   }
   public String getFirstName() {
       return firstName;
   }
   public String getLastName() {
       return lastName;
   }
   @Id
   @Column(name="NickName")
   public String getNickName() { //primary Key
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
