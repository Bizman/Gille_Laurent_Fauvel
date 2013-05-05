package session;

import java.util.Date;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.ejb.Schedule;
import javax.ejb.Singleton;
import javax.ejb.Stateless;
import javax.ejb.Timeout;
import javax.ejb.Timer;
import javax.ejb.TimerService;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import javax.annotation.PostConstruct;
import javax.ejb.Singleton;
import javax.persistence.*;
import persistence.Player;
   

@Singleton(mappedName = "ejb/TimerSession")
public class TimerSessionBean implements TimerSession {
    @Resource
    TimerService timerService;
    
    @PersistenceContext(unitName="GamePersistence")
    private EntityManager em;    
    private HashMap<String, Date> timeOut;
    private static int timeToDeco = 30;
    private ConnectivityHandler connectHandler = null;
    private Date lastProgrammaticTimeout;
    private Logger logger = Logger.getLogger(
            "com.sun.tutorial.javaee.ejb.timersession.TimerSessionBean");
    
    @PostConstruct
    public void init() {
        timeOut = new HashMap<String, Date>();
    }
    
    @Override
    public void setTimer(long intervalDuration) {
        logger.info("Setting a programmatic timeout for "
                + intervalDuration + " milliseconds from now.");
        Timer timer = timerService.createTimer(intervalDuration, 
                "Created new programmatic timer");
    }
    
    @Override
    public void setConnectHandler(ConnectivityHandler connectHandler) {
        this.connectHandler = connectHandler;
    }
    
    //Cherche si le "nick" existe dans la base de donnees
    public boolean userExists(String nick) {   
        return em.find(Player.class, nick) != null;
    }
    
    //Renvoie la liste des personnes connectees
    @Override
    public String getList() {
        return this.timeOut.toString();
    }
    
    //Permet de mettre à jour la date des personnes connectees
    @Override
    public void clockIn(String nick) {
        if (userExists(nick)) {
            if (!timeOut.containsKey(nick)) {
                timeOut.put(nick, new Date());
            } else {
                timeOut.get(nick).setTime(new Date().getTime());
            }
        }
    }
    
    //Methode qui s'execute a chaque fin de timer
    @Timeout
    public void programmaticTimeout(Timer timer) {
        this.setLastProgrammaticTimeout(new Date()); // On met à jour la date
        this.endOfTime(); // On verifie toutes les personnes connectees
        this.setTimer(30000); // On remets re-initialise le timer
        logger.info("Programmatic timeout occurred."); 
    }
    
    public void setLastProgrammaticTimeout(Date lastTimeout) {
        this.lastProgrammaticTimeout = lastTimeout;
    }
       
    @Override
    public Date getLastProgrammaticTimeout() {
        if (this.lastProgrammaticTimeout != null) {
            return this.lastProgrammaticTimeout;
        }
        //A changer...
        return new Date();
    }
    
    //Supprime une personne de liste. Utile dans "room.jsp" lors d'une déconnection "propre"
    @Override
    public void deconnect(String nick) {
        if (timeOut.containsKey(nick)) {
            timeOut.remove(nick);
        }
    }
    
    public long getDiffDate(String nick) {
        return this.getLastProgrammaticTimeout().getTime() - this.timeOut.get(nick).getTime();
    }
    
    //Methode qui verifie la periode d'inactivité de chaque personne et déconnecte si c'est trop long
    public void endOfTime() {
        Iterator it = timeOut.keySet().iterator();
        while(it.hasNext()) {
            String nick = (String) it.next();
            if(this.getDiffDate(nick) / 1000 >= timeToDeco) {
                this.connectHandler.disconnect(nick);
                timeOut.remove(nick);
            }
        }
    }
}