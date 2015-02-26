<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="css/register.css">
  </head>
  
  <body>
<div class="wrapper-bg">
   <img id="bg" src="image/bg.jpg" style="width: 1366px; height: auto; margin-left: 0px; margin-top: -187.1875px; display: block; opacity: 1;">
</div>

  	<p ><b>用户注册</b></p>
        <form class="form"  method="post" action="LoginAction">
    	<table style="border:solid black">
    	<input type=hidden name="action" value="register"/>
    		<tr><td>邮箱</td><td><input type='text' name='email' size='25'></td></tr>
			<tr><td>用户名</td><td><input type='text' name='username' size='25'  title="至少4个字符"></td></tr>
    		<tr><td>密码</td><td><input type='password' name='password' size='25'  title="不少于6个字符"></td></tr>
       		<tr><td>确认密码</td><td><input type='password' name='confirmedPasswd' size='25'></td></tr>
       		<tr><td>验证码</td><td><input type='text' name='code' size='10' value=""  title="点击更换验证码"><img style="padding:10px;vertical-align:middle;" border=0 src="code.jsp" onClick="this.src='code.jsp?' + new Date().getTime();"></td></tr>
    	</table>
    	<br/>
    	<input type="submit" name='register' value='注册'>
    	<input type="reset" name='reset' value='重置'>
    	<input type="button" name='index' value='返回首页' onclick="window.location.href='index.jsp'">
    </form><br>

  </body>
</html>
