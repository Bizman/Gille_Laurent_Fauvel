/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jeu;

/**
 *
 * @author user
 */
public class Room {
    
    /** Récupère l'instance unique de la class Singleton.<p>
    * Remarque : le constructeur est rendu inaccessible
    */
    public static Room getInstance() {
        if (null == instance) { // Premier appel
            instance = new Room();
        }
        return instance;
    }

    /** Constructeur redéfini comme étant privé pour interdire
    * son appel et forcer à passer par la méthode <link
    */
    private Room() {
    }

    /** L'instance statique */
    private static Room instance;
}