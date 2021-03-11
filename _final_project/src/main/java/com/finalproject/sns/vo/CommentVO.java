package com.finalproject.sns.vo;

import java.util.Date;

public class CommentVO {
	private String TXT_NUM;
	private String CM_ID;
	private String CM_COMMENT;
	private String MEMIMG;
	private Date COMMENT_DATE;
	
	public String getTXT_NUM() {
		return TXT_NUM;
	}

	public void setTXT_NUM(String tXT_NUM) {
		TXT_NUM = tXT_NUM;
	}

	public String getCM_ID() {
		return CM_ID;
	}

	public void setCM_ID(String cM_ID) {
		CM_ID = cM_ID;
	}

	public String getCM_COMMENT() {
		return CM_COMMENT;
	}

	public void setCM_COMMENT(String cM_COMMENT) {
		CM_COMMENT = cM_COMMENT;
	}

	public String getMEMIMG() {
		return MEMIMG;
	}

	public void setMEMIMG(String mEMIMG) {
		MEMIMG = mEMIMG;
	}

	public Date getCOMMENT_DATE() {
		return COMMENT_DATE;
	}

	public void setCOMMENT_DATE(Date cOMMENT_DATE) {
		COMMENT_DATE = cOMMENT_DATE;
	}


}
