package com.finalproject.sns.vo;

import org.springframework.web.socket.WebSocketSession;

public class WBVO {
	private WebSocketSession wb;
	private String name;
	public WBVO() {}
	public WBVO(WebSocketSession wb, String name) {
		super();
		this.wb=wb;
		this.name=name;
	}
	public WebSocketSession getWb() {
		return wb;
	}
	public void setWb(WebSocketSession wb) {
		this.wb = wb;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}
