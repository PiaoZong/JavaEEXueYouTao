<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@page import="com.syc.category.Category"%>
<%@include file="sessioncheck.jsp"%>
<%
int id=Integer.parseInt(request.getParameter("id"));
int pid=Integer.parseInt(request.getParameter("pid"));
Category.deleteCategory(id, pid);

 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
</head>
<body>
	<h3>删除成功!</h3>
</body>
<script type="text/javascript">
	window.parent.main.document.location.reload();
</script>
</html>