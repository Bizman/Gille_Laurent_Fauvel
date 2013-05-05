<%@page import="session.*"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    private ConnectivityHandler connectHandler = null;
    private TimerSession timerSession = null;
    private int COUNTDOWN = 2; //timeout seconds
    
    public void jspInit() {
        try {
            connectHandler = (ConnectivityHandler) (new InitialContext()).lookup("ejb/ConnectivityHandler");
            timerSession = (TimerSession) (new InitialContext()).lookup("ejb/TimerSession");
        } catch (Exception ex) {
            System.err.println("Exception: " + ex.getMessage());
        }
    }
%>

<%
    int retourConnexion;
    String USER_NICK = (String) request.getParameter("USER_NICK");
    String pwd = (String) request.getParameter("pwd");
    
    // Si l'utilisateur est déjà authentifié 
    if (session.getAttribute("USER_NICK") != null) {
        response.sendRedirect("room.jsp");
        return;
    }
    
    // Si les champs sont vides on redirige vers la page de connexion
    if (USER_NICK == null || USER_NICK.isEmpty() || pwd == null || pwd.isEmpty()) {
        response.sendRedirect("index.jsp");
        return;
    }

    retourConnexion = connectHandler.connect(USER_NICK, pwd);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css" type="text/css" />
        <title>Connexion</title>
    </head>
    <script>window.setTimeout("location = 'room.jsp';", <%= COUNTDOWN*1000 %>);</script>
    <body>
        <div id="header">
            <h1>Pierre # Feuille # Ciseaux</h1>
            <p> > O. Fauvel-Jaeger, A. Gille, A. Laurent</p>
        </div>
        <p id="header-line" class="line"></p>
        <div id="body-wrap" class="info-box centered-content">
        <%
            if (retourConnexion == ConnectivityHandler.CONNECTION_OK) {
               session.setAttribute("USER_NICK", USER_NICK);
               timerSession.setTimer(30000);
               timerSession.setConnectHandler(connectHandler);
        %>
               <p>Bienvenue <strong><%= USER_NICK %></strong>!</p>
               <p>Vous allez être redirigé vers votre espace personnel dans <%= COUNTDOWN %> secondes.</p>  
        <%
            } else if (retourConnexion == ConnectivityHandler.ALREADY_CONNECTED) {
        %>
               <p>L'utilisateur <strong><%= USER_NICK %></strong> est déjà connecté à partir d'un autre ordinateur.</p>
               <p>S'il s'agit d'une erreur, veuillez réessayer plus tard.</p>
        <%
            } else if (retourConnexion == ConnectivityHandler.BAD_INFO) {
        %>  
                <p>Coordonnées invalides</p>
        <%  } else { %>
                <p>L'utilisateur <strong><%= USER_NICK %></strong> n'existe pas</p>
        <% } %>
        </div>
    </body>
</html>
