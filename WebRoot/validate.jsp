<%@page import="com.syc.shopping.user"%>
<%
 response.setContentType("text/xml");
 response.setHeader("Cache-Control", "no-store");//http1.1
 response.setHeader("Pragma", "no-cache");//http1.0
 response.setDateHeader("Expires", 0);
 String username=request.getParameter("username");
 boolean exit=user.usernameExist(username);
 response.getWriter().write("<msg>"+exit+"</msg>");
%>
