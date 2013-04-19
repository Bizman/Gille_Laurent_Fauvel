<%-- 
    Document   : game
    Created on : 29 mars 2013, 10:12:49
    Author     : Olivier
--%>
<%@page import="jeu.*"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="session.ConnectivityHandler"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    private Game game = new Game();
%>
<%!
    private ConnectivityHandler connectHandler;
    
    public void jspInit() {
        try {
            connectHandler = (ConnectivityHandler) (new InitialContext()).lookup(ConnectivityHandler.class.getName());
        } catch (Exception e) {
            System.out.println("JEE sucks");
        }
    }
%>

<%
    String USER_NICK = (String) session.getAttribute("USER_NICK");
    out.println("Le USER_NICK: " + USER_NICK);
    if(!connectHandler.userExists(USER_NICK)) {
        String redirectURL = "index.jsp";
        response.sendRedirect(redirectURL);
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>O. Fauvel - A. Gille - A. Laurent - SI4 2013</title>
    </head>
    <body>
        
        <%        
            game.setName(USER_NICK, "Computer");
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
        %>
        <p></p>
        <%
            out.println( USER_NICK + " Choise : " + playerChoise);
        %>
        <p></p>
        <%
            out.println("Computer Choise : " + computerChoise);
        %>
        <p></p>
        <%
            String resultat = game.winner(playerChoise, computerChoise);
            out.print(resultat);
            if(!game.haveWinner()) {
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
        <% } else {
        %>
        <p> Il y a un gagnant !!!! </p>
        <%        
            }
            String type = (String) request.getParameter("req-type");
            if ("room".equals(type)) {
                String redirectURL = "room.jsp";
                response.sendRedirect(redirectURL);
                return;
            }
        %>
        <form method="POST">
            <input type="hidden" name="req-type" value="room" />
            <p><input type="submit" name="returnToTheRoom" value="Return to the room" /></p>
        </form>
    </body>
</html>
