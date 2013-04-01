<%-- 
    Document   : index
    Created on : 12 mars 2013, 16:09:59
    Author     : Olivier
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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>O. Fauvel - A. Gille - A. Laurent - SI4 2013</title>
        <style type="text/css">
            
        </style>
    </head>
    <body>
        <h1>Bienvenue!</h1>
        <%
            String prenom = (String) request.getParameter("prenom");
            String nom = (String) request.getParameter("nom");
            String email = (String) request.getParameter("email");
            String pwd = (String) request.getParameter("pwd");
            String nick = (String) request.getParameter("nick");
            String type = (String) request.getParameter("req-type");
            
            out.println("Connecté: " + connectHandler.test());
            
            if ("subscribe".equals(type)) {
                if (prenom != null &&  nom != null && email != null &&  pwd != null &&  nick != null) {

                    if (prenom.length() > 0 && email.length() > 0 && pwd.length() > 0 && nom.length() > 0 && nick.length() > 0) {
                        int r = connectHandler.subscribe(nick, prenom, nom, pwd, email);

                        if (r == ConnectivityHandlerInterface.SUBSCRIBE_OK) {
                            out.println("Vous êtes inscrit avec le pseudo '" + nick + "'. Vous pouvez vous connecter à votre espace utilisateur.");
                        } else if (r == ConnectivityHandlerInterface.NICK_TAKEN) {
                            out.println("Pseudo déjà utilisé!");
                        } else if (r == ConnectivityHandlerInterface.MAIL_TAKEN) {
                            out.println("Email déjà utilisé!");
                        }
                    } else {
                        out.println("Formulaire incomplet!");
                    }
                } 
            } else {
                    %>
                    <h2>Inscription</h2>
                    <form method="post">
                        <p><label>Pseudo</label><input type="text" name="nick" /></p>
                        <p><label>Prénom</label><input type="text" name="prenom" /></p>
                        <p><label>Nom</label><input type="text" name="nom" /></p>
                        <p><label>Email</label><input type="email" name="email" /></p>
                        <p><label>Mot de passe</label><input type="password" name="pwd" /></p>
                        <input type="hidden" name="req-type" value="subscribe" />
                        <p><input type="submit" name="send" value="Envoyer" /></p>
                    </form>
                    <%
            }
            
            if ("connect".equals(type)) {
                int r = connectHandler.connect(nick, pwd);
                
                if (r == ConnectivityHandlerInterface.BAD_INFO) {
                    out.println("Utilisateur inconnu. Les données peuvent être erronées.");
                } else {
                    out.println("Connexion effectuée.");
                }
            } else {
        %>
        <h2>Connexion</h2>
        <form method="POST">
            <p><label>Login</label><input type="text" name="nick" /></p>
            <p><label>Mot de passe</label><input type="text" name="pwd" /></p>
            <input type="hidden" name="req-type" value="connect" />
            <p><input type="submit" name="send" value="Envoyer" /></p>
        </form>
        <%
               }
        %>
    </body>
</html>
