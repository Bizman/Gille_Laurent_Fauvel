package session;

import javax.ejb.Remote;
import java.util.Date;
import javax.ejb.Timer;

@Remote
public interface TimerSession {
    
    public void setTimer(long intervalDuration);
    public void setConnectHandler(ConnectivityHandler connectHandler);
    public void clockIn(String nick);
    public Date getLastProgrammaticTimeout();    
    public void deconnect(String nick);
    
}
