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
			<th colspan="8" align="center"><h3>���в�Ʒ</h3></th>
		</tr>
		<tr>
			<th>��Ʒ����</th>
			<th>��Ʒ����</th>
			<th>ԭ��</th>
			<th>���</th>
			<th>�Ϲ�ʱ��</th>
			<th>�������</th>
			<th colspan="2">����</th>
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
					color="red">ɾ��</font></a></td>
			<td><a href="addimage.jsp?id=<%=p.getId()%>" target="detail"><font
					color="red">���ͼƬ</font></a></td>
		</tr>
		<%
			}
		%>
		<tr>
		    <th colspan="8">
			<a href="productlist.jsp?pageno=1>">��ҳ</a>
			<a href="productlist.jsp?pageno=<%=pageno - 1%>">��һҳ</a>
			<a href="productlist.jsp?pageno=<%=pageno + 1%>">��һҳ</a>
			<a href="productlist.jsp?pageno=<%=pm.totalpages(pagesize)%>">βҳ</a>
			</th>
		</tr>
	</table>
</body>
</html>