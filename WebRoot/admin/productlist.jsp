<%@page import="com.syc.product.productManager"%>
<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@page import="com.syc.category.Category"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.syc.product.product"%>
<%@page import="java.util.List"%>
<%@include file="sessioncheck.jsp"%>
<%
	int pagesize = 4;
	productManager pm = null;
	pm = productManager.getInstance();
	int pageno = pm.checkpageno(request.getParameter("pageno"),
			pagesize);
	List<product> products = pm.getProducts(pageno, pagesize);
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
			<th colspan="8" align="center"><h3>所有产品</h3></th>
		</tr>
		<tr>
			<th>商品名称</th>
			<th>商品描述</th>
			<th>原价</th>
			<th>活动价</th>
			<th>上柜时间</th>
			<th>所属类别</th>
			<th colspan="2">操作</th>
		</tr>
		<%
			for (Iterator<product> iterator1 = products.iterator(); iterator1
					.hasNext();) {
				product p = iterator1.next();
		%>
		<tr>
			<td><%=p.getName()%></td>
			<td><%=p.getDescription()%></td>
			<td><%=p.getNormalprice()%></td>
			<td><%=p.getMemberprice()%></td>
			<td><%=p.getPdate()%></td>
			<%
				List<Category> categories = Category.getCategories();
					for (Iterator<Category> iterator2 = categories.iterator(); iterator2
							.hasNext();) {
						Category c = iterator2.next();
						if (c.isLeaf() == true && c.getId() == p.getCategoryid()) {
			%>
			<td><%=c.getName()%></td>
			<%
				}
					}
			%>
			<td><a href="productdelete.jsp?id=<%=p.getId()%>" target="detail"><font
					color="red">删除</font></a></td>
			<td><a href="addimage.jsp?id=<%=p.getId()%>" target="detail"><font
					color="red">添加图片</font></a></td>
		</tr>
		<%
			}
		%>
		<tr>
		    <th colspan="8">
			<a href="productlist.jsp?pageno=1>">首页</a>
			<a href="productlist.jsp?pageno=<%=pageno - 1%>">上一页</a>
			<a href="productlist.jsp?pageno=<%=pageno + 1%>">下一页</a>
			<a href="productlist.jsp?pageno=<%=pm.totalpages(pagesize)%>">尾页</a>
			</th>
		</tr>
	</table>
</body>
</html>