<%@page import="session.ConnectivityHandler"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!    
    ConnectivityHandler connectivityHandler;
    String USER_NICK;
    
    public void jspInit() {
        try {
            connectivityHandler = (ConnectivityHandler) (new InitialContext()).lookup(ConnectivityHandler.class.getName());
        } catch (Exception e) {
            System.out.println("disconnect.jsp init exception: " + e.getMessage());
        }
    }
%>

<%
    USER_NICK = (String) session.getAttribute("USER_NICK");
    if (USER_NICK != null) {
        connectivityHandler.disconnect(USER_NICK);
        session.invalidate();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gille - Laurent - Fauvel - Déconnexion</title>
    </head>
    <script>window.setTimeout("location = 'index.jsp';", 3000);</script>
    <body>
        <h1>Déconnecté</h1>
        <p>Vous êtes maintenant déconnecté. Au revoir.</p>
    </body>
</html>
