<%-- 
    Document   : room
    Created on : 19 mars 2013, 15:25:47
    Author     : Alex
--%>
<%@page import="jeu.Room"%>
<%@page import="session.ConnectivityHandlerInterface"%>
<%@page import="javax.sound.midi.SysexMessage"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="persistence.Player"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    private ConnectivityHandlerInterface connectHandler;
    
    public void jspInit() {
        try {
            connectHandler = (ConnectivityHandlerInterface) (new InitialContext()).lookup(ConnectivityHandlerInterface.class.getName());
        } catch (Exception e) {
            System.out.println("JEE sucks");
        }
    }
    
    // Room
    Room r = Room.getInstance();
%>

<%
    String nick = (String) session.getAttribute("nick");
    out.println("Le nick: " + nick);
    if(!connectHandler.userExists(nick)) {
        String redirectURL = "index.jsp";
        response.sendRedirect(redirectURL);
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>O. Fauvel - A. Gille - A. Laurent - SI4 2013</title>
    </head>
    <body>
        <h1>ROOM!</h1>
        Liste des joueurs connectés :
        Pseudo      Etat
        <%  
            out.println(r.showPlayers());
            
            String type = (String) request.getParameter("req-type");
            if ("playVsComp".equals(type)) {
                String redirectURL = "game.jsp";
                response.sendRedirect(redirectURL);
                return;
            }
        %>
        <form method="POST">
            <input type="hidden" name="req-type" value="playVsComp" />
            <p><input type="submit" name="gameVsComp" value="Player vs Computer" /></p>
        </form>
        <form methode="POST">
            <input type="hidden" name="req-type" value="disconnect" />
            <p><input type="submit" value="Déconnecter" /></p>
        </form>
    </body>
</html>
