package jeu;

public class Room {

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