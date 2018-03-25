<%@page import="com.syc.category.Category"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@include file="sessioncheck.jsp"%>
<%
	request.setCharacterEncoding("gbk");
	String str=request.getParameter("id");
	int pid=0;
	if(str!=null){
	pid=Integer.parseInt(str);
	}
	String action = request.getParameter("action");
	if (action != null && action.equals("add")) {
		String description = request.getParameter("description");
		String name = request.getParameter("name");
		pid=Integer.parseInt(request.getParameter("pid"));
		if(pid!=0){
		Category.addchildCategory(pid, name, description);
		}else{
		Category.addtopCategory(name, description);
		}
		out.println("添加成功！");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>Insert title here</title>
</head>
<body>
	<form action="addCategory.jsp" method="post">
		<input type="hidden" name="action" value="add">
		<input type="hidden" name="pid" value=<%=pid %>>
		<table align="center" border="1">
			<tr>
			<%if(pid==0){%>
				<th align="center" colspan="2">添加主类别</th>
				<%} else{%>
				<th align="center" colspan="2">添加子类别</th>
				<%} %>
			</tr>
			<tr>
				<td>类别名称：</td>
				<td><input type="text" style="width: 185px; " name="name"></td>
			</tr>
			<tr>
				<td>类别描述：</td>
				<td><textarea rows="15" name="description"></textarea></td>
			</tr>
			<tr>
				<td align="center" colspan="2"><input type="submit" value="提交"></td>
			</tr>
		</table>
	</form>
</body>
</html>