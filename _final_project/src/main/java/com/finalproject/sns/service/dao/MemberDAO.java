package com.finalproject.sns.service.dao;

import com.finalproject.sns.vo.MemVO;

public interface MemberDAO {

	String searchId(MemVO memVO);

	String searchPw(MemVO memVO);

	void updateProfile(MemVO memVO);

	MemVO updateVO(MemVO memVO);

	void updateMem(MemVO memVO);

	MemVO login(MemVO memVO);

	int searchEmail(String email);

	void insertMem(MemVO memVO);

	void loginmem(MemVO memVO);

	MemVO getOne(MemVO memVO);

	void deleteMem(String id);

	void logoutmem(MemVO memVO);


}
