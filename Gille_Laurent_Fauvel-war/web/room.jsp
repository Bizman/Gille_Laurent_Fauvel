<%-- 
    Document   : room
    Created on : 19 mars 2013, 15:25:47
    Author     : Alex
--%>

<%@page import="persistence.Player"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Player player = (Player) session.getAttribute("nick");
    if(player == null) {
        String redirectURL = "index.jsp";
        response.sendRedirect(redirectURL);
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>O. Fauvel - A. Gille - A. Laurent - SI4 2013</title>
    </head>
    <body>
        <h1>ROOM!</h1>
        <%        
            String type = (String) request.getParameter("req-type");
            if ("playVsComp".equals(type)) {
                String redirectURL = "game.jsp";
                response.sendRedirect(redirectURL);
                return;
            }
        %>
        <form method="POST">
            <input type="hidden" name="req-type" value="playVsComp" />
            <p><input type="submit" name="gameVsComp" value="Player vs Computer" /></p>
        </form>
    </body>
</html>
