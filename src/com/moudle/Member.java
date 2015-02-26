package com.moudle;

public class Member {
	private int id;
	private String username;
	private String email;
	private String password;
	private String face;
	private int follow;
	private int focus;
	private int wbcount;
	public String getFace() {
		return face;
	}
	public void setFace(String face) {
		this.face = face;
	}
	public int getFollow() {
		return follow;
	}
	public void setFollow(int follow) {
		this.follow = follow;
	}
	public int getFocus() {
		return focus;
	}
	public void setFocus(int focus) {
		this.focus = focus;
	}
	public int getWbcount() {
		return wbcount;
	}
	public void setWbcount(int wbcount) {
		this.wbcount = wbcount;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
}
