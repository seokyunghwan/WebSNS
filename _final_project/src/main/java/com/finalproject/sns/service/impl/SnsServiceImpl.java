package com.finalproject.sns.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finalproject.sns.service.SnsService;
import com.finalproject.sns.service.dao.SnsDAO;
import com.finalproject.sns.vo.CommentVO;
import com.finalproject.sns.vo.FriendVO;
import com.finalproject.sns.vo.GoodBadVO;
import com.finalproject.sns.vo.GroupVO;
import com.finalproject.sns.vo.MemVO;
import com.finalproject.sns.vo.MsgVO;
import com.finalproject.sns.vo.SearchajaxVo;
import com.finalproject.sns.vo.TextVO;

@Service("snsService")
public class SnsServiceImpl implements SnsService {

	@Autowired
	private SnsDAO snsDao;



	@Override
	public void upSns_frd(Map<String, Object> params) {
		snsDao.upSns_frd(params);
	}
	@Override
	public void upSns_Msg(MsgVO msgVO) {
		snsDao.upSns_Msg(msgVO);
	}
	
	@Override
	public void deleteMem(MemVO memVO) {
		snsDao.deleteMem(memVO);
	}
	
	@Override
	public ArrayList<FriendVO> getFriend(MemVO memVO) {
		return snsDao.getFriend(memVO);
	}

	@Override
	public ArrayList<MsgVO> getAllMSG(MsgVO msgVO) {
		return snsDao.getAllMSG(msgVO);
	}
	
	@Override
	public MsgVO getMSG(MsgVO msgVO) {
		return snsDao.getMSG(msgVO);
	}
	
	@Override
	public ArrayList<MemVO> searchUser(MemVO memVO) {
		System.out.println("서비스임플 진입.");
		return snsDao.searchUser(memVO);
	}
	
	@Override
	public ArrayList<TextVO> searchtxt(String str) {
		return snsDao.searchtxt(str);
	}

	public void addFriend(Map<String, Object> params) throws Exception {
		snsDao.addFriend(params);
	}
	
	@Override
	public void AddSNS_Msg(MsgVO msgVO) {
		snsDao.AddSNS_Msg(msgVO);
	}
	
	@Override
	public void AddSNS_Msg2(MsgVO msgVO) {
		snsDao.AddSNS_Msg2(msgVO);
	}

	@Override
	public void addGroup(GroupVO groupVO) {
		snsDao.addGroup(groupVO);
	}
	
	@Override
	public SearchajaxVo searchajax(MemVO memVO) {
		return snsDao.searchajax(memVO);
	}
	
	@Override
	public ArrayList<TextVO> friendsFeed(MemVO memVO) {
		
		return snsDao.friendsFeed(memVO);
	}

	@Override
	public ArrayList<TextVO> getMyFeeds(String id) {
		
		return snsDao.getMyFeeds(id);
	}

	@Override
	public ArrayList<Integer> getTXT(String id) {
		
		return snsDao.getTXT(id);
	}


}
