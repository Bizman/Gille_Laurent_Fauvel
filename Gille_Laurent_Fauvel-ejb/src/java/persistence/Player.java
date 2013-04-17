package persistence;

import java.io.Serializable;
import javax.persistence.*;
import misc.PlayerState;

@Entity
@NamedQueries(
    value={
        @NamedQuery(name="checkEmail", query="SELECT p FROM Player p WHERE p.mail = :mail"),
        @NamedQuery(name="verifyUserData", query="SELECT p FROM Player p WHERE p.nickName = :nickName AND p.password = :password")
    })
public class Player implements Serializable {

    @Id
    @Column(name = "NickName")
    private String nickName;
    private String firstName;
    private String lastName;
    private String password;
    private String mail;
    private int score;
    
    @Enumerated(EnumType.STRING)
    private PlayerState etat;

    public Player() {}

    public Player(String firstName, String lastName, String nickName, String password, String mail, int score) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.mail = mail;
        this.nickName = nickName;
        this.password = password;
        this.score = score;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

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
    
    public PlayerState getEtat() { return etat; }

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
