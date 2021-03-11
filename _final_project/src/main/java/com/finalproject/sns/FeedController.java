package com.finalproject.sns;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.finalproject.sns.service.FeedService;
import com.finalproject.sns.service.MemberService;
import com.finalproject.sns.vo.CommentVO;
import com.finalproject.sns.vo.GoodBadVO;
import com.finalproject.sns.vo.MemVO;
import com.finalproject.sns.vo.TextVO;

@Controller
public class FeedController {
	
	@Autowired
	private FeedService feedService;
	
	@Autowired
	private MemberService memberService;
	
	//Feed 등록
	@RequestMapping(value = "/writeFeed.do")
	public String writeFeed(TextVO textVO, @RequestParam("txtFile2")MultipartFile[] files, HttpServletRequest request) throws Exception {
		String imgname = "";
		if(!files[0].isEmpty()) {
			String root_path = request.getSession().getServletContext().getRealPath("/");
			String attach_path = "/resources/img/feed/";
			for(int i=0 ; i<files.length ; i++) {
				String extension = FilenameUtils.getExtension(files[i].getOriginalFilename());
				String imsi = feedService.getFeedCount() + "_" + i + "." + extension;
				File file = new File(root_path + attach_path + imsi);
				files[i].transferTo(file);
				imgname += imsi + "/";
			}
			imgname = imgname.substring(0, imgname.length()-1);
			textVO.setTXT_FILE(imgname);
			feedService.insertImg(textVO);
	               
		}
		else {
			feedService.insertText(textVO);
		}      
		return "redirect:/mainpage.do";
	}
	
	//피드 불러오기
	@RequestMapping(value = "/getFeed.do")
	public String getFeed(GoodBadVO goodBadVO, CommentVO commentVO, TextVO textVO, MemVO memVO, Model model, HttpServletRequest request) {
		String id = request.getParameter("id");
		String TXT_NUM = request.getParameter("TXT_NUM");
		//댓글
		ArrayList<CommentVO> commentList = feedService.getComments(commentVO);
		//피드
		textVO = feedService.getFeed(TXT_NUM);
		//피드 게시자
		memVO.setId(id);
		MemVO feedOwner = memberService.getOne(memVO);
		
		//좋아요 싫어요 수
		ArrayList<GoodBadVO> result = feedService.getGoodBad(goodBadVO);
		int like=0;
		int hate=0;
		for(GoodBadVO vo : result) {
			if(vo.getGOODBAD().equals("O")) {
				like++;
			} else if(vo.getGOODBAD().equals("X")) {
				hate++;
			}
		}
		goodBadVO.setLike(like);
		goodBadVO.setHate(hate);
		
		
		model.addAttribute("commentList", commentList);
		model.addAttribute("textVO", textVO);
		model.addAttribute("feedOwner", feedOwner);
		model.addAttribute("goodBadVO", goodBadVO);
		model.addAttribute("result", result);
		
		return "news";
	}
	
	//최근 피드 불러오기
	@RequestMapping(value = "/getRecentFeed.do")
	public String getRecentFeed(GoodBadVO goodBadVO, CommentVO commentVO, TextVO textVO, MemVO memVO, Model model, HttpServletRequest request) {
		String TXT_NUM = request.getParameter("TXT_NUM");
		//댓글
		ArrayList<CommentVO> commentList = feedService.getComments(commentVO);
		//피드
		textVO = feedService.getFeed(TXT_NUM);
		//피드 게시자
		memVO.setId(textVO.getId());
		MemVO feedOwner = memberService.getOne(memVO);
		
		//좋아요 싫어요 수
		ArrayList<GoodBadVO> result = feedService.getGoodBad(goodBadVO);
		int like=0;
		int hate=0;
		for(GoodBadVO vo : result) {
			if(vo.getGOODBAD().equals("O")) {
				like++;
			} else if(vo.getGOODBAD().equals("X")) {
				hate++;
			}
		}
		goodBadVO.setLike(like);
		goodBadVO.setHate(hate);
		
		
		model.addAttribute("textVO", textVO);
		model.addAttribute("commentList", commentList);
		model.addAttribute("feedOwner", feedOwner);
		model.addAttribute("goodBadVO", goodBadVO);
		model.addAttribute("result", result);
		
		return "news";
	}

	
	//내 피드 불러오기
	@ResponseBody
	@RequestMapping(value = "/getMyFeed.do")
	public ArrayList<Integer> getMyFeeds(Model model, MemVO memVO, CommentVO commentVO, GoodBadVO goodBadVO, HttpServletRequest request) {
		String id = request.getParameter("id");
		ArrayList<Integer> myFeedTXT_NUM = feedService.getTXT_NUM(id);
		return myFeedTXT_NUM;
	}
	
	@ResponseBody
	@RequestMapping(value = "/goodButtonPlus.do")
	public String goodButtonPlus(GoodBadVO goodBadVO, HttpServletRequest request) {
		feedService.goodInsertPlus(goodBadVO);
		return Integer.toString(goodBadVO.getLike());
	}
	
	@ResponseBody
	@RequestMapping(value = "/badButtonPlus.do")
	public String badButtonPlus(GoodBadVO goodBadVO, HttpServletRequest request) {
		
		feedService.badInsertPlus(goodBadVO);
		return Integer.toString(goodBadVO.getHate());
	}

	@ResponseBody
	@RequestMapping(value = "/deleteGoodBad.do")
	public String deleteGoodBad(GoodBadVO goodBadVO, HttpServletRequest request) {
		feedService.deleteGoodBad(goodBadVO);
		if(request.getParameter("data").equals("good")) {
			return Integer.toString(feedService.getLikeCount(goodBadVO));
		} else {
			return Integer.toString(feedService.getHateCount(goodBadVO));
		}
	}

	@ResponseBody
	@RequestMapping(value = "/updateGoodBad.do")
	public Map<String, Object> updateGoodBad(GoodBadVO goodBadVO, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(request.getParameter("data").equals("good")) {
			goodBadVO.setGOODBAD("O");
		} else {
			goodBadVO.setGOODBAD("X");
		}
		feedService.updateGoodBad(goodBadVO);
		map.put("like",feedService.getLikeCount(goodBadVO));
		map.put("hate",feedService.getHateCount(goodBadVO));
		
		return map;
	}
	
	
	@RequestMapping(value = "addComment.do")
	public String addComment(CommentVO commentVO, Model model) {
		feedService.addComment(commentVO);
		return "redirect:/mainpage.do";
	}
}
