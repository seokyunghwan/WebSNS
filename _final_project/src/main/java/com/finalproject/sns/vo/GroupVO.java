package com.finalproject.sns.vo;

public class GroupVO {
	private int gNum;
	String groupName;
	String groupInfo;
	
	public GroupVO() {}
	public GroupVO(int gNum, String groupName, String groupInfo) {
		super();
		this.gNum = gNum;
		this.groupName = groupName;
		this.groupInfo = groupInfo;
	}
	
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public String getGroupInfo() {
		return groupInfo;
	}
	public void setGroupInfo(String groupInfo) {
		this.groupInfo = groupInfo;
	}
	public int getGNum() {
		return gNum;
	}
	public void setGNum(int gNum) {
		this.gNum = gNum;
	}
	
	
}
