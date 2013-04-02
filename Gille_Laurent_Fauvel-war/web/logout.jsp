<%
    session.invalidate();
    String redirectURL = "room.jsp";
    response.sendRedirect(redirectURL);
    return;
%>