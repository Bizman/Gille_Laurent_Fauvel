<%@page import="javax.naming.InitialContext"%>
<%@page import="session.ConnectivityHandler"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    private ConnectivityHandler connectHandler = null;
    
    public void jspInit() {
        try {
            connectHandler = (ConnectivityHandler) (new InitialContext()).lookup(ConnectivityHandler.class.getName());
        } catch (Exception ex) {
            System.err.println("index.jsp: Exception: " + ex.getMessage());
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>O. Fauvel - A. Gille - A. Laurent - SI4 2013</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
    </head>
    <body>
       <div id="header">
            <h1>Pierre # Feuille # Ciseaux</h1>
            <p> > O. Fauvel-Jaeger, A. Gille, A. Laurent</p>
        </div>
        <p id="header-line" class="line"></p>
        <div id="body-wrap" class="centered-content">
            <div class="form-box">
        <%
            String prenom = (String) request.getParameter("prenom");
            String nom = (String) request.getParameter("nom");
            String email = (String) request.getParameter("email");
            String pwd = (String) request.getParameter("pwd");
            String USER_NICK = (String) request.getParameter("USER_NICK");
            String type = (String) request.getParameter("req-type");
            
            if ("subscribe".equals(type)) {
                if (prenom != null &&  nom != null && email != null &&  pwd != null &&  USER_NICK != null) {

                    if (prenom.length() > 0 && email.length() > 0 && pwd.length() > 0 && nom.length() > 0 && USER_NICK.length() > 0) {
                        int r = connectHandler.subscribe(USER_NICK, prenom, nom, pwd, email);

                        if (r == ConnectivityHandler.SUBSCRIBE_OK) { 
                    %>
                            <p>Bienvenue <strong><%= USER_NICK %></strong>.</p>
                            <p>Vous pouvez vous connecter à votre espace utilisateur.</p>
                    <%  
                        } else if (r == ConnectivityHandler.NICK_TAKEN) {
                    %>
                            <p>Le pseudo <strong><%= USER_NICK %></strong> déjà utilisé!</p>
                            <a href="javascript:history.go(-1);">Retour</a>
                    <%
                        } else if (r == ConnectivityHandler.MAIL_TAKEN) {
                    %>
                            <p>Email déjà utilisé!</p>
                            <a href="javascript:history.go(-1);">Retour</a>
                    <%
                        }
                    } else {
                        out.println("Formulaire incomplet!");
                    }
                } 
            } else {
        %>
            <h2>Inscription</h2>
            <form method="post">
                <p><label>Pseudo</label><input type="text" name="USER_NICK" /></p>
                <p><label>Prénom</label><input type="text" name="prenom" /></p>
                <p><label>Nom</label><input type="text" name="nom" /></p>
                <p><label>Email</label><input type="email" name="email" /></p>
                <p><label>Mot de passe</label><input type="password" name="pwd" /></p>
                <input type="hidden" name="req-type" value="subscribe" />
                <p><input type="submit" name="send" value="Envoyer" /></p>
            </form>
        <%
          }
        %>
            </div>
            <div class="form-box">
                <h2>Connexion</h2>
                <form method="POST" action="connect.jsp">
                    <p><label>Login</label><input type="text" name="USER_NICK" /></p>
                    <p><label>Mot de passe</label><input type="password" name="pwd" /></p>
                    <p><input type="submit" name="send" value="Envoyer" /></p>
                </form>
            </div>
        </div>
    </body>
</html>
