package com.finalproject.sns.vo;

public class MemVO {
	private String id;
	private String pw;
	private String memname;
	private String email;
	private String memimg;
	private String loginstate;//접속상태 db저장형태 'On' or 'Off'
	private String searchTxt; //조회조건( 이름 또는 ID )
	
	/*mybatis는 생성자가 없어도 돼요~~^^*/
	
	public String getSearchTxt() {
		return searchTxt;
	}

	public void setSearchTxt(String searchTxt) {
		this.searchTxt = searchTxt;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getMemname() {
		return memname;
	}
	public void setMemname(String memname) {
		this.memname = memname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMemimg() {
		return memimg;
	}

	public void setMemimg(String memimg) {
		this.memimg = memimg;
	}

	public String getLoginstate() {
		return loginstate;
	}

	public void setLoginstate(String loginstate) {
		this.loginstate = loginstate;
	}
	
}
