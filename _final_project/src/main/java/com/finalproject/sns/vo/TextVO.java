package com.finalproject.sns.vo;

import java.util.Date;

public class TextVO {
	private int TXT_NUM;
	private String id;
	private Date TXT_DATE;
	private String txt;
	private String TXT_FILE;
	private String HASH_TAG;
	private String privacy;
	
	

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
	public Date getTXT_DATE() {
		return TXT_DATE;
	}
	public void setTXT_DATE(Date tXT_DATE) {
		TXT_DATE = tXT_DATE;
	}
	public String getTxt() {
		return txt;
	}
	public void setTxt(String txt) {
		this.txt = txt;
	}
	public String getTXT_FILE() {
		return TXT_FILE;
	}
	public void setTXT_FILE(String tXT_FILE) {
		TXT_FILE = tXT_FILE;
	}

	public String getHASH_TAG() {
		return HASH_TAG;
	}

	public void setHASH_TAG(String hASH_TAG) {
		HASH_TAG = hASH_TAG;
	}

	public String getPrivacy() {
		return privacy;
	}
	public void setPrivacy(String privacy) {
		this.privacy = privacy;
	}
	
	
	
	
	
}
