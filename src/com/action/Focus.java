package com.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.moudle.DBconn;
import com.moudle.Focuslist;
import com.service.FocusService;

public class Focus extends HttpServlet {

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
		String ste = request.getParameter("ste");
		FocusService fs = new FocusService();
		if(ste.equals("zan")){
			Integer wbid = Integer.parseInt(request.getParameter("midzan"));
			Integer num;
			String zannum = "";
			try {
				num = fs.Zan(mid, wbid);
				zannum = num.toString();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			out.write(zannum);
		}else{
			Integer midFocus = Integer.parseInt(request.getParameter("midFocus"));
			Focuslist fl = new Focuslist();
			fl.setMid(mid);
			fl.setMidFocus(midFocus);
			if(ste.equals("已关注")){				
				fs.DeleteFocus(fl);
				String focus = "关注";
				out.write(focus);			
			}else if(ste.equals("关注")){
				fs.insertFocus(fl);
				String focus = "已关注";
				out.write(focus);
			}
		}
	}

}
