<%@page import="com.syc.cart.cart"%>
<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
    <%
    	int id=0;
    	cart c=(cart)session.getAttribute("cart");
    	String action=request.getParameter("action");
    	if(action!=null && action.equals("all")){
    		if(c!=null){
    		c.deleteallproducts();
    		response.sendRedirect("cart.jsp");
    		}
    	}else{
    	try{
    		if(c!=null){
    		id=Integer.parseInt(request.getParameter("id"));
    		c.deleteproduct(id);
    		}
    	}catch(NumberFormatException e){
    	response.sendRedirect("cart.jsp");
    	}
    	session.setAttribute("cart", c);
    	response.sendRedirect("cart.jsp");
    	}
     %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
</head>
<body>

</body>
</html>