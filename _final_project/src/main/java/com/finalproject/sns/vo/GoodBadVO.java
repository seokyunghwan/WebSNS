package com.finalproject.sns.vo;

public class GoodBadVO {
	private int TXT_NUM;
	private String id;
	private String GOODBAD;
	private int like;
	private int hate;
	
	public int getTXT_NUM() {
		return TXT_NUM;
	}

	public void setTXT_NUM(int tXT_NUM) {
		TXT_NUM = tXT_NUM;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getGOODBAD() {
		return GOODBAD;
	}

	public void setGOODBAD(String gOODBAD) {
		GOODBAD = gOODBAD;
	}

	public int getLike() {
		return like;
	}

	public void setLike(int like) {
		this.like = like;
	}

	public int getHate() {
		return hate;
	}

	public void setHate(int hate) {
		this.hate = hate;
	}
	

	
	
	
}
