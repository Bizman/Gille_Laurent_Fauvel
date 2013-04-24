<% response.addHeader("Refresh","3"); %>
<%@page import="java.util.List"%>
<%@page import="persistence.Defi"%>
<%@page import="misc.DefiState"%>
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
 %>
 
 <%
    String id = (String) request.getParameter("id");
    
    Defi d = roomHandler.getDefi(Long.parseLong(id));
    
    if(d.getEtat()==DefiState.VALIDE)
         response.sendRedirect("game.jsp?id="+id);     
  
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>O. Fauvel - A. Gille - A. Laurent - SI4 2013</title>
        <link rel="stylesheet" href="style.css" type="text/css" />
        <script>window.setTimeout("location = 'room.jsp?id="+id+"';", 10000);</script>
    </head>
    <body>
        <h1>Page d'attente!</h1>
        <h2>Vous êtes en attente d'une réponse de votre adversaire</h2>
          
    </body>
</html>
