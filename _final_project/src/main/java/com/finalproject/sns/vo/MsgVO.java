package com.finalproject.sns.vo;

public class MsgVO {
	private int msgnum;
	private String send_id;
	private String read_id;
	private String msg;
	private String mstate;
	private String add_Friend;
	
	public int getMsgnum() {
		return msgnum;
	}
	public void setMsgnum(int msgnum) {
		this.msgnum = msgnum;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getSend_id() {
		return send_id;
	}
	public void setSend_id(String send_id) {
		this.send_id = send_id;
	}
	public String getRead_id() {
		return read_id;
	}
	public void setRead_id(String read_id) {
		this.read_id = read_id;
	}
	public String getMstate() {
		return mstate;
	}
	public void setMstate(String mstate) {
		this.mstate = mstate;
	}
	public String getAdd_Friend() {
		return add_Friend;
	}
	public void setAdd_Friend(String add_Friend) {
		this.add_Friend = add_Friend;
	}
}
