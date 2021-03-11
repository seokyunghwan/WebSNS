package com.finalproject.sns.service;

import java.sql.SQLException;

import com.finalproject.sns.vo.MemVO;

public interface MemberService {

	String searchId(MemVO memVO);	//아이디 찾기

	String searchPw(MemVO memVO);

	MemVO updateProfile(MemVO memVO);

	MemVO updateVO(MemVO memVO);

	void updateMem(MemVO memVO);

	MemVO login(MemVO memVO);

	int searchEmail(String parameter);

	void insertMem(MemVO memVO) throws SQLException;

	void loginmem(MemVO memVO);

	MemVO getOne(MemVO memVO);

	void deleteMem(String id);

	void logoutmem(MemVO memVO);

}
