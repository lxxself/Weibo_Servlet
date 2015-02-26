package com.moudle;

import java.sql.*;
public class DBconn{
    private Connection con = null;
    private ResultSet rs;
    private String driverName = "com.mysql.jdbc.Driver"; 
    private String serverName = "localhost";
    private String mydatabase = "weibo";
    private String username = "root";
    private String password = "1221";

    public DBconn() {
        try {
            String url = "jdbc:mysql://" + serverName + "/" + mydatabase; // a
            Class.forName(driverName);
            // con = DriverManager.getConnection(url, username, password);
            con = DriverManager.getConnection("jdbc:mysql://" + serverName
                    + ":3306/" + mydatabase + "?user=" + username
                    + "&password=" + password
                    + "&useUnicode=true&characterEncoding=UTF-8");
            // con.setAutoCommit(false);
        } catch (ClassNotFoundException e) {
            // Could not find the database driver
            System.out.println("Could not find the database driver");
        } catch (SQLException e) {
            // Could not connect to the database
            System.out.println("Could not connect to the database");
        }
    }

    public Connection getCon() {
        return con;
    }

    public ResultSet getRs(String sql) throws Exception {
        try {
            Statement stmt = con.createStatement(
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            rs = stmt.executeQuery(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rs;
    }

    public int executeUpdate(String sql) {
        int count = 0;
        try {
            Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
            count = stmt.executeUpdate(sql);
            if (count != 0)
                ;
            // con.commit();
            else
                ;
            // con.rollback();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return count;
    }

    public void Close() {
        try {
            if (con != null)
                con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}