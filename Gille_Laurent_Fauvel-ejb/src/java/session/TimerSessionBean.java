package session;

import javax.ejb.Timeout;
import javax.ejb.Timer;
import javax.ejb.TimerService;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import javax.annotation.PostConstruct;
import javax.annotation.Resource;
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
    
    @PostConstruct
    public void init() {
        timeOut = new HashMap<String, Date>();
    }
    
    @Override
    public void setTimer(long intervalDuration) {
        timerService.createTimer(intervalDuration, "Created new programmatic timer");
    }
    
    @Override
    public void setConnectHandler(ConnectivityHandler connectHandler) {
        this.connectHandler = connectHandler;
    }
    
    /**
     * Cherche si le "nick" existe dans la base de donnees
     */
    public boolean userExists(String nick) {   
        return em.find(Player.class, nick) != null;
    }
    
    /**
     * Fonction de 'pointage' des utilisateurs.
     * Permet de mettre à jour la date de la dernière preuve d'activité du joueur
     * @author Alexandre Gille
     */
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
    
    /**
     * Callback du timer. Exécute la recherche et la déconnexion des joueurs en inactivité
     * @author Olivier Fauvel
     */
    @Timeout
    public void programmaticTimeout(Timer timer) {
        lastProgrammaticTimeout = new Date(); // On met à jour la date
        this.endOfTime(); // On verifie toutes les personnes connectees
        this.setTimer(timeToDeco * 1000); // On remets re-initialise le timer
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
    
    /**
     * Supprime une personne de liste. Utile dans "room.jsp" lors d'une déconnection "propre"
     * @author Olivier Fauvel
     */
    @Override
    public void deconnect(String nick) {
        if (timeOut.containsKey(nick)) {
            timeOut.remove(nick);
        }
    }
    
    /**
     * Calcule l'écart entre la date de dernière connexion de l'utilisateur et la date du dernier timeOut.
     * @param nick 
     * @return  l'écart en millisecondes
     * @author Olivier Fauvel
     */
    public long getDiffDate(String nick) {
        return this.lastProgrammaticTimeout.getTime() - this.timeOut.get(nick).getTime();
    }
    
    /**
     * Methode qui verifie la periode d'inactivité de chaque personne et déconnecte si la durée d'inactivité est dépassée
     * @author Olivier Fauvel
     */
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