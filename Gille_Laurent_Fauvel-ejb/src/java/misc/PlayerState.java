/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package misc;

/**
 *
 * @author Alex
 */
public enum PlayerState {
    CONNECTED("Connecté"),
    PLAYING("Occupé"),
    DISCONNECTED("Déconnecté");
    
    public String text;
    PlayerState(String str) {
        text = str;
    } 
};
