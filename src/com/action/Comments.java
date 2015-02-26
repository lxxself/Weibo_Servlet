package com.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.moudle.Commentlist;
import com.service.CommentService;

public class Comments extends HttpServlet {

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

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
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		Integer mid = Integer.parseInt(request.getParameter("mid"));
		Integer wbid = Integer.parseInt(request.getParameter("wbid"));
		String comment = request.getParameter("comment");
		java.util.Date now=new java.util.Date(); 
		SimpleDateFormat f=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		String ctime = f.format(now.getTime());
		Commentlist cl = new Commentlist();
		cl.setMid(mid);
		cl.setWbid(wbid);
		cl.setComment(comment);
		cl.setCtime(ctime);
		CommentService CS = new CommentService();
		CS.AddCom(cl);
		out.write(ctime);
	}

}
