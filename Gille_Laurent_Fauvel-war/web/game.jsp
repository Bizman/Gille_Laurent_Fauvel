<%@page import="session.GameHandler"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="session.RoomHandler"%>
<%@page import="persistence.Defi"%>
<%@page import="session.ConnectivityHandler"%>

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

<%   
    gamehandler.setPlayers(Player1, Player2);
    String choix = "";
    String computerChoise = "";

    choix = (String) request.getParameter("choix");
    if (choix != null) {
        if (choix.equals("backToRoom")) {
            response.sendRedirect("room.jsp");
            roomHandler.removeDefi(d.getId());
            gamehandler.reinitialisation();
            return;
        } else {
            if (opponent.equals("computer")) {
                int choice = (int) Math.round(Math.random()*2);      
                if (choice == 0) {
                    computerChoise = "Pierre";
                } else if (choice == 1) {
                    computerChoise = "Feuille";
                } else if (choice == 2) {
                    computerChoise = "Ciseaux";
                }
                gamehandler.setChoix(computerChoise,  "computer");
            } 
            gamehandler.setChoix(choix, user);
        }
    }
    
    boolean stillPlaying = true;
    boolean winner = false;
    if(gamehandler.checkScore() == 0) {
        gamehandler.play();
    } else {
        if((user.equals(Player1) && gamehandler.checkScore() == 1) || (user.equals(Player2) && gamehandler.checkScore() == 2)){
            gamehandler.end(user);
            winner = true;
        }
        stillPlaying = false;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
        <title>O. Fauvel - A. Gille - A. Laurent - SI4 2013</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
        <script>window.setTimeout("location = 'game.jsp?id=<%= id %>';", 3000);</script>
    </head>
    <body>
        <div id="header">
            <h1>Pierre # Feuille # Ciseaux</h1>
            <p> > O. Fauvel-Jaeger, A. Gille, A. Laurent</p>
        </div>
        <p id="header-line" class="line"></p>
        <div id="body-wrap">
            <h2 class="centered-content">Tour n°<%= gamehandler.getTour() %></h2>
            
                <div class="centered-content">
                        <div class="box">
                        <h2>Score</h2>
                        <h2 class="centered-content">(<i><%= user %></i>) <%= gamehandler.getScore(user) %> : <%= gamehandler.getScore(opponent) %> (<i><%= opponent %></i>)</h2>
                        </div>

                        <div class="box">
                        <h2>Choix</h2>
                        <h2 class="centered-content">(<i><%= user %></i>) <%= gamehandler.getOldChoix(user) %> : <%= gamehandler.getOldChoix(opponent) %> (<i><%= opponent %></i>)</h2>
                        </div>
                </div>
                        
        <%
            if (stillPlaying) {
        %>
        
        <div class="centered-content">
            <form method="POST" action="game.jsp?id=<%= id %>">
                    <input class="fat-button" type="submit" name="choix" value="Pierre" />
                    <input class="fat-button" type="submit" name="choix" value="Feuille" />
                    <input class="fat-button" type="submit" name="choix" value="Ciseaux" />
            </form>
        </div>
                    
        <%  
            } else {
                if (winner) {
        %>
        
            <h2> Vous avez gagné ! </h2>
            
        <%    } else {   %>
        
            <h2> Vous avez perdu ! </h2>
            
        <%       
              }
            }                 
        %>
        
        <form method="POST" action="game.jsp?id=<%= id %>">
            <input type="hidden" name="choix" value="backToRoom" />
            <p><input type="submit" name="backToRoom" value="Return to the room" /></p>
        </form>
        </div>
    </body>
</html>
