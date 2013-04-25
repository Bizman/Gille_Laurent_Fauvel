<%@page import="session.ConnectivityHandler"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    private ConnectivityHandler connectHandler = null;
    
    public void jspInit() {
        try {
            connectHandler = (ConnectivityHandler) (new InitialContext()).lookup(ConnectivityHandler.class.getName());
        } catch (Exception ex) {
            System.err.println("Exception: " + ex.getMessage());
        }
    }
%>

<%
    int retourConnexion;
    String USER_NICK = (String) request.getParameter("USER_NICK");
    String pwd = (String) request.getParameter("pwd");
    
    // Si l'utilisateur est déjà connecté
    if (session.getAttribute("USER_NICK") != null) {
        response.sendRedirect("room.jsp");
    }
    
    // Si les champs sont vides on redirigie vers la page de connexion
    if (USER_NICK == null || pwd == null) {
        response.sendRedirect("index.jsp");
    }

    retourConnexion = connectHandler.connect(USER_NICK, pwd);
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
           if (retourConnexion == ConnectivityHandler.CONNECTION_OK) {
               session.setAttribute("USER_NICK", USER_NICK);
        %>
               <p>Bienvenue <strong><%= USER_NICK %></strong>!</p>
               <p>Vous allez être redirigé vers votre espace personnel dans 2 secondes</p>  
        <%
           } else if (retourConnexion == ConnectivityHandler.ALREADY_CONNECTED) {
        %>
               <p>L'utilisateur <strong><%= USER_NICK %></strong> est déjà connecté à partir d'un autre ordinateur</p>
        <%
           } else {
        %>
                <p>L'utilisateur <strong><%= USER_NICK %></strong> n'existe pas</p>
        <% } %>
    </body>
</html>
