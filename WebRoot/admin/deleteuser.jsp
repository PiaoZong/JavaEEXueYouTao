<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@page import="com.syc.shopping.user"%>
<%@include file="sessioncheck.jsp"%>
<%
	int id = Integer.parseInt(request.getParameter("id"));
	user.deleteUser(id);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>删除</title>
</head>
<body>
	<h3>删除成功!</h3>
</body>
<script type="text/javascript">
	window.parent.main.document.location.reload();
</script>
</html>