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
            System.out.println("JEE sucks");
        }
    }
%>

<%
    String id = (String) request.getParameter("id");
    Defi d = roomHandler.getDefi(Long.parseLong(id));
  
    String Player1 = d.getFirstPlayer().getNickName();
    String Player2 = d.getSecondPlayer().getNickName();
    
    String user = (String) session.getAttribute("USER_NICK");
    String opponent;
    
    if( user.equals(Player1))
        opponent = Player2;
       else opponent = Player1;
    
    out.println("Vous: " + user + "     Score :" + gamehandler.getScore(user) + "\n Votre adversaire: " + opponent + "     Score :" + gamehandler.getScore(opponent) +"\n");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>O. Fauvel - A. Gille - A. Laurent - SI4 2013</title>
    </head>
    <body>
        
        <%        
            gamehandler.setPlayers(Player1, Player2);
            
            String choix = (String) request.getParameter("req-type");
            if(choix == null) 
                choix = "";
            else {
                gamehandler.setChoix(choix, user);
            }

        %>
        <p></p>
        <%
            out.println("Mon choix : " + gamehandler.getChoix(user));
        %>
        <p></p>
        <%
            out.println("Son choix : " + gamehandler.getChoix(opponent));
        %>
        <p></p>
         <%
            out.println("Tour : " + gamehandler.getChoix(opponent));
        %>
        <p></p>
        <%
            if(gamehandler.checkScore()==0){
                gamehandler.play();
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
        <% }
            else {
        %>
        <h1> Partie terminée </h1>
        <p></p>
        <%       
             if(gamehandler.checkScore()==1){
                 if(user.equals(Player1)){
                     gamehandler.end(user);
        %>
        <h2> Vous avez gagné ! </h2>
        <p></p>
        <%       
                        } else {  
                    gamehandler.end(opponent);                     
        %>
        <h2> Vous avez perdu !  </h2>
        <p></p>
        <%       
                        }
                }
           }
        %>
       
        <form method="POST">
            <input type="hidden" name="req-type" value="room" />
            <p><input type="submit" name="returnToTheRoom" value="Return to the room" /></p>
        </form>
    </body>
</html>
