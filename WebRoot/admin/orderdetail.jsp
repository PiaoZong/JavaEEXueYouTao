<%@page import="com.syc.order.salesitem"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.syc.order.OrderSales"%>
<%@page import="com.syc.order.OrderManager"%>
<%@page import="com.syc.product.productManager"%>
<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@include file="sessioncheck.jsp"%>
<%
	int id=0;
	int price=0;
	try{
	id=Integer.parseInt(request.getParameter("id"));
	}catch(NumberFormatException e){
		id=0;
	}
	OrderManager om=null;
	om=OrderManager.getInstance();
	List<salesitem> salesitems=om.loadbyid(id);
	
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
			<th colspan="4" align="center"><h3>������ϸ��Ϣ</h3></th>
		</tr>
		<tr>
			<th>������Ʒ</th>
			<th>��Ʒ����</th>
			<th>��Ʒ����</th>
			<th>ÿ���ܼ�</th>
		</tr>
		<%
			for (Iterator<salesitem> iterator = salesitems.iterator(); iterator
					.hasNext();) {
				salesitem item = iterator.next();
				price+=item.totalprice();
		%>
		<tr>

			<td><%=item.loadproductbyid().getName()%></td>
			<td><%=item.getUnitprice()%></td>
			<td><%=item.getCount()%></td>
			<td><%=item.totalprice()%></td>
		</tr>
		<%
			}
		%>
		<tr>
			<td colspan="3">�ܼ�</td>
			<td><%=price %></td>
			</tr>
			</table>
			</body>
			</html>