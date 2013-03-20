/**
 * Classe d'identification de clé primaire composite simple
 * Permet de représenter la classe Player par une clé primaire
 * composée de deux attributs de classse.
 * @author Alexandre Gille
 */
package persistence;

import java.io.Serializable;

public class PlayerId implements Serializable {
    
    private String nickName;
    private String mail;
    
    public PlayerId() {}
    public PlayerId(String nick, String email) {
        nickName = nick;
        mail = email;
    }
    
    @Override
    public int hashCode() {
        return nickName.hashCode() + mail.hashCode();
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof PlayerId)) {
            return false;
        }
        PlayerId other = (PlayerId) object;
        if (this.nickName.equals(other.nickName) && this.mail.equals(other.mail)) {
            return false;
        }
        return true;
    }
}
