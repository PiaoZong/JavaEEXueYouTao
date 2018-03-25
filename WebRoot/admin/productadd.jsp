<%@page import="java.util.List"%>
<%@page import="com.syc.category.Category"%>
<%@page import="com.syc.product.productManager"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.syc.product.product"%>
<%@page import="java.util.Iterator"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@include file="sessioncheck.jsp"%>
<%
	request.setCharacterEncoding("gbk");
	String action = request.getParameter("action");
	if (action != null && action.equals("add")) {
		String description = request.getParameter("description");
		String name = request.getParameter("name");
		double normalprice=Double.parseDouble(request.getParameter("normalprice"));
		double memberprice=Double.parseDouble(request.getParameter("memberprice"));
		int categoryid=Integer.parseInt(request.getParameter("categoryid"));
		product p=new product();
		p.setName(name);
		p.setDescription(description);
		p.setNormalprice(normalprice);
		p.setMemberprice(memberprice);
		p.setPdate(new Timestamp(System.currentTimeMillis()));
		p.setCategoryid(categoryid);
		productManager.getInstance().addproduct(p);
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
	<form action="productadd.jsp" method="post">
		<input type="hidden" name="action" value="add">
		<table align="center" border="1">
			<tr>
			<th colspan="2">产品上柜</th>
			</tr>
			<tr>
				<td>产品名称：</td>
				<td><input type="text" style="width: 185px; " name="name"></td>
			</tr>
			<tr>
				<td>产品描述：</td>
				<td><textarea rows="15" name="description"></textarea></td>
			</tr>
			<tr>
				<td>原价：</td>
				<td><input type="text" style="width: 185px; " name="normalprice"></td>
			</tr>
			<tr>
				<td>活动价：</td>
				<td><input type="text" style="width: 185px; " name="memberprice"></td>
			</tr>
			<tr>
				<td>所属类别：</td>
				<td><select style="width: 190px; " name="categoryid">
				<%
				List<Category> categories= Category.getCategories();
				for (Iterator<Category> iterator = categories.iterator(); iterator
						.hasNext();) {
					Category c = iterator.next();
					if(c.isLeaf()==true){
				%>
				<option value=<%=c.getId() %>><%=c.getName() %></option>
				<%}} %>
				</select></td>
			</tr>
			<tr>
				<td align="center" colspan="2"><input type="submit" value="提交"></td>
			</tr>
		</table>
	</form>
</body>
</html>