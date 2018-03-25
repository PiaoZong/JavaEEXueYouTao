<%@page import="java.util.ArrayList"%>
<%@page import="com.syc.order.OrderSales"%>
<%@page import="com.syc.order.OrderManager"%>
<%@page import="com.syc.product.productManager"%>
<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@page import="com.syc.category.Category"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.syc.product.product"%>
<%@page import="java.util.List"%>
<%@include file="sessioncheck.jsp"%>
<%
	int pageno=1;
	int pagesize=4;
	String struts=null;
	try{
		pageno=Integer.parseInt(request.getParameter("pageno"));
		if(pageno<=0){
			pageno=1;
		}
	}catch(NumberFormatException e){
		pageno=1;
	}
	OrderManager om=null;
	om=OrderManager.getInstance();
	List<OrderSales> orders=new ArrayList<OrderSales>();
	int count=om.getorders(orders, pageno, pagesize);
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
			<th colspan="8" align="center"><h3>所有订单</h3></th>
		</tr>
		<tr>
			<th>下单者</th>
			<th>送货地址</th>
			<th>收货电话</th>
			<th>收货人姓名</th>
			<th>下单时间</th>
			<th>订单状态</th>
			<th colspan="2">操作</th>
		</tr>
		<%
			for (Iterator<OrderSales> iterator = orders.iterator(); iterator
					.hasNext();) {
				OrderSales order = iterator.next();
		%>
		<tr>
		
			<td><%=order.getU().getUsername()%></td>
			<td><%=order.getAdress()%></td>
			<td><%=order.getPhone()%></td>
			<td><%=order.getName()%></td>
			<td><%=order.getOdate()%></td>
			<%if(order.getStatus()==0){
				struts="未处理";
			}else if(order.getStatus()==1){
				struts="已处理";
			}else{
				struts="废单";
			}%>
			<td><%=struts%></td>
			<td><a href="orderdetail.jsp?id=<%=order.getId() %>" target="detail"><font
					color="red">订单详细信息</font></a></td>
			<td><a href="orderupdate.jsp" target="detail"><font
					color="red">删除</font></a></td>
		</tr>
		<%
			}
		%>
		<tr>
		    <th colspan="8">
			<a href="orderlist.jsp?pageno=1>">首页</a>
			<a href="orderlist.jsp?pageno=<%=pageno - 1%>">上一页</a>
			<a href="orderlist.jsp?pageno=<%=pageno + 1%>">下一页</a>
			<a href="orderlist.jsp?pageno=<%=count%>">尾页</a>
			</th>
		</tr>
	</table>
</body>
</html>