<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.moudle.DBconn" %> 
<%@ page import="com.mysql.jdbc.Driver" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="java.util.*" %> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>


    <base href="<%=basePath%>">
    
    <title>My JSP 'ppp.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
<script>
$(document).ready(function(){
  $("#1").click(function(){
    $.post("Focus.do",
    {
      name:"Donald Duck",
      city:"Duckburg"
    },
    function(data,status){
      alert("Data: " + data + "\nStatus: " + status);
    });
  });
});
function a(a,b){
	console.log(a);
	 $.post("Focus.do",
    {
      name:a,
      city:b
    },
    function(data){
      $("."+a).text(data);
    });
}
</script>
</head>
<body>

<button id="1"  class="a b"  >发送一个 HTTP POST 请求道页面并获取返回内容</button>

<button id="2" class="abc b c" onclick="a('abc',3)" >面并获取返回内容</button>
<p id="3" class="abc"></p>
</body>
</html>
