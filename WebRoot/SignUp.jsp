<%@ page language="java" import="java.util.*,java.net.*" pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="mycss/signin.css" rel="stylesheet">	
<title>注册页面</title>
     <script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
<script>
$(document).ready(function(){
	 		
			$("#signup").click(function(){
				var a= $("#inputPassword").val();
				var b= $("#inputComfirm").val();
				if(a!=b){
					$("#cpser").text("两次密码不一致");
				}
			})
})
</script>
<script type="text/javascript">

</script>
</head>

<body>
	<div class="container">
      <form class="form-signin"  method="post" action="LoginAction">
      <input type=hidden name="action" value="register"/>
        <div>
             <div class="h1">请注册</div>
             <div class="alink"><a href="SignIn.jsp">已注册</a></div>
        </div>
        <label for="inputName" class="sr-only">用户名</label>
        <input type="text" id="inputName" name="username" class="form-control" placeholder="用户名" required autofocus>
        <div id="nameer" class="error"></div>
        <label for="inputEmail" class="sr-only">邮箱地址</label>
        <input type="email" id="inputEmail" name="email" class="form-control" placeholder="邮箱地址" required autofocus>
        <div id="emailer" class="error"></div>
        <label for="inputPassword" class="sr-only">密码</label>
        <input type="password" id="inputPassword" name="password" class="form-control" placeholder="密码" required>
        <div id="pser" class="error"></div>
        <label for="inputComfirm" class="sr-only">密码确认</label>
        <input type="password" id="inputComfirm" name="confirmedPasswd" class="form-control" placeholder="密码确认" required>
        <div id="cpser" class="error"></div>
        <div>
			<div class="Code">
            	<label for="inputCode" class="sr-only">验证码</label>
        		<input type="text" id="inputCode" name="code"  class="form-control" placeholder="验证码" required autofocus>
        	</div>
            <div class="CodeImg">
            	<img src="code.jsp" onClick="this.src='code.jsp?' + new Date().getTime();" width="100px" height="40px"/>
            </div>
        </div>
        <div id="codeer" class="error"></div>
        <button id="signup" class="btn btn-lg btn-primary btn-block" type="submit" >注册</button>
      </form>

    </div> <!-- /container -->
</body>
</html>
