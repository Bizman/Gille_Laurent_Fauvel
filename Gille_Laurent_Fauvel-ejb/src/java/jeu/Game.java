/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jeu;

public class Game {
    private enum choise { pierre, feuille, ciseaux };
    private int nbGame;
    private String player1;
    private String player2;
    private int nbWin1;
    private int nbWin2;
    
    public Game() {
        this.player1 = "player1";
        this.player2 = "player2";
        this.nbGame = 1;
        this.nbWin1 = 0;
        this.nbWin2 = 0;
    }
    
    public void setName(String player1, String player2) {
        this.player1 = player1;
        this.player2 = player2;
    }
    
    public String winner(String choise1, String choise2) {
        String result = "";
        String winner = "";
        this.nbGameIncr();
        if(choise1.equals(choise2)) {
            winner += "EGALITE";
        } else if (choise1.equals("pierre")) {
            if(choise2.equals("ciseaux")) {
                this.winner(player1);
                winner += player1;
            } else {
                this.winner(player2);
                winner += player2;
            }
        } else if (choise1.equals("ciseaux")) {
            if(choise2.equals("feuille")) {
                this.winner(player1);
                winner += player1;
            } else {
                this.winner(player2);
                winner += player2;
            }
        } else if (choise1.equals("feuille")) {
            if(choise2.equals("pierre")) {
                this.winner(player1);
                winner += player1;
            } else {
                this.winner(player2);
                winner += player2;
            }
        }
        if(result.equals("EGALITE")) {
            return winner;
        }
        if(this.nbWin1 >= 2 || this.nbWin2 >= 2) {
            result += "Game is over !";
        }
        return result + "GAGNANT : " + winner;
    }
    
    private void winner(String playerWinner) {
        if(playerWinner.equals(player1))
            this.nbWin1++;
        if(playerWinner.equals(player2))
            this.nbWin2++;
    }
    
    public boolean haveWinner() {
        if(this.nbWin1 >= 2 || this.nbWin2 >= 2)
            return true;
        return false;
    }
    
    private void nbGameIncr() {
        this.nbGame ++;
    }
}
