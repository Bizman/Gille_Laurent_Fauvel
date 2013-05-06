<% response.addHeader("Refresh","3"); %>
<%@page import="session.GameHandler"%>
<%@page import="jeu.*"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="session.RoomHandler"%>
<%@page import="persistence.Defi"%>
<%@page import="session.ConnectivityHandler"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%!
    private RoomHandler roomHandler;
    private GameHandler gamehandler;
    
    public void jspInit() {
        try {
            roomHandler = (RoomHandler) (new InitialContext()).lookup(RoomHandler.class.getName());
            gamehandler = (GameHandler) (new InitialContext()).lookup(GameHandler.class.getName());
        } catch (Exception e) {
            System.out.println("game.jsp init exception: " + e.getMessage());
        }
    }
%>

<%
    String Player1 = null;
    String Player2 = null;
    Defi d = null;
    String id = null;
    String user = null;
    
    try {
        id = (String) request.getParameter("id");
        d = roomHandler.getDefi(Long.parseLong(id));
        Player1 = d.getFirstPlayer().getNickName();
        Player2 = d.getSecondPlayer().getNickName();
        user = (String) session.getAttribute("USER_NICK");
    } catch(Exception e) {
        response.sendRedirect("room.jsp");
        return;
    }
    
    String opponent;    
    if( user.equals(Player1)) {
        opponent = Player2;
    } else {
        opponent = Player1;
    } 
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>O. Fauvel - A. Gille - A. Laurent - SI4 2013</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
    </head>
    <body>
        <div id="header">
            <h1>Pierre # Feuille # Ciseaux</h1>
            <p> > O. Fauvel-Jaeger, A. Gille, A. Laurent</p>
        </div>
        <p id="header-line" class="line"></p>
        <div id="body-wrap">
            <h2>Score</h2>
            <h2 class="centered-content">(<i><%= user %></i>) <%= gamehandler.getScore(user) %> : <%= gamehandler.getScore(opponent) %> (<i><%= opponent %></i>)</h2>
            <p><%= gamehandler.getOldChoix(user) %> : <%= gamehandler.getOldChoix(opponent) %>  (Dernier Choix)</p>
        <%   
            gamehandler.setPlayers(Player1, Player2);
            String choix = "";
            String computerChoise = "";
            
            choix = (String) request.getParameter("req-type");
            if (choix != null) {
                if (choix.equals("backToRoom")) {
                    response.sendRedirect("room.jsp");
                    roomHandler.removeDefi(d.getId());
                    gamehandler.reinitialisation();
                } else {
                    if (opponent.equals("computer")) {
                        int choise = (int) Math.round(Math.random()*2);      
                        if (choise == 0) {
                            computerChoise = "pierre";
                        } else if (choise == 1) {
                            computerChoise = "feuille";
                        } else if (choise == 2) {
                            computerChoise = "ciseaux";
                        }
                        gamehandler.setChoix(computerChoise,  "computer");
                    } 
                    gamehandler.setChoix(choix, user);
                }
            }
        %>
        <p><span><strong>Mon choix</strong></span><span><%= gamehandler.getChoix(user) %></span></p>
        <p><span><strong>Son choix</strong></span><span><%= gamehandler.getOpponentChoix(user) %></span></p>
        <p><span><strong>Tour</strong></span><span><%= gamehandler.getTour() %></span></p>
        <p></p>
        <%
            if(gamehandler.checkScore()==0){
                gamehandler.play();
        %>
        <form method="POST">
            <input type="hidden" name="req-type" value="pierre" />
            <p><input type="submit" name="pierre" value="pierre" /></p>
            <input type="hidden" name="req-type" value="feuille" />
            <p><input type="submit" name="feuille" value="feuille" /></p>
            <input type="hidden" name="req-type" value="ciseaux" />
            <p><input type="submit" name="ciseaux" value="ciseaux" /></p>
        </form>
        <%  } else {
                if((user.equals(Player1) && gamehandler.checkScore() == 1) || (user.equals(Player2) && gamehandler.checkScore() == 2)){
                    gamehandler.end(user);
        %>
        <h2> Vous avez gagné ! </h2>
        <p></p>
        <%      } else {  %>
        <h2> Vous avez perdu ! </h2>
        <p></p>
        <%       
                }
           }
        %>
        <form method="POST">
            <input type="hidden" name="req-type" value="backToRoom" />
            <p><input type="submit" name="backToRoom" value="Return to the room" /></p>
        </form>
        </div>
    </body>
</html>
