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
				<th>产品类别： <select name="categoryid">
						<option value="0" selected="selected">所有类别</option>
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
				<th>原价：<select name="normalprice"><option value="0">无</option>
						<option value="1">0-500元</option>
						<option value="2">500-1000元</option>
						<option value="3">1000-1500元</option>
						<option value="4">1500-2000元</option>
						<option value="5">2000-2500元</option>
						<option value="6">2500-3000元</option>
						<option value="7">3000元以上</option></select></th>
				<th>活动价：<select name="memberprice"><option value="0">无</option>
						<option value="1">0-500元</option>
						<option value="2">500-1000元</option>
						<option value="3">1000-1500元</option>
						<option value="4">1500-2000元</option>
						<option value="5">2000-2500元</option>
						<option value="6">2500-3000元</option>
						<option value="7">3000元以上</option></select></th>
				<th>关键字：<input type="text" name="keywords"></th>
			</tr>
			<tr>
				<th colspan="2" align="left">上柜日期：<input class="Wdate"
					type="text" onClick="WdatePicker()" name="date"></th>
				<th colspan="2" align="center"><input type="submit" value="搜索"></th>
			</tr>
		</table>
	</form>
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
					color="red">删除 </font></a></td>
			<td><a href="deleteuser.jsp?id=<%=p.getId()%>" target="detail"><font
					color="red">修改 </font></a></td>
		</tr>
		<%
			}
		%>
		<tr>
			<th colspan="8">共<%=pagecount %>页<a href="productsearch.jsp?action=<%=action %>&pageno=<%=pageno+1 %>&categoryid=<%=categoryid%>&normalprice=<%=normalprice%>&memberprice=<%=memberprice%>&date=<%=ts%>">下一页</a></th>
		</tr>
	</table>
	<% }else {%>
	<th colspan="8">对不起，未搜索到你想要的产品！</th>
	<%} %>
</body>
</html>