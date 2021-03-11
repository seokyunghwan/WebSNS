package com.finalproject.sns.vo;

public class FriendVO {
	private String frid;
	private String frname;
	private String loginstate;
	public String getFrid() {
		return frid;
	}
	public void setFrid(String frid) {
		this.frid = frid;
	}
	public String getFrname() {
		return frname;
	}
	public void setFrname(String frname) {
		this.frname = frname;
	}
	public String getLoginstate() {
		return loginstate;
	}
	public void setLoginstate(String loginstate) {
		this.loginstate = loginstate;
	}
	@Override
	public String toString() {
		return frid + "/" + frname + "/" + loginstate;
	}
	
}
