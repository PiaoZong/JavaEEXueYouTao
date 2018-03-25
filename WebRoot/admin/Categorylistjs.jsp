<%@page import="com.syc.category.Category"%>
<%@ page language="java" contentType="text/html; charset=GB18030"
	pageEncoding="GB18030"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@include file="sessioncheck.jsp"%>
<%
	List<Category> categories = Category.getCategories();
%>
<html>
<head>
<script type="text/javascript" src="script/TV20.js"></script>
<script type="text/javascript">
function t(key,parentkey){
	alert(key);
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
</head>
<body>
<script>
	addNode(-1,0,"所有类别","images/top.gif");
		<%
			for (Iterator<Category> iterator = categories.iterator(); iterator
					.hasNext();) {
				Category c = iterator.next();
		%>
		addNode(<%=c.getPid()%>,<%=c.getId()%>,"<%=c.getName()%>","images/top.gif");
		<%
			}
		%>
		showTV();
		addListener("click","t");
		</script>
</body>
</html>