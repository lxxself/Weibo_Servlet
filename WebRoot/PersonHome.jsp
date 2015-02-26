
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

String sql="select b.face,a.* from wblist as a join users as b on a.mid=b.id order by wbtime desc limit "+((pageNow-1)*pageSize)+","+pageSize;
ArrayList wbs=weiboService.selectAll(sql);
Iterator<Wblist> iters = wbs.iterator(); 
String MemberName = (String)session.getAttribute("account");

String sql1="select * from users";
ArrayList person =weiboService.selectAllMember(sql1);
Iterator<Member> p = person.iterator(); 
Member mb = (Member) p.next();

FocusService FS = new FocusService();
ArrayList<Integer> Flist = FS.AllFocus(mb.getId());
ArrayList<Integer> Zanlist = FS.AllZan(mb.getId());
System.out.println(Flist.get(0) );

CommentService CS = new CommentService();
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="mycss/person.css" rel="stylesheet">
<title>个人首页</title>
	<script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
/*			导航栏下拉框*/
            $('.dropdown-toggle').dropdown();

        });
        $(document).ready(function () {
        	            $('.bigimg').click(function(){
        	            	console.log($(this).width());
        	            	if($(this).width()==90){$(this).width(300);}
        	            	if($(this).width()==300){$(this).width(90);}
        	            });           
        	        });
        function f(a,b){
		console.log(a+b);
		console.log($(".focus"+b).eq(0).text());
      	 $.post("Focus.do",
                 {
                   mid:a,
                   midFocus:b,
                   ste:trim($(".focus"+b).eq(0).text())
                 },
                 function(data){                
                	$(".focus"+b).text(data);
                 });
       }
        function zan(a,b,c){
        	/* console.log($(c).html()); */
    		console.log(a);
          	 $.post("Focus.do",
                     {
                       mid:a,
                       midzan:b,
                       ste:"zan"
                     },
                     function(data){                
                       	$a = $(c).children("span.zannum");
                       	if(	$(c).css("color")=="rgb(35, 82, 124)"){	$(c).css("color","red");}
                       	else{$(c).css("color","rgb(35, 82, 124)");}
                       
                         	console.log("num:"+data);
                         	$a.text(data); 
                     }
                     );
           }
	
	</script>
	<script>
	$(function () {
/*		提示框*/
      $('[data-toggle="tooltip"]').tooltip();
    });
    </script>
    <script>
/*	弹出框*/
	$(function () {
	  $('[data-toggle="popover"]').popover();
	});
    </script>
    <script>
/*	评论隐藏*/
   $(function () { $('#collapseFour').collapse({
      toggle: false
   });});
    </script>
<script>
function trim(str){ //删除左右两端的空格
    return str.replace(/(^\s*)|(\s*$)/g, "");
}
function alter(wbid)
{
		var WB_text = "#word"+wbid;
		var WB_edit = "#area"+wbid;
		console.log($(WB_text).text());
		$(WB_text).toggle();
		$(WB_edit).toggle();		
    }
     
    function cancel(wbid){
    	var WB_text = "#word"+wbid;
		var WB_edit = "#area"+wbid;
		$(WB_text).toggle();
		$(WB_edit).toggle();
}
function upfile(){
    $("#upfile").click();
}

$(function(){
        $("[rel=drevil]").popover({
            trigger:'manual',
            placement : 'top', //placement of the popover. also can use top, bottom, left or right
            title : '<div style="text-align:center;text-decoration:underline; font-size:14px;">赞过的人</div>', 
            html: 'true', //needed to show html of course
            content :'<div id="popOverBox">'+"11"+'</div>', 
            animation: false
        }).on("mouseenter", function () {
        	console.log("ccc");
                    var _this = this;
                    $(this).popover("show");
                    $(this).siblings(".popover").on("mouseleave", function () {
                        $(_this).popover('hide');
                    });
                }).on("mouseleave", function () {
                    var _this = this;
                    setTimeout(function () {
                        if (!$(".popover:hover").length) {
                            $(_this).popover("hide");
                        }
                    }, 100);
                });
    });

function addCom(a,b){
	var comment = $("#text"+b).val();
	console.log(comment);
 	 $.post("Comments.do",
             {
               mid:a,
               wbid:b,
               comment:comment
             },
             function(data){       
            	 var html = '<div class="panel onecomment"><div><img src="<%=mb.getFace() %>" class="img sface pull-left" width="30" height="30"></div><div class="commenttext"><a href=""><%=mb.getUsername() %>:</a><span>'+comment+'</span><p>'+data+'&nbsp;&nbsp;<a href="" class="text-right">回复</a></p></div></div>';
				$("#comArea"+b).prepend(html);
				console.log(html);
				$("#text"+b).val("")
             }
             );
}
</script>
</head>

