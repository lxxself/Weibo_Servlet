<%@ page contentType="text/html; charset=gb2312" %> 
<%@ page language="java" %> 
<%@ page import="com.mysql.jdbc.Driver" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="com.moudle.DBconn" %> 
<% 
//���������� 
String driverName="com.mysql.jdbc.Driver"; 
//���ݿ��û��� 
String userName="root"; 
//���� 
String userPasswd="1221"; 
//���ݿ��� 
String dbName="weibo"; 
//���� 
String tableName="users"; 
//�����ַ��� 
String url="jdbc:mysql://localhost:3306/"+dbName+"?user="+userName+"&password="+userPasswd; 
Class.forName("com.mysql.jdbc.Driver").newInstance(); 
Connection conn=DriverManager.getConnection(url); 
Statement statement = conn.createStatement();
String sql="SELECT * FROM "+tableName; 
ResultSet rs = statement.executeQuery(sql); 
//������ݽ������ 
ResultSetMetaData rmeta = rs.getMetaData(); 
//ȷ�����ݼ������������ֶ��� 
int numColumns=rmeta.getColumnCount(); 
// ���ÿһ������ֵ 
out.print("username"); 
out.print("|"); 
out.print("email"); 
out.print("<br>"); 
while(rs.next()) { 
out.print(rs.getString(2)+" "); 
out.print("|"); 
out.print(rs.getString(3)); 
out.print("<br>"); 
} 
out.print("<br>"); 
out.print("���ݿ�����ɹ�����ϲ��"); 
rs.close(); 
statement.close(); 
%> 