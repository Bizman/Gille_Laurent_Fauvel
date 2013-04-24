<%-- 
    Document   : game
    Created on : 29 mars 2013, 10:12:49
    Author     : Olivier
--%>
<%@page import="jeu.*"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="session.RoomHandler"%>
<%@page import="persistence.Defi"%>
<%@page import="session.ConnectivityHandler"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    private Game game = new Game();
%>
<%!
    private ConnectivityHandler connectHandler;
    private RoomHandler roomHandler;
    
    public void jspInit() {
        try {
            connectHandler = (ConnectivityHandler) (new InitialContext()).lookup(ConnectivityHandler.class.getName());
            roomHandler = (RoomHandler) (new InitialContext()).lookup(RoomHandler.class.getName());
        } catch (Exception e) {
            System.out.println("JEE sucks");
        }
    }
%>

<%
    String id = (String) request.getParameter("id");
    Defi d = roomHandler.getDefi(Long.parseLong(id));
    String Player1 = (String) session.getAttribute("USER_NICK");
    String Player2;
    
    if(d.getFirstPlayer().getNickName().equals(Player1))
        Player2=d.getSecondPlayer().getNickName();
    else Player2=d.getFirstPlayer().getNickName();
    
    out.println("Vous: " + Player1 + "\n Votre adversaire: " + Player2 + "\n");
    /*if(!connectHandler.userExists(Player1)) {
        String redirectURL = "index.jsp";
        response.sendRedirect(redirectURL);
    }*/
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>O. Fauvel - A. Gille - A. Laurent - SI4 2013</title>
    </head>
    <body>
        
        <%        
            game.setName(Player1, "Player2");
            String player1Choise = (String) request.getParameter("req-type");
            if(player1Choise == null) {
                player1Choise = "Null";
            }
            
            
            
        %>
        <p></p>
        <%
            out.println("Mon choix : " + player1Choise);
        %>
        <p></p>
        <%
            out.println("Son choix : " + computerChoise);
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
