/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jeu;

public class Game {
    private enum choise { pierre, feuille, ciseaux };
    
    public Game() {
        
    }
    public String test() {
        return "test";
    }
    public String winner(String player1, String player2, String choise1, String choise2) {
        if(choise1.equals(choise2)) {
            return "EGALITE";
        } else if (choise1.equals("pierre")) {
            if(choise2.equals("ciseaux")) {
                return "Gagnant : " + player1;
            } else {
                return "Gagnat : " + player2;
            }
        } else if (choise1.equals("ciseaux")) {
            if(choise2.equals("feuille")) {
                return "Gagnant : " + player1;
            } else {
                return "Gagnat : " + player2;
            }
        } else if (choise1.equals("feuille")) {
            if(choise2.equals("pierre")) {
                return "Gagnant : " + player1;
            } else {
                return "Gagnat : " + player2;
            }
        }
        return "Problem with choisies";
    }
}
