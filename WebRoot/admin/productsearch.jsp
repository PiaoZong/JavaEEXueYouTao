<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Date"%>
<%@page import="com.syc.product.productManager"%>
<%@page import="com.syc.product.product"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.List"%>
<%@page import="com.syc.category.Category"%>
<%@page import="java.util.Iterator"%>
<%@ page language="java" contentType="text/html; charset=GB18030"
	pageEncoding="GB18030"%>
<%@include file="sessioncheck.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	request.setCharacterEncoding("GB18030");
	String action = request.getParameter("action");
	Timestamp ts=null;
	int pageno=0;
	int categoryid=0;
	int normalprice=0;
	int memberprice=0;
	String keywords=null;
	int pagesize=3;
	int pagecount=0;
	List<product> products =new ArrayList<product>();
	if (action != null && action.equals("search")) {
		try{ pageno=Integer.parseInt(request
				.getParameter("pageno"));				
				}catch(NumberFormatException e){
				pageno=1;
				}
		categoryid = Integer.parseInt(request
				.getParameter("categoryid"));
		normalprice = Integer.parseInt(request
				.getParameter("normalprice"));
		memberprice = Integer.parseInt(request
				.getParameter("memberprice"));
		keywords = request.getParameter("keywords");
		try {
			ts = Timestamp.valueOf(request.getParameter("date"));
		} catch (IllegalArgumentException e) {
			ts = null;
		}
		pagecount=productManager.getInstance().convert(products,categoryid, normalprice, memberprice, keywords, ts, pageno, pagesize);
		if(products.isEmpty()){
		products=null;
		}
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<script language="javascript" type="text/javascript"
	src="My97DatePicker/WdatePicker.js"></script>
<title>Insert title here</title>
</head>
<body>
	<form action="productsearch.jsp" method="post">
		<input type="hidden" name="action" value="search">
		<table align="center">
			<tr>
				<th>��Ʒ��� <select name="categoryid">
						<option value="0" selected="selected">�������</option>
						<%
							List<Category> categories = Category.getCategories();
							for (Iterator<Category> iterator = categories.iterator(); iterator
									.hasNext();) {
								Category c = iterator.next();
								if (c.isLeaf() == true) {
						%>
						<option value="<%=c.getId()%>"><%=c.getName()%></option>
						<%
							}
							}
						%>
				</select>
				</th>
				<th>ԭ�ۣ�<select name="normalprice"><option value="0">��</option>
						<option value="1">0-500Ԫ</option>
						<option value="2">500-1000Ԫ</option>
						<option value="3">1000-1500Ԫ</option>
						<option value="4">1500-2000Ԫ</option>
						<option value="5">2000-2500Ԫ</option>
						<option value="6">2500-3000Ԫ</option>
						<option value="7">3000Ԫ����</option></select></th>
				<th>��ۣ�<select name="memberprice"><option value="0">��</option>
						<option value="1">0-500Ԫ</option>
						<option value="2">500-1000Ԫ</option>
						<option value="3">1000-1500Ԫ</option>
						<option value="4">1500-2000Ԫ</option>
						<option value="5">2000-2500Ԫ</option>
						<option value="6">2500-3000Ԫ</option>
						<option value="7">3000Ԫ����</option></select></th>
				<th>�ؼ��֣�<input type="text" name="keywords"></th>
			</tr>
			<tr>
				<th colspan="2" align="left">�Ϲ����ڣ�<input class="Wdate"
					type="text" onClick="WdatePicker()" name="date"></th>
				<th colspan="2" align="center"><input type="submit" value="����"></th>
			</tr>
		</table>
	</form>
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
		if(products!=null){
			for (Iterator<product> iterator1 =

			products.iterator(); iterator1.hasNext();) {
				product p =

				iterator1.next();
		%>
		<tr>
			<td><%=p.getName()%></td>
			<td><%=p.getDescription()%></td>
			<td><%=p.getNormalprice()%></td>
			<td><%=p.getMemberprice()%></td>
			<td><%=p.getPdate()%></td>
			<%
				List<Category> categories2 =

					Category.getCategories();
					for

					(Iterator<Category> iterator2 = categories2.iterator(); iterator2

					.hasNext();) {

						Category c = iterator2.next();
						if

						(c.isLeaf() == true

						&& c.getId() == p.getCategoryid()) {
			%>
			<td><%=c.getName()%></td>
			<%
				}
					}
			%>
			<td><a href="deleteuser.jsp?id=<%=p.getId()%>" target="detail"><font
					color="red">ɾ�� </font></a></td>
			<td><a href="deleteuser.jsp?id=<%=p.getId()%>" target="detail"><font
					color="red">�޸� </font></a></td>
		</tr>
		<%
			}
		%>
		<tr>
			<th colspan="8">��<%=pagecount %>ҳ<a href="productsearch.jsp?action=<%=action %>&pageno=<%=pageno+1 %>&categoryid=<%=categoryid%>&normalprice=<%=normalprice%>&memberprice=<%=memberprice%>&date=<%=ts%>">��һҳ</a></th>
		</tr>
	</table>
	<% }else {%>
	<th colspan="8">�Բ���δ����������Ҫ�Ĳ�Ʒ��</th>
	<%} %>
</body>
</html>