package com.finalproject.sns.service.impl;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finalproject.sns.service.MemberService;
import com.finalproject.sns.service.dao.MemberDAO;
import com.finalproject.sns.vo.MemVO;

@Service("memberService")
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public String searchId(MemVO memVO) {
		return memberDAO.searchId(memVO);
	}

	@Override
	public String searchPw(MemVO memVO) {
		return memberDAO.searchPw(memVO);
	}

	@Override
	public MemVO updateProfile(MemVO memVO) {
		memberDAO.updateProfile(memVO);
		return updateVO(memVO);
	}

	@Override
	public MemVO updateVO(MemVO memVO) {
		return memberDAO.updateVO(memVO);
	}

	@Override
	public void updateMem(MemVO memVO) {
		memberDAO.updateMem(memVO);
	}

	@Override
	public MemVO login(MemVO memVO) {
		MemVO result = memberDAO.login(memVO);
		if (result != null) {
			return result;
		} else {
			return null;
		}

	}

	@Override
	public int searchEmail(String email) {

		return memberDAO.searchEmail(email);
	}

	@Override
	public void insertMem(MemVO memVO) throws SQLException {
		memberDAO.insertMem(memVO);
	}


	@Override
	public void loginmem(MemVO memVO) {
		memberDAO.loginmem(memVO);
	}

	@Override
	public MemVO getOne(MemVO memVO) {
		MemVO result = memberDAO.getOne(memVO);
		if(result != null)
			return result;
		else
			return null;
	}

	@Override
	public void deleteMem(String id) {
		memberDAO.deleteMem(id);
	}

	@Override
	public void logoutmem(MemVO memVO) {
		memberDAO.logoutmem(memVO);
	}
}
