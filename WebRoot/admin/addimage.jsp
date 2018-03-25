<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
    <%
    int id=0;
        try{
        	id=Integer.parseInt(request.getParameter("id"));
        }catch(NumberFormatException e){
        	id=0;
        }
        %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
</head>
<body>
<form action="servlet/FileUploadServlet" name="FileForm" method="post" enctype="multipart/form-data">
<input type="hidden" name="id" value="<%=id %>">
        文件：<input type="file" name="file"><br>
        <input type="submit" value="提交">
    </form>
</body>
</html>