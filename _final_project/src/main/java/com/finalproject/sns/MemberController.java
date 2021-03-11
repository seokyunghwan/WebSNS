package com.finalproject.sns;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.finalproject.sns.service.MemberService;
import com.finalproject.sns.vo.MemVO;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService; 
	
	
	//ID 찾기 페이지
	@RequestMapping(value = "/searchIdForm.do")
	public String searchIdForm() {					
		return "member/searchId";
	}
	
	//PW 찾기 페이지
	@RequestMapping(value = "/searchPwForm.do")		
	public String searchPwForm() {
		return "member/searchpw";
	}
	
	//회원정보 변경 페이지
	@RequestMapping(value = "/userUpdate.do")
	public String userUpdate(Model model) throws Exception {
		return "MypageUpdate";
	}
	
	//Mypage 페이지
	@RequestMapping(value = "/mypage.do")
	public String mypage(Model model) throws Exception {
		return "member/Mypage";
	}
	
	//로그인 페이지
	@RequestMapping(value = "/loginpage.do")
	public String loginpage(Model model) throws Exception {
		return "member/login";
	}
	
	//회원가입 페이지
	@RequestMapping(value = "/signup.do")
	public String signup(Model model) throws Exception {
		return "member/signup";
	}
	//페이지 이동-end
	
	
	//아이디 찾기
	@RequestMapping(value = "/searchId.do")
	public String searchId(MemVO memVO, Model model) {
		String id = memberService.searchId(memVO);
		if(id != null) {
			model.addAttribute("id", id);
		}
		return "member/searchIdresult";
	}
	
	//ID 중복체크
	@ResponseBody
	@RequestMapping(value = "/idCheck.do", method = RequestMethod.POST)
	public String idCheck(@ModelAttribute("memVO") MemVO memVO, Model model) {
		return (memberService.getOne(memVO)!=null) ? "fail" : "success";
	}
	
	//PW 찾기
	@RequestMapping(value ="/searchpw.do")
	public String searchPw(MemVO memVO, Model model) {
		String pw = memberService.searchPw(memVO);
		if(pw != null) {
			model.addAttribute("pw", pw);
		}
		return "member/passwordresult";
	}
		
	
	//프로필 사진 변경
	@RequestMapping(value = "/updateProfile.do")
	public String updateProfile(MemVO memVO, MultipartFile file, HttpServletRequest request, Model model) {

		if (!file.isEmpty()) {
			String root_path = request.getSession().getServletContext().getRealPath("/");
			String attach_path = "/resources/img/profile/";
			String extension = FilenameUtils.getExtension(file.getOriginalFilename());
			String memimg = memVO.getId() + "." + extension;
			memVO.setMemimg(memimg);
			File file2 = new File(root_path + attach_path + memimg);
			try {
				file.transferTo(file2);
			} catch (Exception e) {
				e.printStackTrace();
			}
			MemVO updateVO = memberService.updateProfile(memVO);
			model.addAttribute("loginVO", updateVO);
		}
		return "setSession";
	}
	
	//회원정보 수정
	@RequestMapping(value = "/UserUpdateConfirm.do")
	public String userUpdateConfirm(@ModelAttribute("memVO") MemVO memVO, Model model) {

		memberService.updateMem(memVO);

		MemVO loginVO = memberService.login(memVO);
		model.addAttribute("loginVO", loginVO);
		return "setSession";
	}
	
	//이메일 검색
	@ResponseBody
	@RequestMapping(value = "/searchEmail.do")
	public String searchEmail(HttpServletRequest request) {
		if (memberService.searchEmail(request.getParameter("e_mail")) == 0) {
			return "none";
		}
		return "success";
	}
	
	//회원가입
	@RequestMapping(value = "/memInsert.do") 
	public String memInsert(@ModelAttribute("memVO") MemVO memVO, Model model) {
		try {
			memberService.insertMem(memVO);
			MemVO loginVO = memberService.login(memVO);
			model.addAttribute("loginVO", loginVO);
			model.addAttribute("success", true);
		} catch (Exception e) {
			model.addAttribute("success", false);
			e.printStackTrace();
		}
		return "member/JoinSuccess";
	}
	
	//로그인
	@RequestMapping(value = "/login.do")
	public String login(@ModelAttribute("memVO") MemVO memVO, Model model) {
		MemVO loginVO = memberService.login(memVO);
		if (loginVO != null) {
			model.addAttribute("loginVO", loginVO);
			memberService.loginmem(memVO);
		}
		return "setSession";
	}
	
	//로그아웃
	@RequestMapping(value = "/logout.do")
	public String logout(@ModelAttribute("memVO") MemVO memVO, Model model) throws Exception {
		memberService.logoutmem(memVO);
		return "logout";
	}
	
	//회원탈퇴
	@ResponseBody
	@RequestMapping(value = "/deleteMem.do")
	public String deleteMem(HttpServletRequest request) {
		String id = request.getParameter("id");
		memberService.deleteMem(id);
		return "deleteMem";
	}
}
