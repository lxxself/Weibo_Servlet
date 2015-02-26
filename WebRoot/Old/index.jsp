<%@ page language="java" import="java.util.*,java.net.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>index</title>
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
    <% 
        String account=null;
        boolean loginflag=false;
        Cookie cookieArr[]=request.getCookies();
        if(cookieArr!=null&&cookieArr.length>0){
             for(Cookie cookie:cookieArr){
                if(cookie.getName().equals("account")){
                   account=cookie.getValue();
                   account=URLDecoder.decode(account,"UTF-8");
                   loginflag=true;
                   session.setAttribute("account",account);
                }
             }
        }
        if(loginflag){
        response.sendRedirect("member.jsp");  
                System.out.println(123);     
        }else{
                System.out.println(456); 
        %>     
  	<p ><b>用户登录</b></p>
        <form class="form"method="post" action="LoginAction" >
    	<table style="border:solid black">
  
			<input type=hidden name="action" value="login"/>
			<tr><td>用户名</td><td><input type='text' name='username' size='25'  ></td></tr>
    		<tr><td>密码</td><td><input type='password' name='password' size='25'></td></tr>
 			<tr><td>自动登录</td>
 				<td>      
         		<input type="radio" name="timeout" value="<%= 30*24*60*60 %>" checked="true"> 30天内有效 
        	 	<input type="radio" name="timeout" value="<%= Integer.MAX_VALUE %>"> 永久有效     
     		 	</td>
    		</tr>
    	</table>
    	<br/>
    	<input type="submit" name='login' value='登录'>
    	<input type="reset" name='reset' value='重置'>
		<a href="register.jsp"><input type="button" name='tore' value='还没注册'></a>
    </form>
        <%}%> 
  </body>
</html>