<body>
<nav class="navbar navbar-default navbar-fixed-top">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">微博</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

      <form class="navbar-form navbar-left" role="search">
        <div class="form-group">
          <input type="text" class="form-control" placeholder="搜索用户、微博内容">
        </div>
        <button type="submit" class="btn btn-default">搜索</button>
      </form>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#">首页</a></li>
        <li><a href="#"><%=MemberName%></a></li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">设置<span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="#">账号设置</a></li>
            <li><a href="#">隐私设置</a></li>
            <li><a href="#">消息设置</a></li>
            <li><a href="#">帮助文档</a></li>
            <li class="divider"></li>
            <li><a href="LoginAction?action=logout">退出</a></li>
          </ul>
        </li>
        <li><a href="#">发布</a></li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
<div class="container">
<div class="row-fluid">
  <div id="left" class="col-md-2 col-md-offset-1 leftbar">
			<ul class="list-group">
				<li href="#" class="list-group-item">首页</li>
        <li href="#" class="list-group-item">消息</li>
        <li href="#" class="list-group-item">收藏</li>
			</ul>
  </div>
  <div class="col-md-6">
  	<div class="row">
    	<div class="col-md-12">
            <form role="form"  action="AddWb" method="post" enctype="multipart/form-data">
              <div class="form-group">
              	<div class="wb_text">
              		<input type="hidden" name='change' value="add">

                	<label for="name">有什么新鲜事想告诉大家？</label>
                	<textarea id="content" name="content" class="form-control" rows="4" placeholder="说说你的心情咯"></textarea>
                </div>
                <div class="wb_additional">
                    <a href="#" class="btn btn-default btn-sm">
                        <span class="glyphicon glyphicon-plus"></span> 表情
                    </a>
                    <a  class="btn btn-default btn-sm" onclick="upfile()">
                        <span class="glyphicon glyphicon-picture"></span> 图片                        
                    </a>
    
                    <input id="upfile" type="file" name="imgfile" style="display:none;" accept="image/gif, image/jpeg" >
             
                    <a href="#" class="btn btn-default btn-sm">
                        <span class="glyphicon glyphicon-facetime-video"></span> 视频
                    </a>
                    <button type="submit" class="btn btn-primary submit fabu">发布</button>
                    <select class="form-control wb_range">
                       <option>公开</option>
                       <option>仅好友</option>
                       <option>尽自己</option>
                    </select>
                </div>
              </div>
             </form>
        </div>
    </div>
    <div class="row">
    	<div class="panel panel-default">
   <%
		while(iters.hasNext()){ 
		Wblist wb = (Wblist) iters.next();
		System.out.println("face:"+wb.getFace()) ;
	%> 
        	<div class="panel panel-default">
        		<div class="facebox">
                	<a href="#">
                    	<img src="<%=wb.getFace()%>" class="img-circle face" width="50" height="50">
                    	
                    </a>
                    <%if (!wb.getUsername().equals( MemberName)){ %>
                    <button  class="focus<%=wb.getMid()%> btn btn-xs btn-primary follow"  onclick="f('<%=mb.getId() %>','<%=wb.getMid() %>')">
					 <%if(Flist.contains(wb.getMid())){ %>
					 	已关注
					 <%}else{ %>
					 	关注
					 <%} %>
					</button>
                    <%} %>
                </div>
                <div class="wb_detail">
                	<div class="wb_info">
                    	<strong><%=wb.getUsername()%></strong>
                    	<%if (wb.getUsername().equals( MemberName)){ %>
                    	<button class="btn btn-xs btn-default" onclick="alter(<%=wb.getWbid()%>)">修改</button>
                        <a class="btn btn-xs btn-default" href="AddWb?change=delete&wbid=<%=wb.getWbid() %>">删除</a>
                        <%} %>
                    </div>
                    <div class="wb_text">
                    	<div id="word<%=wb.getWbid()%>" class="words">
                        	<%=wb.getContent() %>
                        </div>
                        <div id="area<%=wb.getWbid()%>" class="words" style="display:none">
                        	<form calss="form" action="AddWb" method="post" enctype="multipart/form-data">
	                        	<textarea name="editwords" class="form-control" rows="3" cols="30"><%=wb.getContent() %></textarea>
						        <button type="submit"  class="btn btn-default btn-xs pull-right" >
						          <span class="glyphicon glyphicon-ok"></span>
						        </button>
						        <button type="button"  class="btn btn-default btn-xs pull-right" onclick="cancel(<%=wb.getWbid()%>)">
						          <span class="glyphicon glyphicon-remove"></span>
						        </button>
							    <input type="hidden" name='change' value="alter">
								<input type="hidden" name='wbid' value="<%=wb.getWbid()%>">
								<input type="hidden" name='pagenum' value="<%=pageNow%>">
					        </form>
                        </div>
                        <%if(wb.getImgpath()!=null){ %>
                        <div class="imagesbox">
                        	<img  class="img-thumbnail bigimg" src="<%=wb.getImgpath()%>" >
                        </div>
                        <% } %> 
                        <div class="wb_from">
                          <a href=""><%=wb.getWbtime() %></a>
                          <span>来自</span>
                          <a href=""><%=wb.getDevice() %></a>

                        </div>
                    </div>
                    <div class="wb_wrap">
                        <ul class="list-inline">
                          <li><a href="#" data-toggle="tooltip" data-placement="left" title="Tooltip on left">收藏</a></li>
                          <li><a href="#">转发 <span><%=wb.getZhuang() %></span></a></li>
                          <li><a data-toggle="collapse" data-target="#demo<%=wb.getWbid() %>">评论 <span><%=wb.getPing() %></span></a></li>
                          <li> <a rel="drevil" class="zan"  onclick="zan('<%=mb.getId() %>','<%=wb.getWbid() %>',this)" <%if(Zanlist.contains(wb.getWbid())){%>style="color:red"<%} %>><input type="hidden" value="<%=wb.getWbid() %>">
                          <span class="glyphicon glyphicon-thumbs-up"></span> 
                          <span class="zannum"><%=wb.getZan()%></span></a>
                          	<div id="popBody" style="display:none">
							<% ArrayList<String> WhoZan = FS.WhoZan(wb.getWbid(),1);
							System.out.println("WhoZan");
							for(int i=0;i<WhoZan.size();i++){
								  System.out.println(WhoZan.get(i));
							%>
							<img src="<%=WhoZan.get(i) %>" width="30" height="30" />
							<%} %>
							</div> 
                          </li>
                        </ul>
                       
                    </div>
                </div>
                <!-- 评论区域开始 -->
                <div id="demo<%=wb.getWbid() %>" class="collapse">
                  <div class="panel panel-default">
                      <div class="panel mycomment">
                          <img src="<%=mb.getFace() %>" class="img sface pull-left" width="30" height="30">
                          <textarea id="text<%=wb.getWbid() %>" class="form-control commenttext" rows="1" onfocus="window.activeobj=this;this.clock=setInterval(function(){activeobj.style.height=activeobj.scrollHeight+'px';},1);" onblur="clearInterval(this.clock);"></textarea>   
                          <button type="button" class="btn btn-xs btn-primary btcomment" onclick="addCom('<%=mb.getId() %>','<%=wb.getWbid() %>',this)">评论</button>               
                      </div>
                      <div id="comArea<%=wb.getWbid() %>" class="panel panel-default allcomment">
                      
                        <%
                        Integer wbid = wb.getWbid();
                        String comsql="select b.username,b.face,a.* from comments as a join users as b on a.mid=b.id where wbid = "+wbid+" order by ctime desc";
                        ArrayList clists = CS.selectAll(comsql);
                        Iterator<Commentlist> cIterator = clists.iterator();  
                		while(cIterator.hasNext()){ 
                			Commentlist cl = (Commentlist) cIterator.next();
                        %>
                        <div class="panel onecomment">
                          <div>
                            <img src="<%=cl.getFace() %>" class="img sface pull-left" width="30" height="30">
                          </div> 
                          <div class="commenttext">
                            <a href=""><%=cl.getUsername() %>:</a>    
                            <span><%=cl.getComment() %></span>
                            <p><%=cl.getCtime() %>&nbsp;&nbsp;<a href="" class="text-right">回复</a></p>
                          </div>
                        </div>
						<% }%>
                      </div>
                  </div>
                </div>
               <!-- 评论区域结束 -->
        	</div>	
	<%} %>
