package com.finalproject.sns.service.impl;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finalproject.sns.service.FeedService;
import com.finalproject.sns.service.dao.FeedDAO;
import com.finalproject.sns.vo.CommentVO;
import com.finalproject.sns.vo.GoodBadVO;
import com.finalproject.sns.vo.TextVO;

@Service("feedService")
public class FeedServiceImpl implements FeedService{

	@Autowired
	private FeedDAO feedDao;
	
	@Override
	public String getFeedCount() {
		String result = null;
		try {
			result = feedDao.getFeedCount();
		} catch (Exception e) {
			result = "1";
		}
		return result;
	}

	@Override
	public void insertText(TextVO textVO) {
		feedDao.insertText(textVO);
	}
	
	@Override
	public void insertImg(TextVO textVO) {
		feedDao.insertImg(textVO);
	}

	@Override
	public ArrayList<CommentVO> getComments(CommentVO commentVO) {
		
		return feedDao.getComments(commentVO);
	}

	@Override
	public TextVO getFeed(String TXT_NUM) {
		
		return feedDao.getFeed(TXT_NUM);
	}

	@Override
	public ArrayList<GoodBadVO> getGoodBad(GoodBadVO goodBadVO) {
		
		return feedDao.getGoodBad(goodBadVO);
	}

	@Override
	public ArrayList<Integer> getTXT_NUM(String id) {
		
		return feedDao.getTXT_NUM(id);
	}

	@Override
	public void goodInsertPlus(GoodBadVO goodBadVO) {
		feedDao.goodInsertPlus(goodBadVO);
	}
	
	@Override
	public void badInsertPlus(GoodBadVO goodBadVO) {
		feedDao.badInsertPlus(goodBadVO);
	}
	
	@Override
	public void deleteGoodBad(GoodBadVO goodBadVO) {
		feedDao.deleteGoodBad(goodBadVO);
	}

	@Override
	public int getLikeCount(GoodBadVO goodBadVO) {
		return feedDao.getLikeCount(goodBadVO);
	}

	@Override
	public int getHateCount(GoodBadVO goodBadVO) {
		return feedDao.getHateCount(goodBadVO);
	}

	@Override
	public void updateGoodBad(GoodBadVO goodBadVO) {
		feedDao.updateGoodBad(goodBadVO);
	}

	@Override
	public void addComment(CommentVO commentVO) {
		feedDao.addComment(commentVO);
	}

}
