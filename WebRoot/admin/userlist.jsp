<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.syc.shopping.user"%>
<%@page import="java.util.List"%>
<%@include file="sessioncheck.jsp"%>
<%
	List<user> users = user.getUsers();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>
	<table align="center" border="1">
		<tr>
			<th colspan="6" align="center"><h3>所有注册用户</h3></th>
		</tr>
		<tr>
			<th>ID</th>
			<th>用户名</th>
			<th>密码</th>
			<th>邮箱</th>
			<th>注册时间</th>
			<th>操作</th>
		</tr>
		<%
			for (Iterator<user> iterator = users.iterator(); iterator.hasNext();) {
				user u = iterator.next();
		%>
		<tr>
			<td><%=u.getId()%></td>
			<td><%=u.getUsername()%></td>
			<td><%=u.getPassword()%></td>
			<td><%=u.getMail()%></td>
			<td><%=u.getRdata()%></td>
			<td><a href="deleteuser.jsp?id=<%=u.getId()%>" target="detail"><font
					color="red">删除</font></a></td>
		</tr>
		<%
			}
		%>
	</table>
</body>
</html>