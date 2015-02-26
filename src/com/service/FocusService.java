package com.service;

import java.sql.*;
import java.util.*;

import com.moudle.DBconn;
import com.moudle.Focuslist;
import com.moudle.Member;

public class FocusService {
	public int insertFocus(Focuslist fl){			//关注
		int i=0;
		Statement stmt=null;	
		ResultSet rs = null;
		try {
			DBconn DB = new DBconn();
			String sql = "select * from usersFocus where mid="+fl.getMid()+" and midFocus="+fl.getMidFocus();
			rs = DB.getRs(sql);
			if(!rs.first()){
				sql="INSERT INTO usersFocus(mid,midFocus) VALUES('"+fl.getMid()+"','"+fl.getMidFocus()+"')";
				i=DB.executeUpdate(sql);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 

		return i;		
	}
	
	public int DeleteFocus(Focuslist fl){			//取消关注
		int i=0;
		Statement stmt=null;			
		try {
			DBconn DB = new DBconn();
			String sql="delete from usersFocus where mid="+fl.getMid()+" and midFocus="+fl.getMidFocus();
			i=DB.executeUpdate(sql);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 

		return i;		
	}
	public ArrayList AllFocus(Integer mid) throws Exception{
		ArrayList Flist = new ArrayList();
		String sql="select midFocus from usersFocus where mid="+mid;
		DBconn DB = new DBconn();
		ResultSet rs = DB.getRs(sql);
		while(rs.next()){
			Flist.add(rs.getInt(1));
		}
		return Flist;
	}
	public ArrayList AllZan(Integer mid) throws Exception{ //用户赞了的微博列表
		ArrayList Zanlist = new ArrayList();
		String sql="select midzan from userszan where mid="+mid;
		DBconn DB = new DBconn();
		ResultSet rs = DB.getRs(sql);
		while(rs.next()){
			Zanlist.add(rs.getInt(1));
		}
		return Zanlist;
	}
	public ArrayList WhoZan(Integer wbid,Integer flag) throws Exception{ //微博赞的用户
		ArrayList Zanlist = new ArrayList();
		ArrayList ZanlistFace = new ArrayList();
		String sql="select a.mid,b.face from userszan as a join users as b on a.mid = b.id where midzan="+wbid;
		System.out.println(sql);
		DBconn DB = new DBconn();
		ResultSet rs = DB.getRs(sql);
		while(rs.next()){
			Zanlist.add(rs.getInt(1));
			ZanlistFace.add(rs.getString(2));
		}
		if (flag==1){
			return ZanlistFace;
		}
			return Zanlist;
		
	}
	public int Zan(Integer mid,Integer wbid) throws Exception{			//判断是否赞
		int i=0;
		Statement stmt=null;
		String sql = "";
		DBconn DB = new DBconn();
		sql = "select * from userszan where midzan="+wbid+" and mid="+mid;

		ResultSet rs = DB.getRs(sql);
		if(!rs.first()){
			sql="INSERT INTO userszan(mid,midzan) VALUES('"+mid+"','"+wbid+"')";
		}else{
			sql="delete from userszan where mid="+mid+" and midzan="+wbid;
		}

		DB.executeUpdate(sql);
		sql = "select count(*) from userszan where midzan="+wbid;

	    rs = DB.getRs(sql);
		while(rs.next()){
			i = rs.getInt(1);
		}
		return i;		
	}
}
