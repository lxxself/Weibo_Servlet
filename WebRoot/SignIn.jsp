<%@ page language="java" import="java.util.*,java.net.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
     <head>
     <title>登录页面</title>
     <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <meta charset="utf-8">
     <!-- Bootstrap -->
     <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
     <link href="mycss/signin.css" rel="stylesheet">	
     <script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
     <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
     <!-- WARNING: Respond.js doesn't work if you view the page via file:// --> <!--[if lt IE 9]>
     <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
     <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
     <![endif]-->
<script>
 
	 $(document).ready(function(){
	 		
			$("#signin").click(function(){
			if($("#inputName").val()==""){
					$('#nameer').text('请填写用户名');
					}
			else if($("#inputPassword").val()==""){
					$('#pser').text('请填写密码');
			}else{
					$.post("LoginAction",
{username:$("#inputName").val(),password:$("#inputPassword").val(),timeout:$("#timeout").val(),action:"signin"},
			                 function(data){ 
			                    if(data.er=="no"){
			                    window.location.reload();
			                    }               
			                	if(data.er=="name"){$("#nameer").text("用户名不存在");}
			                	if(data.er=="ps"){$("#pser").text("密码错误");}
			                 },
			                  "json"
			         
			                 );
			
			}
		var t=setTimeout("$('.error').text('')",3000);
		})
})
</script>
     </head>

    <body>
    <div class="container">
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
        response.sendRedirect("PersonHome.jsp");  
                System.out.println(123);     
        }else{
                System.out.println(456); 
        %>     

      <form class="form-signin" method="post" action="LoginAction">
      <input type=hidden name="action" value="login"/>
        <div>
            <div class="h1">请登录</div>
            <div class="alink"><a href="SignUp.jsp">还没注册</a></div>
        </div>
 		<label for="inputName" class="sr-only">用户名</label>
        <input type="text" id="inputName" name="username" class="form-control" placeholder="用户名" required autofocus>
        <div id="nameer" class="error"></div>
        <label for="inputPassword" class="sr-only">密码</label>
        <input type="password" id="inputPassword" name="password" class="form-control" placeholder="密码" required>
        <div id="pser" class="error"></div>
        <div class="checkbox">
        <label>
            <input id="timeout" type="checkbox" value="<%= Integer.MAX_VALUE %>" name="timeout"> 记住密码 
        </label>
        </div>
        <button id="signin" class="btn btn-lg btn-primary btn-block" type="button" name="login">登录</button>
      </form>
    <%}%> 
    </div> <!-- /container -->
    </body>
</html>
