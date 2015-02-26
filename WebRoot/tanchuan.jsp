<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
		  <script type="text/javascript"> 
		function show(){
					var innerWidth = 500
					var innerHeight= 100
					var ScreenWidth = screen.availWidth 
					var ScreenHeight = screen.availHeight 
/* 					var StartX = (ScreenWidth - innerWidth) / 2 
					var StartY = (ScreenHeight - innerHeight) / 2  */
					var StartX = document.getElementById("11").style.top;
					var StartY = document.getElementById("11").style.left;
					document.getElementById("11").style.display="none";
		            document.getElementById("pic").style.top=StartY;
		            document.getElementById("pic").style.left=StartX;
		            document.getElementById("pic").style.visibility="visible";
		            document.getElementById("pic").style.width=innerWidth;
		            document.getElementById("pic").style.height=innerHeight;
		            
		            
		            var formDiv="<form action='#'>";
		            formDiv+="<textarea name='content' >发布你的新微博</textarea>";
		            formDiv+="<input type='submit' value='提交' onclick='hide()' /></form>";     
		            document.getElementById("pic").innerHTML=formDiv;
		        }
		         
		        function hide(){
		            document.getElementById("pic").style.visibility="hidden";
		        }
		</script>
    <base href="<%=basePath%>">
    
    <title>My JSP 'tanchuan.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
<input type="button" value="登陆" onclick="show()"> 
<div id='11'>11111111111111
<div>222222222222222</div>
<div>222222222222222</div>
<div>222222222222222</div>
<div>222222222222222</div>
<div>222222222222222</div>
<div>222222222222222</div>

</div>


<div id="pic" style="border: 1;position: absolute; background:#00FF99;visibility: hidden"></div>
  
  </body>
</html>
