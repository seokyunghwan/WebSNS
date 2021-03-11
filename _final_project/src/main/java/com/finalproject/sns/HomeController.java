package com.finalproject.sns;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.finalproject.sns.service.MemberService;
import com.finalproject.sns.service.SnsService;
import com.finalproject.sns.vo.CommentVO;
import com.finalproject.sns.vo.FriendVO;
import com.finalproject.sns.vo.GoodBadVO;
import com.finalproject.sns.vo.GroupVO;
import com.finalproject.sns.vo.MemVO;
import com.finalproject.sns.vo.MsgVO;
import com.finalproject.sns.vo.SearchajaxVo;
import com.finalproject.sns.vo.TextVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	@Resource(name = "snsService")
	private SnsService snsService;
	
	@Autowired
	private JavaMailSender mailSender;
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	ArrayList<FriendVO> arr = null;
	ArrayList<TextVO> friendsFeed = null;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/searchUser.do")
	public String searchUser(@ModelAttribute("memVO") MemVO memVO, Model model) throws Exception {
		ArrayList<MemVO> arr = snsService.searchUser(memVO);
		model.addAttribute("alist", arr);
		return "ShowUser";
	}
	@RequestMapping(value="/newGroup.do")
	public String newGroupForm(@ModelAttribute("memVO") MemVO memVO, Model model) {
		return "newGroup";
	}

	@RequestMapping(value = "/addfriendDB.do")
	public String addfriendDB(MsgVO MsgVO , Model model) throws Exception {
		snsService.AddSNS_Msg(MsgVO);
		return "TestChat";
	}
	
	@RequestMapping(value = "/ShowMSG.do" , method = RequestMethod.POST)
	public String ShowMSG(MsgVO msgVO, Model model) throws Exception {
		ArrayList<MsgVO> arr = snsService.getAllMSG(msgVO);
		model.addAttribute("alist", arr);
		return "MsgBox";
	}
	
	@RequestMapping(value = "/msg_pop.do")
	public String msg_pop(MsgVO msgVO, Model model) throws Exception {
		snsService.upSns_Msg(msgVO);
		MsgVO imsi = snsService.getMSG(msgVO);
		model.addAttribute("msgpop", imsi);
		return "Msgpop";
	}
	
	@RequestMapping(value = "/friendTab.do")
	public String friendAll(Model model) throws Exception {
		return "FriendTab";
	}

	@RequestMapping(value = "/sessOK.do")
	public String mypage(MemVO memVO, Model model) throws Exception {
		arr = snsService.getFriend(memVO);// 1. 전역에 두고
		return "redirect:/mainpage.do";// mainpage.do로 이동
		// 메인페이지에 표기주소가 sessOK.do로 나와서 표기주소 바꾸기 위해 이렇게 했습니다.
	}


	@RequestMapping(value = "/mainpage.do") // sessOK.do에서 넘어옴
	public String mainPage(Model model, HttpServletRequest request) throws Exception {
		MemVO memVO = (MemVO)request.getSession().getAttribute("loginVO");
		friendsFeed = snsService.friendsFeed(memVO);
		model.addAttribute("alist", arr);// 전역에 등록된걸 여기서 모델에 등록
		model.addAttribute("friendsFeed", friendsFeed);
		return "mainpage";// 이러면 주소노출이 mainpage.do
	}

	@RequestMapping(value = "/updatepage.do")
	public String updatepage(Model model) throws Exception {
		return "update";
	}
	
	@ResponseBody
	@RequestMapping(value = "/FrReload.do", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String FrReload(MemVO memVO, Model model) throws Exception {
		arr = snsService.getFriend(memVO);
		model.addAttribute("alist", arr);
		String imsi = "";
		if (arr != null) {
			for (FriendVO vo : arr) {
				imsi += vo.getFrid() + "///" + vo.getFrname() + "///" + vo.getLoginstate() + "||";
			}
		}
		return imsi;
	}
	
	
	@ResponseBody
	@RequestMapping("/addFriend.do")
	public String addFriend(@RequestParam Map<String, Object> param, Model model) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", param.get("id"));
		params.put("fid", param.get("fid"));
		snsService.addFriend(params);

		params.put("id", param.get("fid"));
		params.put("fid", param.get("id"));
		snsService.addFriend(params);
		
		snsService.upSns_frd(param);
		
		return "TestChat";
	}
	
	@ResponseBody
	@RequestMapping("/NoFriend.do")
	public String NoFriend(@RequestParam Map<String, Object> param, Model model) throws Exception {		
		snsService.upSns_frd(param);
		
		return "TestChat";
	}
	
	@ResponseBody
	@RequestMapping(value="/auth.do")
	public String mailSending(HttpServletRequest request, Model model) throws Exception {

		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();
		for (int i = 0; i < 6; i++) {
			temp.append(rnd.nextInt(10));
		} 
		final String subject = "본인인증 메일입니다.";
		final String from = "kgemailtest4@gmail.com";
		final String to = request.getParameter("e_mail");

		final String content = System.getProperty("line.separator") + "인증번호를 회원가입란에 입력해주세요."
				+ System.getProperty("line.separator") + System.getProperty("line.separator") + "인증 번호는 " + temp
				+ " 입니다." + System.getProperty("line.separator") + System.getProperty("line.separator");

		try {
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(mail, true, "UTF-8");
			messageHelper.setSubject(subject);
			messageHelper.setTo(to);
			messageHelper.setFrom(from);
			messageHelper.setText(content);
//			mailSender.send(mail);
		} catch (Exception e) {

		}
		return temp.toString();
	}
	
	@RequestMapping(value = "/addGroup.do")
	public void addGroup(GroupVO groupVO, Model model) {
		snsService.addGroup(groupVO);
	}
	
	@ResponseBody
	@RequestMapping(value = "/srcajax.do", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String srcajax(MemVO memVO,Model model) throws Exception {
		SearchajaxVo count1 = snsService.searchajax(memVO);
		return count1.getMmcnt() + "///" + count1.getTxcnt() + "///" + count1.getGrcnt();
	}
	
	@RequestMapping(value = "/SendMSG.do" , method = RequestMethod.POST)
	   public String SendMSG(MsgVO msgVO, Model model, HttpServletRequest request) throws Exception {
	      model.addAttribute("read_id", request.getParameter("read_id"));
	      return "SendMessage";
	   }
	
	@RequestMapping(value = "/SendMSG2.do")
	public String SendMSG2(MsgVO msgVO, Model model) throws Exception {
		snsService.AddSNS_Msg2(msgVO);
		return "SendMessage";
	}
	
	@RequestMapping(value = "/friendpage.do")
	public String friendpage(Model model) throws Exception {
		return "Friendpage";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getsearchFeed.do")
	public ArrayList<Integer> getsearchFeed(Model model, MemVO memVO, CommentVO commentVO, GoodBadVO goodBadVO, HttpServletRequest request) {
		String txt = request.getParameter("txt");
		ArrayList<Integer> myFeedTXT_NUM = snsService.getTXT(txt);
		return myFeedTXT_NUM;
	}

	@ResponseBody
	@RequestMapping(value = "/getscFeed.do")
	public String getscFeed(Model model, MemVO memVO, CommentVO commentVO, GoodBadVO goodBadVO, HttpServletRequest request) throws Exception {
		String searchTxt2 = request.getParameter("txt");
		ArrayList<TextVO> myFeedTXT_sc = snsService.searchtxt(searchTxt2);
		String imsiarr = "";
		for(TextVO temp : myFeedTXT_sc) {
			imsiarr += temp.getId() + "///";
			imsiarr += temp.getTXT_NUM() + "||";

		}
		return imsiarr;
	}
	@RequestMapping(value = "/getMyFeed2.do")
	public String getMyFeed2(Model model, MemVO memVO, CommentVO commentVO, GoodBadVO goodBadVO, HttpServletRequest request) {

		return "center2";
	}
}
