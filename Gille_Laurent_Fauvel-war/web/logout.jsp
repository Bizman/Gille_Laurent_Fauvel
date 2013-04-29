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
        <link rel="stylesheet" href="css/style.css" type="text/css" />
    </head>
    <script>window.setTimeout("location = 'index.jsp';", 3000);</script>
    <body>
        <div id="header">
            <h1>Pierre # Feuille # Ciseaux</h1>
            <p> > O. Fauvel-Jaeger, A. Gille, A. Laurent</p>
        </div>
        <p id="header-line" class="line"></p>
        <div id="body-wrap">
            <h2>Vous êtes maintenant déconnecté.</h2>
            <h2>Au revoir.</h2>
            <p style="color:gray;">Vous allez être redirigé vers la page d'<a href="index.jsp">accueil</a>.</p>
        </div>
    </body>
</html>
