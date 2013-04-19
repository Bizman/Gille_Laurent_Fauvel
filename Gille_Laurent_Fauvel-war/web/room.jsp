<%-- 
    Document   : room
    Created on : 19 mars 2013, 15:25:47
    Author     : Alex
--%>

<%@page import="java.util.List"%>
<%@page import="persistence.Defi"%>
<%@page import="session.RoomHandler"%>
<%@page import="jeu.Room"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Iterator"%>
<%@page import="session.ConnectivityHandler"%>
<%@page import="javax.sound.midi.SysexMessage"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="persistence.Player"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%!
    private RoomHandler roomHandler;
    
    public void jspInit() {
        try {
            roomHandler = (RoomHandler) (new InitialContext()).lookup(RoomHandler.class.getName());
        } catch (Exception e) {
            System.out.println("room.jsp init exception: " + e.getMessage());
        }
    }
    
    // Room
    Room room = Room.getInstance();
%>

<%
    // Rédirection si non connecté
    String USER_NICK = (String) session.getAttribute("USER_NICK");
    if(USER_NICK == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    // Récupération des joueur en ligne
    List<Player> connectedPlayersList = roomHandler.getPlayers(USER_NICK);
    
    // Récupération des défi
    List<Defi> defiList = roomHandler.getDefi(USER_NICK);
%>

<%
    String action = (String) request.getParameter("action");
    
    if (action != null) {
        if ("defier".equals(action)) {
            String opponent = (String) request.getParameter("opponent");

            if (opponent != null && !opponent.isEmpty()) {
                roomHandler.defier(USER_NICK, opponent);
            }
        } else if ("accepter-defi".equals(action)) {
            String did = (String) request.getParameter("did");
            
            if (did != null && !did.isEmpty()) {
                out.write(USER_NICK + " accepte le défi " + did);
            }
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>O. Fauvel - A. Gille - A. Laurent - SI4 2013</title>
        <link rel="stylesheet" href="style.css" type="text/css" />
        <!--<script>window.setTimeout("location = 'room.jsp';", 10000);</script>-->
    </head>
    <body>
        <h1>ROOM!</h1>
        <h2>Bienvenue <%= USER_NICK %>!</h2>
        
        <table>
            <caption>Vos défis</caption>
        <% if (defiList.isEmpty()) { %>

        <tr><td><i>Aucun défi en attente</i></td></tr>

        <% } else { %>
            <tr>
                <th>Joueur</th>
                <th>Score</th>
                <th>Actions</th>
            </tr>   
        <%      for (Defi d : defiList) { %>

        <tr>
            <td><%= d.getSecondPlayer().getNickName() %></td>
            <td><%= d.getSecondPlayer().getScore() %></td>
            <td><a href="?action=accepter-defi&did=<%= d.getId() %>">Accepter</a></td>
        </tr>

        <%
                }
            }
        %>
        </table>
            
        <table>
            <caption>Joueurs connectés</caption>
            <tr>
                <th>Pseudo</th>
                <th>Etat</th>
                <th>Actions</th>
            </tr>
        <% for (Player p : connectedPlayersList){ %>
            <tr>
                <td><%= p.getNickName() %></td>
                <td><%= p.getEtat() %></td>
                <td><a href="room.jsp?action=defier&opponent=<%= p.getNickName() %>">Défier</a></td>
            </tr>
        <% }

            String type = (String) request.getParameter("req-type");
            String name = (String) request.getParameter("name-joueur");
            if ("playVsComp".equals(type)) {
                String redirectURL = "game.jsp";
                response.sendRedirect(redirectURL);
                return;
            } else if("playVsplay".equals(type)) {
                out.print(name);            
            } else if("valider".equals(type)) {
                String redirectURL = "game.jsp";
                response.sendRedirect(redirectURL);
                return;
            }
        %>
        </table>
        <p><a href="?action=pvc">Joueur contre l'ordinateur</a></p>
        <p><a href="logout.jsp">Déconnecter</a></p>
    </body>
</html>
