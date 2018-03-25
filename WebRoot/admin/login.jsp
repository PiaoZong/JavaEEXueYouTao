<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String action=request.getParameter("action");
if(action!=null && action.equals("login")){
String username=request.getParameter("username");
String password=request.getParameter("password");
if(username==null || !username.equals("admin")){
out.println("账号错误");
}else if(password==null || !password.equals("admin")){
out.println("密码错误");
}else{
session.setAttribute("admin", "true");
response.sendRedirect("index.jsp");
}
}
 %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>学友淘后台登陆界面</title>
</head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>学友淘后台管理平台</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	overflow: hidden;
	
    background-color:#4A87A6;
}

td {
	align: left
}

.STYLE3 {
	color:#FFFFFF;
	font-size: 12px;
}

.STYLE4 {
	color:#FFFFFF;
	font-size: 12px;
}
-->
</style>
</head>

<body>
	<form action="login.jsp" method="post">
	<input type="hidden" name="action" value="login">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" >

			<tr>
				<td height="608"  ><table
						width="862" border="0" align="center" cellpadding="0"
						cellspacing="0">
						<tr>
							<td height="266" ><img src="images/htdl.png" width="869"></td>
						</tr>
						<tr>
							<td height="95"><table width="100%" border="0"
									cellspacing="0" cellpadding="0">
									<tr>
										<td width="424" height="95" >&nbsp;</td>
										<td width="183" ><table
												width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="21%" height="30"><div align="center">
															<span class="STYLE3">账号</span>
															
														</div></td>
													<td width="79%" height="30"><input type="text"
														name="username"
														style="height:18px; width:130px; border:solid 1px #cadcb2; font-size:12px; color:#81b432;"></td>
												</tr>
												<tr>
													<td height="30"><div align="center">
															<span class="STYLE3">密码</span>
														</div></td>
													<td height="30"><input type="password"
														name="password"
														style="height:18px; width:130px; border:solid 1px #cadcb2; font-size:12px; color:#81b432;"></td>
												</tr>
												<tr>
													<td height="30">&nbsp;</td>
													<td height="30"><input type="submit" value="登陆"><input
														type="reset" value="重置"></td>
												</tr>
											</table></td>
										<td width="555">&nbsp;</td>
									</tr>
								</table></td>
						</tr>
						<tr>
							<td height="247" valign="top"><table
									width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="22%" height="30">&nbsp;</td>
										<td width="56%">&nbsp;</td>
										<td width="22%">&nbsp;</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
										<td height="30"><table width="100%" border="0"
												cellspacing="0" cellpadding="0">
												<tr>
													<td width="25%" height="20">&nbsp;</td>
													<td width="56%" class="STYLE4"><p>默认账户：admin\admin</p></td>
												</tr>
											</table></td>
										<td>&nbsp;</td>
									</tr>
								</table>							</td>
						</tr>
					</table>
			  </td>
			</tr>
		</table>
	</form>
	<map name="Map">
		<area shape="rect" coords="3,3,36,19" href="#">
		<area shape="rect" coords="40,3,78,18" href="#">
	</map>
</body>
</html>