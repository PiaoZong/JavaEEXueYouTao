<%@page import="sun.util.BuddhistCalendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.syc.category.Category"%>
<%@ page language="java" contentType="text/html; charset=GB18030"
	pageEncoding="GB18030"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@include file="sessioncheck.jsp"%>
<%
	List<Category> categories = Category.getCategories();
	List<Category> topcategories = new ArrayList<Category>();
	for(int i=0;i<categories.size();i++){
		Category c=categories.get(i);
		if(c.getGrade()==1){
			topcategories.add(c);
		}
	}
	

%>
<%
	StringBuffer sb=new StringBuffer();
	String str="";
	for(int k=0;k<topcategories.size();k++){
		int count=1;
	for(int j=0;j<categories.size();j++){
		if(categories.get(j).getPid()==topcategories.get(k).getId()){
			sb.append("document.getElementById('"+"category2"+"').options["+count+"].text='"+categories.get(j).getName()+"';\n");
			sb.append("document.getElementById('"+"category2"+"').options["+count+"].value='"+categories.get(j).getId()+"';\n");
			count++;
		}
	}
	sb.insert(0, "document.getElementById('"+"category2"+"').options[0].value='"+"0"+"';\n");
	sb.insert(0, "document.getElementById('"+"category2"+"').options[0].text='"+"二级目录"+"';\n");
	sb.insert(0, "document.getElementById('"+"category2"+"').selectIndex=0;\n");
	sb.insert(0,"document.getElementById('"+"category2"+"').length="+count+";\n");
	sb.insert(0,"if(document.getElementById('"+"category1"+"').options[document.getElementById('"+"category1"+"').selectedIndex].value=="+topcategories.get(k).getId()+"){\n");
	sb.append("}\n");
	str+=sb.toString();
	sb.delete(0, sb.length());
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
</head>
<body>
	<table align="center">
		<tr>
			<td><select name="category1" id="category1" onchange="change()">
					<option value="-1" selected>一级目录</option>
					<%
						for (Iterator<Category> iterator = categories.iterator(); iterator
								.hasNext();) {
							Category c = iterator.next();
							if(c.getGrade()==1){
					%>
					<option value="<%=c.getId()%>"><%=c.getName()%></option>
					<%
						}}
					%>
			</select></td>
			<td><select name="category2" id="category2">
			<option value="0" selected>二级目录</option>
			</select></td>
		</tr>
	</table>
	<script type="text/javascript">
			/*if(document.getElementById("category1").selectedIndex==0){
				document.getElementById("category2").length=1;
				document.getElementById("category2").selectedIndex=0;
				document.getElementById("category2").options[0].text="二级目录";
				document.getElementById("category2").options[0].value="0";
			}*/
			var request;
			function change(){
				var zhi=document.getElementById("category1").options[document.getElementById("category1").selectedIndex].value;
				var url="validatecategory2.jsp?categoryid="+escape(zhi);//转码

				//根据不同浏览器创建不同实例
				if(window.XMLHttpRequest){
					request=new XMLHttpRequest();
				}else if(window.ActiveXObject){
					request=new ActiveXObject("Microsoft.XMLHTTP");
					
				}
				request.open("GET", url, true);//方式，地址，是否使用异步方式
				request.onreadystatechange=callback2;//回调函数
				request.send(null);
			}
			
			function callback2(){
				if(request.readyState==4 && request.status==200){
				//alert(request.responseText);
				var categories=request.responseXML.getElementsByTagName("categories")[0];
				//alert(categories.childNodes.length);
				document.getElementById("category2").length=categories.childNodes.length+1;
				for(var i=0;i<categories.childNodes.length;i++){
					var category=categories.childNodes[i];
					//alert(category.childNodes.length);
					var id=category.childNodes[0].childNodes[0].nodeValue;
					var name=category.childNodes[1].childNodes[0].nodeValue;
					document.getElementById("category2").options[i+1].text=name;
					document.getElementById("category2").options[i+1].value=id;		
				}
				}
				
			}
			
			function callback1(){
				if(request.readyState==4 && request.status==200){//检验服务器是否完成处理请求并反馈正常
					//alert(request.responseText);
					var msg=request.responseText;
					msg=msg.replace(/(^\s*)|(\s*$)/g, "");
					if(msg==null || msg.toString()==""){
						document.getElementById("category2").length=1;
						return;
					}else{
					var categories=msg.split(";");
					document.getElementById("category2").length=categories.length+1;
					document.getElementById("category2").selectedIndex=0;
					for(var i=0;i<categories.length;i++){
						//alert(categories[i]);
						var category=categories[i].split(",");
						//alert(category[0]+category[1]);
						document.getElementById("category2").options[i+1].text=category[1];
						document.getElementById("category2").options[i+1].value=category[0];					
					}
				}
				}
			}
	</script>
	<table border="1" align="center">
		<tr>
			<th colspan="6" align="center"><h3>所有</h3></th>
		</tr>
		<tr>
			<th>ID</th>
			<th>类名</th>
			<th>上级类ID</th>
			<th>级别</th>
			<th colspan="2">操作</th>
		</tr>
		<%
			for (Iterator<Category> iterator = categories.iterator(); iterator
					.hasNext();) {
				Category c = iterator.next();
				String pre = "";
				for (int i = 1; i < c.getGrade(); i++) {
					pre += "----";
				}
		%>
		<tr>
			<td><%=c.getId()%></td>
			<td><%=pre + c.getName()%></td>
			<td><%=c.getPid()%></td>
			<td><%=c.getGrade()%></td>
			<td><a href="addCategory.jsp?id=<%=c.getId()%>"><font
					color="red">添加子类别</font></a></td>
			<td><a
				href="Categorydelete.jsp?id=<%=c.getId()%>&pid=<%=c.getPid()%>"
				target="detail"><font color="red">删除</font></a></td>
		</tr>
		<%
			}
		%>
	</table>
</body>
</html>