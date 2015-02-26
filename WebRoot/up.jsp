<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jspsmart.upload.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'up.jsp' starting page</title>
    
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
<%
 //由以下几个步骤实现
 //1.上传初始化
SmartUpload smart = new SmartUpload();
 smart.initialize(pageContext);
 //2.准备上传
 smart.upload();
 
 String ext = smart.getFiles().getFile(0).getFileExt();             //取得上传文件的扩展名
 String name = smart.getRequest().getParameter("picName");  //取得自定义的图片名
 //3.保存上传的文件
 String imgpath = "upload/"+name+"."+ext;
 System.out.println(imgpath);
 smart.getFiles().getFile(0).saveAs("/upload/"+name+"."+ext);
%>
<img src="<%=imgpath %>"  height="60px" >

  </body>
</html>
