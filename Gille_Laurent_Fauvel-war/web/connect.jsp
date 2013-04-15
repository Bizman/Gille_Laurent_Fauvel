<%-- 
    Document   : connect
    Created on : 15 avr. 2013, 10:21:27
    Author     : Alex
--%>

<%@page import="javax.naming.InitialContext"%>
<%@page import="session.ConnectivityHandlerInterface"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    private ConnectivityHandlerInterface connectHandler = null;
    
    public void jspInit() {
        try {
            connectHandler = (ConnectivityHandlerInterface) (new InitialContext()).lookup(ConnectivityHandlerInterface.class.getName());
        } catch (Exception ex) {
            System.err.println("Exception: " + ex.getMessage());
        }
    }
%>

<%
    boolean connected;
    String nick = (String) request.getParameter("nick");
    String pwd = (String) request.getParameter("pwd");
    
    // Si l'utilisateur est déjà connecté
    if (session.getAttribute("nick") != null) {
        response.sendRedirect("room.jsp");
    }
    
    // Si les champs sont vides on redirigie vers la page de connexion
    if (nick == null || pwd == null) {
        response.sendRedirect("index.jsp");
    }

    connected = (connectHandler.connect(nick, pwd) == ConnectivityHandlerInterface.CONNECTION_OK);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Connexion</title>
    </head>
    <script>window.setTimeout("location = 'room.jsp';", 2000);</script>
    <body>
        <h2>Connexion à votre compte</h2>
        <%
           if (connected) {
               session.setAttribute("nick", nick);
        %>
               <p>Bienvenue <strong><%= nick %></strong>!</p>
               <p>Vous allez être redirigé vers votre espace personnel dans 2 secondes</p>  
        <%
           } else {
        %>
               <p>L'utilisateur <strong><%= nick %></strong> n'existe pas</p>
        <%
           }
        %>
    </body>
</html>
