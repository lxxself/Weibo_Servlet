package com.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jspsmart.upload.*;
import com.moudle.Member;
import com.moudle.Wblist;
import com.service.WeiboService;

public class AddWb extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public AddWb() {
		/*super();*/
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}




	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Integer wbid = Integer.parseInt(request.getParameter("wbid"));
		Delete(wbid);
		response.sendRedirect("PersonHome.jsp"); 
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");

		SmartUpload smart = new SmartUpload();
		smart.initialize(getServletConfig(), request, response);
		try {
			smart.upload();
		} catch (SmartUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Request req = smart.getRequest();
		String change =req.getParameter("change");
		String pagenum =req.getParameter("pagenum");
		System.out.println("1333333333311");
		System.out.println(change);
		System.out.println(request.getParameter("change"));
		System.out.println(pagenum);
		if(pagenum==null){
			pagenum="1";
		}
		if(change.equals("add")){
			String username = (String)request.getSession().getAttribute("account");
			System.out.println(username);
			String content=new String(req.getParameter("content").getBytes(),"utf-8");
			System.out.println(content);

			String device = req.getParameter("device");
			
//			 String ext = smart.getFiles().getFile(0).getFileExt();           
			 String name =smart.getFiles().getFile(0).getFileName();
			 try {
				smart.getFiles().getFile(0).saveAs("/upload/"+name);
			} catch (SmartUploadException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String imgpath = "upload/"+name;
			if(name==null || name.equals("")){imgpath=null;}
			Add(username,content,device,name,imgpath);
		}
		else if(change.equals("alter")){

			String editwords=new String(req.getParameter("editwords").getBytes(),"utf-8");
			Integer wbid = Integer.parseInt(req.getParameter("wbid"));
			Alter(wbid,editwords);
		}
		response.sendRedirect("PersonHome.jsp?pageNow="+pagenum); 
	}
	public void Add(String username,String content,String device,String imgname ,String imgpath ){

		WeiboService weiboService=new WeiboService();
		ArrayList r=weiboService.selectAllMember("select * from users where username='"+username+"'");
		Iterator<Member> iters = r.iterator();
		Member m = (Member) iters.next();
		Integer mid = m.getId();
		Integer ping = 0;
		Integer zan = 0;
		Integer zhuang = 0;
		java.util.Date now=new java.util.Date(); 
		SimpleDateFormat f=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		String wbtime = f.format(now.getTime());
		System.out.println(wbtime);
		Wblist wblist=new Wblist();
		wblist.setMid(mid);
		System.out.println(mid);
		wblist.setUsername(username);
		wblist.setContent(content);
		wblist.setPing(ping);
		wblist.setZhuang(zhuang);
		wblist.setZan(zan);
		wblist.setWbtime(wbtime);
		wblist.setImgname(imgname);
		wblist.setImgpath(imgpath);
		WeiboService WbListService=new WeiboService();
		WbListService.AddWb(wblist);
	}
	public void Delete(Integer wbid){
		WeiboService weiboService=new WeiboService();
		weiboService.DeleteWb(wbid);
		
	}
	public void Alter(Integer wbid,String editwords){
		WeiboService weiboService=new WeiboService();
		weiboService.AlterWb(wbid,editwords);
		System.out.println(editwords);
	}
	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
