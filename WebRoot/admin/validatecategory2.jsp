<%@page import="com.syc.category.Category"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=GB18030"
	pageEncoding="GB18030"%>
<%
 response.setContentType("text/xml");
 response.setHeader("Cache-Control", "no-store");//http1.1
 response.setHeader("Pragma", "no-cache");//http1.0
 response.setDateHeader("Expires", 0);
 String categoryid=request.getParameter("categoryid");
 int id=0;
 try{
	 id=Integer.parseInt(categoryid);
 }catch(NumberFormatException e){
	 id=0;
 }
 List<Category> categories=Category.getCategories();
 StringBuffer sb=new StringBuffer();
 for(int i=0;i<categories.size();i++){
	 if(categories.get(i).getPid()==id){
		 sb.append("<category><id>"+categories.get(i).getId()+"</id><name>"+categories.get(i).getName()+"</name></category>");
	 }
 }
 sb.insert(0, "<categories>");
 sb.insert(0, "<?xml version='1.0' encoding='gb18030'?>");
 sb.append("</categories>");
 response.getWriter().write(sb.toString());
%>