package com.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;

import com.moudle.*;
public class WeiboService {
		public int insertMember(Member member){			//鎻掑叆Member鏂规硶
			int i=0;
			Statement stmt=null;			
			try {
				DBconn DB = new DBconn();
				String sql="INSERT INTO users(email,username,psword) VALUES('"+member.getEmail()+"','"+member.getUsername()+"','"+member.getPassword()+"')";
				i=DB.executeUpdate(sql);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 

			return i;		
		}
		public int AddWb(Wblist wblist){			//鏂板wb鏂规硶
			int i=0;
			DBconn DB = new DBconn();
			Connection conn = null;	

			//java.sql.Date date1= new java.sql.Date(now.getTime());  

			try {
				conn=DB.getCon();
				String sql="insert into wblist (mid,content,zan,ping,zhuang,wbtime,device,username,imgname,imgpath) values (?,?,?,?,?,?,'chrome',?,?,?)";
				PreparedStatement pstmt =conn.prepareStatement(sql);
				pstmt.setInt(1,wblist.getMid());
				pstmt.setString(2,wblist.getContent());
				pstmt.setInt(3,wblist.getZan());
				pstmt.setInt(4,wblist.getPing());
				pstmt.setInt(5,wblist.getZhuang());
				pstmt.setString(6,wblist.getWbtime());
				pstmt.setString(7,wblist.getUsername());
				pstmt.setString(8,wblist.getImgname());
				pstmt.setString(9,wblist.getImgpath());
				pstmt.execute();
				pstmt.close(); 
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 

			return i;		
		}		
		
		public ArrayList<Wblist> selectAll(String sql) throws Exception{	
			Statement stmt=null;					//查询wblist鏂规硶
			ArrayList<Wblist> wblist=new ArrayList<Wblist>();
			ResultSet rs =null;
			try {
				DBconn DB = new DBconn();
				if(sql.equals(""))
				sql="select b.face,a.*  from wblist as a join users as b on a.mid = b.id";
				System.out.println(sql);
				rs = DB.getRs(sql);
				while(rs.next()){
					Wblist Wblist=new Wblist();
					//头像tm有问题
					Wblist.setWbid(rs.getInt("wbid"));
					Wblist.setMid(rs.getInt("mid"));
					Wblist.setUsername(rs.getString("username"));
					Wblist.setFace(rs.getString("face"));
					Wblist.setContent(rs.getString("content"));
					Wblist.setZan(rs.getInt("zan"));
					Wblist.setPing(rs.getInt("ping"));
					Wblist.setZhuang(rs.getInt("zhuang"));
					Wblist.setWbtime(rs.getString("wbtime"));
					Wblist.setDevice(rs.getString("device"));
					
					Wblist.setImgname(rs.getString("imgname"));
					Wblist.setImgpath(rs.getString("imgpath"));
					wblist.add(Wblist);
				}
			}catch(SQLException sqle){
				sqle.printStackTrace();
			}
			return wblist;
		}
		
		public ArrayList<Member> selectAllMember(String sql){	
			Statement stmt=null;					//鏄剧ずmember鏂规硶
			ArrayList<Member> memberlist=new ArrayList<Member>();
			ResultSet rs =null;
			try {
				DBconn DB = new DBconn();
				if(sql.equals(""))
				sql="select * from users";
				rs = DB.getRs(sql);
				while(rs.next()){
					Member member=new Member();
					member.setId(rs.getInt("id"));
					member.setEmail(rs.getString("email"));
					member.setUsername(rs.getString("username"));
					member.setPassword(rs.getString("psword"));
					member.setFace(rs.getString("face"));
					member.setFollow(rs.getInt("follow"));
					member.setFocus(rs.getInt("focus"));
					member.setWbcount(rs.getInt("wbcount"));
					memberlist.add(member);
					}
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	
			return memberlist;
		}
		
		public int DeleteWb(Integer wbid){			//删除
			int i=0;
			DBconn DB = new DBconn();
			try {
				String sql="DELETE FROM wblist WHERE wbid="+wbid;
				i = DB.executeUpdate(sql);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 

			return i;		
		}
		
		public int AlterWb(Integer wbid,String content){			//修改
			int i=0;
			DBconn DB = new DBconn();
			try {
				String sql="update wblist set content='"+content+"' WHERE wbid="+wbid;
				System.out.println(sql);
				i = DB.executeUpdate(sql);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 

			return i;		
		}	
}

			
