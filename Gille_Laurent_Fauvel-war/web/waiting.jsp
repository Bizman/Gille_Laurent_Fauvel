<%@page import="java.util.List"%>
<%@page import="persistence.Defi"%>
<%@page import="misc.DefiState"%>
<%@page import="session.RoomHandler"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Iterator"%>
<%@page import="session.ConnectivityHandler"%>
<%@page import="javax.sound.midi.SysexMessage"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="persistence.Player"%>

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
    Defi d = null;
    String action = (String) request.getParameter("action");
    
    try {
        d = roomHandler.getDefi(Long.parseLong(id));
    } catch (Exception e) {
        response.sendRedirect("room.jsp");
        return;
    }

    // Actions
    if (action != null && !action.isEmpty()) {
        if ("annuler".equals(action)) {
            roomHandler.removeDefi(d.getId());
            response.sendRedirect("room.jsp");
            return;
        }
    }
    
    if (d == null) {
        response.sendRedirect("room.jsp");
        return;
    }
    
    if (d.getEtat() == DefiState.VALIDE) {
         response.sendRedirect("game.jsp?id="+id);
         return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>O. Fauvel - A. Gille - A. Laurent - SI4 2013</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
        <script>window.setTimeout("location.reload(true)", 3000);</script>
    </head>
    <body>
        <div id="header">
            <h1>Pierre # Feuille # Ciseaux</h1>
            <p> > O. Fauvel-Jaeger, A. Gille, A. Laurent</p>
        </div>
        <p id="header-line" class="line"></p>
        <div id="body-wrap">
            <h2>Vous �tes en attente d'une r�ponse de votre adversaire</h2>
            <p class="centered-content"><input type="button" onClick="javascript:top.location.href='?action=annuler&id=<%= d.getId() %>'" value="Annuler le d�fi" /></p>
        </div>
    </body>
</html>