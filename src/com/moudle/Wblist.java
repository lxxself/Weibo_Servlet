package com.moudle;



public class Wblist {
	private int wbid;
	private int mid;
	private String username;
	private String face;

	private String content;
	private int zan;
	private int ping;
	private int zhuang;
	private String wbtime;
	private String device;
	public String getFace() {
		return face;
	}
	public void setFace(String face) {
		this.face = face;
	}
	public String getImgname() {
		return imgname;
	}
	public void setImgname(String imgname) {
		this.imgname = imgname;
	}
	public String getImgpath() {
		return imgpath;
	}
	public void setImgpath(String imgpath) {
		this.imgpath = imgpath;
	}
	private String imgname;
	private String imgpath;
	public int getWbid() {
		return wbid;
	}
	public void setWbid(int wbid) {
		this.wbid = wbid;
	}
	public int getMid() {
		return mid;
	}
	public void setMid(int mid) {
		this.mid = mid;
	}

	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public int getZan() {
		return zan;
	}
	public void setZan(int zan) {
		this.zan = zan;
	}
	public int getPing() {
		return ping;
	}
	public void setPing(int ping) {
		this.ping = ping;
	}
	public int getZhuang() {
		return zhuang;
	}
	public void setZhuang(int zhuang) {
		this.zhuang = zhuang;
	}
	public String getWbtime() {
		return wbtime;
	}
	public void setWbtime(String wbtime) {
		this.wbtime = wbtime;
	}
	public String getDevice() {
		return device;
	}
	public void setDevice(String device) {
		this.device = device;
	}

}
