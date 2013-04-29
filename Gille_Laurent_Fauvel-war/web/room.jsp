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
    private ConnectivityHandler connectivityHandler;
    
    public void jspInit() {
        try {
            roomHandler = (RoomHandler) (new InitialContext()).lookup(RoomHandler.class.getName());
            connectivityHandler = (ConnectivityHandler) (new InitialContext()).lookup("ejb/ConnectivityHandler");
        } catch (Exception e) {
            System.out.println("room.jsp init exception: " + e.getMessage());
        }
    }
%>

<%
    // Rédirection si non connecté
    String USER_NICK = (String) session.getAttribute("USER_NICK");
    if(USER_NICK == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    int user_points = connectivityHandler.getPlayer(USER_NICK).getScore();
    
    // Récupération des joueur en ligne
    List<Player> connectedPlayersList = roomHandler.getPlayers(USER_NICK);
    
    // Récupération des défi
    List<Defi> defiList = roomHandler.getDefis(USER_NICK);
%>

<%
    String action = (String) request.getParameter("action");
    
    if (action != null) {
        if ("defier".equals(action)) {
            String opponent = (String) request.getParameter("opponent");
            long id = 0;
            id = roomHandler.defier(USER_NICK, opponent);
            if (opponent != null && !opponent.isEmpty() && opponent.equals("computer")) {
                response.sendRedirect("game.jsp?id="+id);
            } else if (opponent != null && !opponent.isEmpty()) {
                response.sendRedirect("waiting.jsp?id="+id);
            }            
        } else if ("accepter-defi".equals(action)) {
            String did = (String) request.getParameter("did");
            
            if (did != null && !did.isEmpty()) {
                //out.write(USER_NICK + " accepte le défi " + did);
                Defi d = roomHandler.getDefi(Long.parseLong(did));
                out.write(" id   " + did + "    " + d.getId() + "   " + d.getEtat());
                roomHandler.accepterDefi(Long.parseLong(did));
                out.write(" id   " + did + "    " + d.getId() + "   " + d.getEtat());
                d = roomHandler.getDefi(Long.parseLong(did));
                response.sendRedirect("game.jsp?id="+did);      
            }
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>O. Fauvel - A. Gille - A. Laurent - SI4 2013</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
        <script>window.setTimeout("location = 'room.jsp';", 5000);</script>
    </head>
    <body>
        <div id="header">
            <h1>Pierre # Feuille # Ciseaux</h1>
            <p> > O. Fauvel-Jaeger, A. Gille, A. Laurent</p>
        </div>
        <p id="header-line" class="line"></p>
        <div id="body-wrap">
            <p><image src="images/user-icon.png" style="margin-right: 4px;" /><strong><%= USER_NICK %></strong>, <%= user_points %> parties gagnées. <a href="logout.jsp">Déconnecter</a></p>
            <div class="centered-content">
                <div class="table-wrap">
                    <table>
                    <caption><h2>Vos défis</h2></caption>

                    <% if (defiList.isEmpty()) { %>

                        <tr><td><i>Aucun défi en attente</i></td></tr>

                    <% } else { %>
                    <thead>
                        <tr>
                            <th>Joueur</th>
                            <th>Score</th>
                            <th>Actions</th>
                        </tr>  
                    </thead>
                    <%      for (Defi d : defiList) { %>
                    <tbody>
                        <tr>
                            <td><%= d.getFirstPlayer().getNickName() %></td>
                            <td><%= d.getFirstPlayer().getScore() %></td>
                            <td><a href="?action=accepter-defi&did=<%= d.getId() %>">Accepter</a>
                        </tr>
                    </tbody>
                    <%
                            }
                        }
                    %>
                    </table>
                </div>
            
            
                <div class="table-wrap">
                    <table>
                        <caption><h2>Joueurs connectés</h2></caption>
                    <% if (connectedPlayersList.isEmpty()) { %>
                    <tbody>
                        <tr>
                            <td><i>Aucun joueur connecté</i></td>
                        </tr>
                    </tbody>
                    <%  } else { %>
                            <thead>
                                <tr>
                                    <th>Pseudo</th>
                                    <th>Etat</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                    <%
                            for (Player p : connectedPlayersList){ 
                                if(!p.getNickName().equals("computer")) {
                    %>
                            <tr>
                                <td><%= p.getNickName() %></td>
                                <td><%= p.getEtat().text %></td>
                                <td><a href="room.jsp?action=defier&opponent=<%= p.getNickName() %>">Défier</a></td>
                            </tr>
                    <% 
                                }
                            }
                        }
                    %>
                        </tbody>
                    </table>
                </div>
            </div>
            <p><a href="room.jsp?action=defier&opponent=computer">Jouer contre l'ordinateur</a></p>
        </div>
    </body>
</html>
