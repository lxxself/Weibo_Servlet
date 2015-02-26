package com.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.moudle.Commentlist;
import com.moudle.DBconn;
import com.moudle.Wblist;

public class CommentService {
	public int AddCom(Commentlist cl){			//增加评论
		int i=0;
		DBconn DB = new DBconn();
		Connection conn = null;	
		try {
			conn=DB.getCon();
			String sql="insert into comments (mid,wbid,comment,ctime) values (?,?,?,?)";
			PreparedStatement pstmt =conn.prepareStatement(sql);
			pstmt.setInt(1,cl.getMid());
			pstmt.setInt(2,cl.getWbid());
			pstmt.setString(3,cl.getComment());
			pstmt.setString(4,cl.getCtime());
			pstmt.execute();
			pstmt.close(); 
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 

		return i;		
	}		
	public ArrayList<Commentlist> selectAll(String sql) throws Exception{	
		Statement stmt=null;					//查询评论
		ArrayList<Commentlist> cls =new ArrayList<Commentlist>();
		ResultSet rs =null;
		try {
			DBconn DB = new DBconn();
			if(sql.equals(""))
			sql="select b.username,b.face,a.* from comments as a join users as b on a.mid=b.id order by ctime";
			System.out.println(sql);
			rs = DB.getRs(sql);
			while(rs.next()){
				Commentlist cl=new Commentlist();
				cl.setUsername(rs.getString("username"));
				cl.setFace(rs.getString("face"));
				cl.setComment(rs.getString("comment"));
				cl.setCtime(rs.getString("ctime"));
				cls.add(cl);
			}
		}catch(SQLException sqle){
			sqle.printStackTrace();
		}
		return cls;
	}
}
