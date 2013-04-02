<%-- 
    Document   : game
    Created on : 29 mars 2013, 10:12:49
    Author     : Olivier
--%>
<%@page import="jeu.*"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%!
    private Game game = new Game();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>O. Fauvel - A. Gille - A. Laurent - SI4 2013</title>
    </head>
    <body>
        
        <%        
            String computerChoise = null;
            String playerChoise = (String) request.getParameter("req-type");
            if(playerChoise == null) {
                playerChoise = "Null";
            }
            int compChoise = (int) (Math.random() * 3);
            if(compChoise == 0){
                computerChoise = "pierre";
            } else if (compChoise == 1) {
                computerChoise = "feuille";
            } else if (compChoise == 2) {
                computerChoise = "ciseaux";
            }
            out.println("Player Choise : " + playerChoise + "\n");
            out.println("Computer Choise : " + computerChoise);
            
            String resultat = game.winner("Player", "Computer", playerChoise, computerChoise);
            out.println(resultat);
            
        %>
        
        <h1>Salle de Jeu !</h1>
        <form method="POST">
            <input type="hidden" name="req-type" value="pierre" />
            <p><input type="submit" name="pierre" value="pierre" /></p>
        </form>
        <form method="POST">
            <input type="hidden" name="req-type" value="feuille" />
            <p><input type="submit" name="feuille" value="feuille" /></p>
        </form>
        <form method="POST">
            <input type="hidden" name="req-type" value="ciseaux" />
            <p><input type="submit" name="ciseaux" value="ciseaux" /></p>
        </form>
    </body>
</html>
