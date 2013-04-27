package persistence;

import java.io.Serializable;
import javax.persistence.*;
import misc.PlayerState;
import javax.persistence.NamedQuery;
import javax.persistence.NamedQueries;

@Entity
@NamedQueries(
    value={
        @NamedQuery(name="checkEmail", query="SELECT p FROM Player p WHERE p.mail = :mail"),
        @NamedQuery(name="verifyUserData", query="SELECT p FROM Player p WHERE p.nickName = :nickName AND p.password = :password"),
        @NamedQuery(name="getConnectedPlayers", query="SELECT p FROM Player p WHERE p.etat <> :etat AND p.nickName <> :me")
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
    
    //Initialisation de player Computer
    public Player(String nickName) {
        this.nickName = nickName;
        this.firstName = "computer";
        this.lastName = "computer";
        this.mail = "computer@computer";
        this.password = "computer";
        this.score = 0;
        this.etat = PlayerState.CONNECTED; // L'ordinateur est toujours connecté !
    }

    //Initialisation des autres player
    public Player(String firstName, String lastName, String nickName, String password, String mail, int score) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.mail = mail;
        this.nickName = nickName;
        this.password = password;
        this.score = score;
        this.etat = PlayerState.DISCONNECTED;
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

    public void setScore() {
        score ++;
    }
    
    public void setState(PlayerState etat) {
        this.etat = etat;
    }
}
