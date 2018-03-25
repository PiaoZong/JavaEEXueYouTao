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
			<th colspan="8" align="center"><h3>���ж���</h3></th>
		</tr>
		<tr>
			<th>�µ���</th>
			<th>�ͻ���ַ</th>
			<th>�ջ��绰</th>
			<th>�ջ�������</th>
			<th>�µ�ʱ��</th>
			<th>����״̬</th>
			<th colspan="2">����</th>
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
				struts="δ����";
			}else if(order.getStatus()==1){
				struts="�Ѵ���";
			}else{
				struts="�ϵ�";
			}%>
			<td><%=struts%></td>
			<td><a href="orderdetail.jsp?id=<%=order.getId() %>" target="detail"><font
					color="red">������ϸ��Ϣ</font></a></td>
			<td><a href="orderupdate.jsp" target="detail"><font
					color="red">ɾ��</font></a></td>
		</tr>
		<%
			}
		%>
		<tr>
		    <th colspan="8">
			<a href="orderlist.jsp?pageno=1>">��ҳ</a>
			<a href="orderlist.jsp?pageno=<%=pageno - 1%>">��һҳ</a>
			<a href="orderlist.jsp?pageno=<%=pageno + 1%>">��һҳ</a>
			<a href="orderlist.jsp?pageno=<%=count%>">βҳ</a>
			</th>
		</tr>
	</table>
</body>
</html>