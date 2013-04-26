/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package persistence;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.NamedQueries;
import misc.DefiState;

/**
 *
 * @author Alex
 */
@Entity
@NamedQueries(
    value={
        @NamedQuery(name="waitingDefi", query="SELECT d FROM Defi d WHERE d.player2.nickName = :me"),
        @NamedQuery(name="getDefi", query="SELECT d FROM Defi d WHERE d.id = :id")
    })
public class Defi implements Serializable {
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private Player player1; // joueur qui défi
    private Player player2; // joueur défié ou ordinateur
    
    @Enumerated(EnumType.STRING)
    private DefiState etat;

    public Defi() {
        player1 = null;
        player2 = null;
        etat = DefiState.ATTENTE;
    }
    
    public Defi(Player p1, Player p2) {
        player1 = p1;
        player2 = p2;
        etat = DefiState.ATTENTE;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id;}
    public DefiState getEtat() { return etat; }
    public Player getFirstPlayer() { return player1; }
    public Player getSecondPlayer() { return player2; }
    public void setEtat() { this.etat =  DefiState.VALIDE;}

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Defi)) {
            return false;
        }
        Defi other = (Defi) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "persistence.Defi[ id=" + id + " ]";
    }    
}
