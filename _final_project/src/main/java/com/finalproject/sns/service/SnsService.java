package com.finalproject.sns.service;

import java.util.ArrayList;
import java.util.Map;

import com.finalproject.sns.vo.FriendVO;
import com.finalproject.sns.vo.GroupVO;
import com.finalproject.sns.vo.MemVO;
import com.finalproject.sns.vo.MsgVO;
import com.finalproject.sns.vo.SearchajaxVo;
import com.finalproject.sns.vo.TextVO;

public interface SnsService {
	void deleteMem(MemVO memVO);

	ArrayList<FriendVO> getFriend(MemVO memVO) throws Exception;

	ArrayList<MemVO> searchUser(MemVO memVO) throws Exception;
	
	ArrayList<TextVO> searchtxt(String str) throws Exception;

	void addFriend(Map<String, Object> params) throws Exception;

	ArrayList<MsgVO> getAllMSG(MsgVO msgVO);
	
	MsgVO getMSG(MsgVO msgVO);
	
	void AddSNS_Msg(MsgVO msgVO);
	
	void AddSNS_Msg2(MsgVO msgVO);
	
	void upSns_frd(Map<String, Object> params);
	
	void upSns_Msg(MsgVO msgVO);

	void addGroup(GroupVO groupVO);
	
	SearchajaxVo searchajax(MemVO memVO);
	
	ArrayList<TextVO> friendsFeed(MemVO memVO);

	ArrayList<TextVO> getMyFeeds(String id);

	ArrayList<Integer> getTXT(String id);
}
