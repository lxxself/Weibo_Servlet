package com.action;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.moudle.*;
import com.service.*;

import java.sql.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginAction extends HttpServlet {
	private static final long serialVersionUID =55L;
	private final String SUCCESS_VIEW ="success.jsp";
	private final String ERROR_VIEW="error.jsp";	
	Map<String,String> map = new HashMap<String,String>();
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
		
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action=request.getParameter("action");
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		if(action.equals("register")){
			String email = request.getParameter("email");
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String confirmedPasswd = request.getParameter("confirmedPasswd");
			String rand=(String)request.getSession().getAttribute("rand");
			String code = request.getParameter("code");
			List<String> errors = new ArrayList<String>();
			if(isInvalidEmail(email)){
				errors.add("未填写邮件或邮件格式不正确");
			}
			if(isInvalidUsername(username)){
				errors.add("用户名为空或已存在");
				System.out.println("--用户名为空或已存在");
			}
			if(isInvalidPassword(password,confirmedPasswd)){
				errors.add("请重新填写密码");
			}
			if(isInvalidCode(code,rand)){
				errors.add("验证码错误");
			}
			String resultPage = ERROR_VIEW;
			if(!errors.isEmpty()){
				request.setAttribute("errors", errors);
			} else {
				resultPage = SUCCESS_VIEW;
				createUserData(email,username,password);
			}
			request.getRequestDispatcher(resultPage).forward(request, response);
		}else if(action.equals("signin")){
			String account = request.getParameter("username");
			System.out.println(account);
			String password = request.getParameter("password");
			if(checkLogin(account,password)){	
				Integer timeout = 60*60;
				if(request.getParameter("timeout")!=null){
					timeout = Integer.parseInt(request.getParameter("timeout"));
				}
				account=URLEncoder.encode(account);
				Cookie acountCookie=new Cookie("account",account);
				acountCookie.setMaxAge(timeout);
				acountCookie.setPath("/");
			    response.addCookie(acountCookie);
				}
			Gson gson = new Gson();
			String jsonStr = gson.toJson(map);
			System.out.println(jsonStr);
			out.write(jsonStr);
			out.flush();
//			
//			response.sendRedirect("PersonHome.jsp");
			}else if(action.equals("logout")){
				Cookie acountCookie=new Cookie("account","");
				acountCookie.setMaxAge(0);
				acountCookie.setPath("/");
				response.addCookie(acountCookie);
				response.sendRedirect("SignIn.jsp");
			}
	}
	
	
	private boolean isInvalidEmail(String email){
		return email == null || !email.matches("^[_a-z0-9-]+([.]"+"[_a-z0-9-]+)*@[a-z0-9-]+([.][a-z0-9-]+)*$");
		
	}
	private boolean isInvalidUsername(String username){
		Statement stmt=null;

		try{
			/*Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//加载驱动器类
			conn=DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=weibo","sa","sql2008");//建立连接
			stmt=conn.createStatement();//建立处理的SQL语句
			*/
			DBconn DB = new DBconn();
			String sql = "select username from users";
			ResultSet rs=DB.getRs(sql);//形成结果集
			   while(rs.next()){
				if(username==null || rs.getString("username").equals(username) ){
					return true;
				}	
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	private boolean isInvalidPassword(String password,String confirmedPasswd){
		return password == null || password.length()<6 ||password.length()>16||!password.equals(confirmedPasswd);	
		
	}
	private boolean isInvalidCode(String code,String rand){
		return code == null ||!code.equals(rand);	
		
	}
	
	private void createUserData(String email,String username,String password) throws IOException{
		Member member=new Member();
		member.setEmail(email);
		member.setUsername(username);
		member.setPassword(password);
		WeiboService memberService=new WeiboService();
		memberService.insertMember(member);	
		//request.setAttribute("username", errors);
		//request.getRequestDispatcher("member.jsp").forward(request, response);
	}
	private boolean checkLogin(String username,String password)throws IOException{
			Statement stmt=null;
			try{
				DBconn DB = new DBconn();
				String sql = "select * from users where username='"+username+"'";
				ResultSet rs=DB.getRs(sql);//形成结果集
				if(rs.next()){
					if(rs.getString("psword").equals(password)){
						map.put("er", "no");
						return true;
					}else{
						map.put("er", "ps");
					}
				}else{
					map.put("er", "name");
				}

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return false;
	}
}