<!-- 结束循环 -->		
            <div class="pnpage">
                <ul class="pagination">
	            <% if(pageNow!=1){%>
					<li><a href="<%=request.getRequestURI()%>?pageNow=<%=(pageNow-1)%>">&laquo;</a></li>
				<% }%>
                <% for(int i=1;i<=pageCount;i++){%>
                  <li><a href="<%=request.getRequestURI() %>?pageNow=<%=i%>"><%=i %></a></li>
				<% } %>
	            <% if(pageNow!=pageCount){%>
                  <li><a href="<%=request.getRequestURI() %>?pageNow=<%=(pageNow+1)%>">&raquo;</a></li>
				<% }%>

                </ul><br>
            </div>
        </div>
    </div>
  </div>
  <div id="right"class="col-md-2 rightbar">
    <div class="panel panel-default">
      <div class="infocover">
        <img src="<%=mb.getFace() %>" class="img-circle mface" width="60px" height="60px">
        <div><a><strong><%=MemberName%></strong></a></div>
      </div>
      <div class="infoabout">
        <ul class="list-inline">
    	    <li><div><strong><%=mb.getFocus() %></strong><br>关注</div></li>
          <li><div><strong><%=mb.getFollow() %></strong><br>粉丝</div></li>
          <li><div><strong><%=mb.getWbcount() %></strong><br>微博</div></li>
        </ul>
      </div>
    </div>
  </div>

</div>
</div>
</body>
</html>
