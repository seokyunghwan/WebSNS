package com.finalproject.sns.service.dao;

import java.util.ArrayList;

import com.finalproject.sns.vo.CommentVO;
import com.finalproject.sns.vo.GoodBadVO;
import com.finalproject.sns.vo.TextVO;

public interface FeedDAO {

	String getFeedCount();
	
	void insertText(TextVO textVO);

	void insertImg(TextVO textVO);

	ArrayList<CommentVO> getComments(CommentVO commentVO);

	TextVO getFeed(String tXT_NUM);

	ArrayList<GoodBadVO> getGoodBad(GoodBadVO goodBadVO);

	ArrayList<Integer> getTXT_NUM(String id);

	void goodInsertPlus(GoodBadVO goodBadVO);

	void badInsertPlus(GoodBadVO goodBadVO);
	
	void deleteGoodBad(GoodBadVO goodBadVO);

	int getLikeCount(GoodBadVO goodBadVO);

	int getHateCount(GoodBadVO goodBadVO);

	void updateGoodBad(GoodBadVO goodBadVO);

	void addComment(CommentVO commentVO);

	

	

}
