package session;

import java.util.ArrayList;
import java.util.HashMap;
import javax.ejb.Stateful;
import javax.persistence.*;
import persistence.Player;

@Stateful
public class ConnectivityHandler implements ConnectivityHandlerInterface {
    
    @PersistenceContext(unitName="PlayerSessionPersistence")
    private EntityManager em;
    private String user;
    private HashMap<String, PlayerSession> ps;
    
    public ConnectivityHandler() {
        ps = new HashMap<String, PlayerSession>();
    }
    
    @Override
    public int subscribe(String nick, String firstName, String lastName, String password, String email) {
        Player p = new Player(firstName, lastName, nick, password, email, 0);
        
        if (em.find(Player.class, nick) != null) {
            return ConnectivityHandler.NICK_TAKEN;
        } else if (!em.createNamedQuery("checkEmail").setParameter("mail", email).getResultList().isEmpty()) {
            return ConnectivityHandler.MAIL_TAKEN;
        } else {
            em.persist(p);
            return ConnectivityHandler.SUBSCRIBE_OK;
        }
    }

    @Override
    public int connect(String nick, String password) {
        if (em.createNamedQuery("verifyUserData").setParameter("nickName", nick).setParameter("password", password).getResultList().isEmpty()) {
            return ConnectivityHandler.BAD_INFO;
        } else {
            user = nick;
            return ConnectivityHandlerInterface.CONNECTION_OK;
        }
    }

    @Override
    public boolean userExists(String nick) {
        if(!ps.containsKey(nick)) {
            PlayerSession newPlayer = new PlayerSession();
            newPlayer.setNick(nick);
            ps.put(nick, newPlayer);
        }   
        return em.find(Player.class, nick) != null;
    }
    @Override
    public void addDefi(String nick, String name) {
        if(ps.containsKey(name)) {
            PlayerSession tmp = ps.get(name);
            tmp.addDefi(nick);
        }
    }
    
    @Override 
    public ArrayList getDefi(String nick) {
        if(ps.containsKey(nick)) {
            return ps.get(nick).getDefi();
        }
        return new ArrayList<String>();
    }
    @Override
    public HashMap getPlayerSession() {
        return this.ps;
    }
    @Override
    public boolean getDefiAck(String nick) {
        if(ps.containsKey(nick))
            return ps.get(nick).getDefiAck();
        return false;
    }
    
    @Override
    public void setDefiAck(String nick, boolean ack) {
        if(ps.containsKey(nick)) {
            PlayerSession tmp = ps.get(nick);
            tmp.setDefiAck(ack);
        }
    }
}