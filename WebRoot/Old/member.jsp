<%@ page language="java" import="java.util.*,java.sql.*,com.service.*,com.moudle.*" pageEncoding="utf-8"%>
<%
//定义四个分页会用到的变量
int pageSize=4;
int pageNow=1;//默认显示第一页
int rowCount=0;//该值从数据库中查询
int pageCount=0;//该值是通过pageSize和rowCount
//接受用户希望显示的页数（pageNow）
String s_pageNow=request.getParameter("pageNow");
if(s_pageNow!=null){
//接收到了pageNow
pageNow=Integer.parseInt(s_pageNow);
}
//查询得到rowCount
WeiboService weiboService=new WeiboService();
ArrayList r=weiboService.selectAll("");
rowCount=r.size();

//计算pageCount
if(rowCount%pageSize==0){
pageCount=rowCount/pageSize;
}else{
pageCount=rowCount/pageSize+1;
}
//过滤当前页码
if(pageNow<1)pageNow=1;
if(pageNow>pageCount)pageNow=pageCount;
//查询出需要显示的记录

String sql="select * from wblist order by wbtime desc limit "+((pageNow-1)*pageSize)+","+pageSize;
ArrayList wbs=weiboService.selectAll(sql);

Iterator<Wblist> iters = wbs.iterator(); 
String MemberName = (String)session.getAttribute("account");

%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
<script>
function alter(wbid)
{
		var innerWidth = 500;
		var innerHeight= 60;
		var WB_text = "WB_text"+wbid;
		var WB_edit = "WB_edit"+wbid;
		console.log(WB_text);
		var StartX = document.getElementById(WB_text).style.top;
		var StartY = document.getElementById(WB_text).style.left;
		document.getElementById(WB_text).style.display="none";
		document.getElementById(WB_edit).style.display="inline";
	
		console.log(StartX);
		console.log(StartY);
        document.getElementById(WB_edit).style.top=StartY;
        document.getElementById(WB_edit).style.left=StartX;
        document.getElementById(WB_edit).style.width=innerWidth;
        document.getElementById(WB_edit).style.height=innerHeight;
		
    }
     
    function cancel(wbid){
    	var WB_text = "WB_text"+wbid;
		var WB_edit = "WB_edit"+wbid;
		document.getElementById(WB_text).style.display="inline";
		document.getElementById(WB_edit).style.display="none";
    }


</script>
	<link rel="stylesheet" type="text/css" href="css/member.css">

  </head>
  
<body>
<div class="top">
		<input type="text" value="微博搜索" class="W_input" >
		<input type="button" value="搜索" class="sbutton">
		<a class="sy" href="index.jsp">首页</a>
		<a class="gr" href="person.jsp">个人主页</a>
</div>

<div class="mheader" >
	</div>
<div class="left"><div class="touxiang" ><img></div>
	<h1>会员 

			<%=MemberName%>

		你好
	</h1>
	<a href="LoginAction?action=logout">退出</a>
</div>
<div class="main">
	<form calss="form" action="AddWb" method="post" enctype="multipart/form-data">
		<div class="newwb">
			<textarea name="content" class="newarea" value="">发布你的新微博</textarea>
			<input type="hidden" name='change' value="add">
			<input type="submit" class="fabu" value="发布"></br>
			<div class="imgup"><input type="text" name="picName"></br>
			   上传图片:
			   <input type="file" name="imgfile" >
			 </div>
		</div>
	</form>
	<div class="wblists">
	
<!-- 	开始循环 -->
	<%
		while(iters.hasNext()){ 
		Wblist wb = (Wblist) iters.next();
		//System.out.println("123"+wb.getUsername());
	%> 
		<div class="wbexpand">
			<div class=WB_who>
				【<%=wb.getUsername()%>】
			</div>
			<div id="WB_text<%=wb.getWbid()%>" class="WB_text">
				<div ><%=wb.getContent()%></div>
				<%if(wb.getImgname()!=null){ 
				%>
				<div><img src="<%=wb.getImgpath()%>"  height="60px" ></div>
				<%} %>
            </div>
            <div id="WB_edit<%=wb.getWbid()%>" class="WB_edit">
            	<form calss="form" action="AddWb" method="post" enctype="multipart/form-data">
						<textarea name="editwords" style="width:400;height:40" class="wbwords" value=""><%=wb.getContent()%></textarea>
						<input type="hidden" name='change' value="alter">
						<input type="hidden" name='wbid' value="<%=wb.getWbid()%>">
						<input type="hidden" name='pagenum' value="<%=pageNow%>"></br>
						<input type="submit" class="tijiao" value="提交">
						<input type="button" class="quxiao" value="取消" onClick="cancel(<%=wb.getWbid()%>)" >
				</form>
			</div>
        	<div class="WB_func clearfix">
    			<div class="wbhandle">
	        		<ul class="clearfix">
	                	<li><span class="line S_line1">转发 <%=wb.getZhuang()%></span></li>
	           	 		<li><span class="line S_line1">评论 <%=wb.getPing()%></span></li>
	            		<li><span class="line S_line1">赞 <%=wb.getZan()%></span></li>
	       			</ul>
    			</div>
    			<div class="WB_from S_txt2">
	       		 	<a class="S_txt2" ><%=wb.getWbtime()%></a> 
	       		 	来自
	       		 	<a class="S_txt2" ><%=wb.getDevice()%>客户端</a>  
	       		 	
	       		 	<% if (MemberName.equals(wb.getUsername()) ){
	       		 	%>
	       		 	<a  href="javascript:void(0);" onclick="alter(<%=wb.getWbid()%>)">修改</a> 
	       		 	<a class="S_txt2" href="AddWb?change=delete&wbid=<%=wb.getWbid() %>">删除</a>
	       		 	<% } %>
						</form>
					</a>   
       		 	</div>
			</div>                                    
		</div>
	<%} %>
<!-- 结束循环 -->		


<%
//上一页
if(pageNow!=1){
out.println("<a href=member.jsp?pageNow="+(pageNow-1)+">上一页</a>");
}
//显示超链接
for(int i=1;i<=pageCount;i++){
out.println("<a href=member.jsp?pageNow="+i+">["+i+"]</a>");
}
//下一页
if(pageNow!=pageCount){
out.println("<a href=member.jsp?pageNow="+(pageNow+1)+">下一页</a>");
}
//总页数

%>

	<span>共<%=pageCount %>页</span>				
	</div>
</div>
<div class="right">f</div>
<div class="footer">f</div>				
</body>
</html>
