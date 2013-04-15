<%-- 
    Document   : room
    Created on : 19 mars 2013, 15:25:47
    Author     : Alex
--%>
<%@page import="jeu.Room"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Iterator"%>
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
    if(nick == null) {
        response.sendRedirect("index.jsp");
        return;
    } else {
        r.Connexion(nick);
    }
%>
<%
    if(connectHandler.getDefiAck(nick)) {
        response.sendRedirect("game.jsp");
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
        Liste des joueurs qui vous défi : 
        <%
            for(Iterator i = connectHandler.getDefi(nick).iterator(); i.hasNext();) {
                String nickDef = (String) i.next();
        %>
        <ul>
            <li><%= nickDef %></li>
        </ul>
        <form method="POST">
            <input type="hidden" name="req-type" value="valider" />
            <input type="submit" name="gameVsGame" value="Valider !" />
        </form>        
        <%
            }
        %><p></p>
        Liste des joueurs connectés :
        Pseudo      Etat
        <%  
            HashMap<String, Boolean> p = r.showPlayers2();
            Set cles = p.keySet();
            Iterator it = cles.iterator();
            while (it.hasNext()){
                String nickname = (String) it.next(); 
                Boolean etatB = (Boolean) p.get(nickname);
                String etat = "Libre";
                if(etatB)
                    etat = "Occupé";
                if(!nickname.equals(nick)) {
        %>
        <ul>
            <li><% out.print(nickname + " ==> " + etat);%></li>
        </ul>
        <form method="POST">
            <input type="hidden" name="req-type" value="playVsplay" />
            <input type="hidden" name="name-joueur" value="<% out.print(nickname);%>" />
            <input type="submit" name="gameVsGame" value="Defier <% out.print(nickname); %>" />
        </form>
        <%
               }
            }
        %>
        <%   
            String type = (String) request.getParameter("req-type");
            String name = (String) request.getParameter("name-joueur");
            if ("playVsComp".equals(type)) {
                String redirectURL = "game.jsp";
                response.sendRedirect(redirectURL);
                return;
            } else if("playVsplay".equals(type)) {
                out.print(name);
                connectHandler.addDefi(nick, name);               
            } else if("valider".equals(type)) {
                String redirectURL = "game.jsp";
                response.sendRedirect(redirectURL);
                return;
            }
        %>
        <form method="POST">
            <input type="hidden" name="req-type" value="playVsComp" />
            <p><input type="submit" name="gameVsComp" value="Player vs Computer" /></p>
        </form>
        <form method="POST">
            <input type="hidden" name="req-type" value="disconnect" />
            <p><input type="submit" value="Déconnecter" /></p>
        </form>
    </body>
</html>
