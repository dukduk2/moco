package com.moco.finalProject;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.moco.file.FileManager;
import com.moco.fileTest.FileSaver;
import com.moco.member.MailService;
import com.moco.member.MemberDTO;
import com.moco.member.MemberService;

@Controller
@RequestMapping(value="/member/**")
public class MemberController {

	@Autowired
	private MemberService memberService;
	@Autowired
	private MailService mailService;
	
	@RequestMapping(value="memberJoin", method=RequestMethod.GET)
	public void memberJoin(){

	}
	
	@RequestMapping(value="memberJoin", method=RequestMethod.POST)
	public String memberJoin(MemberDTO memberDTO, MultipartFile f1, HttpSession session, RedirectAttributes redirectAttributes){
		String message = "회원가입 실패";
		int result = 0;
		
		// oname 셋팅
		memberDTO.setOname(f1.getOriginalFilename());
		FileSaver fileSaver = new FileSaver();
		try {
			// fname 셋팅/ 업로드
			String path = session.getServletContext().getRealPath("resources/upload/member");
			
			memberDTO.setFname(fileSaver.saver(f1, path));
			result = memberService.memberJoin(memberDTO);
			
			String from = "unique3552@gmail.com";
			String to = memberDTO.getEmail();
			String subject = "김유진과 아이들에서 "+memberDTO.getName()+"님의 가입을 감사드립니다.";
			String contents = "회원님께서는 "+memberDTO.getKind()+"으로 가입하셨습니다.\n"
					+ "회원가입을 진심으로 감사드리며 최고의 서비스를 제공해드리겠습니다.";
			mailService.sendMail(from, to, subject, contents);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(result>0){
			message = "회원가입 성공";
		}
		
		redirectAttributes.addFlashAttribute("message", message);
		return "/member/memberSuccess";
	}
	
	@RequestMapping(value="memberLogin", method=RequestMethod.GET)
	public void memberLogin(){
		
	}
	
	//로그인 수정
	@RequestMapping(value="memberLogin", method=RequestMethod.POST)
	public String memberLogin(MemberDTO memberDTO, HttpSession session, RedirectAttributes redirectAttributes){
		String message = "Login Failed";
		String permission = "대기";
		
		try {
			memberDTO = memberService.memberLogin(memberDTO);
			if(memberDTO != null){
				permission = memberService.memberPermission(memberDTO.getId());
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(memberDTO != null && permission.equals("승인")){
			message = "Login Success";
			
			session.setAttribute("memberDTO", memberDTO);
			redirectAttributes.addFlashAttribute("message", message);
			
			
		} else {
			message = "아이디/비밀번호를 확인하세요.";
			
			if(memberDTO != null && !permission.equals("승인")){
					System.out.println("현재 상태 : "+permission);
					message = "승인을 기다리고 있습니다.";
					redirectAttributes.addFlashAttribute("message", message);
			}

			redirectAttributes.addFlashAttribute("message", message);
		}

		return "redirect:/#go";
	}
	
	@RequestMapping(value="memberLogout", method=RequestMethod.GET)
	public String memberLogout(HttpSession session){
		session.invalidate();
		
		return "redirect:/";
	}
	
	@RequestMapping(value="memberView", method=RequestMethod.GET)
	public void memberView(HttpSession session, Model model){
		MemberDTO memberDTO = null;
		
		try {
			memberDTO = memberService.memberView((MemberDTO)session.getAttribute("memberDTO"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		model.addAttribute("memberDTO", memberDTO);
	}
	
	//회원이 delete
	@RequestMapping(value="memberDelete", method=RequestMethod.GET)
	public String memberDelete(HttpSession session, RedirectAttributes redirectAttributes){
		String message = "Member Delete Fail";
		int result = 0;
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("memberDTO");
		
		System.out.println("id : "+memberDTO.getId());
		
		try {
			result = memberService.memberDelete(memberDTO.getId());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(result>0){
			message = "Member Delete Success";
			session.invalidate();
		}
		redirectAttributes.addFlashAttribute("message", message);
		
		return "redirect:/";
	}
	
	//멤버 수정
	@RequestMapping(value="memberUpdate", method=RequestMethod.GET)
	public void memberUpdate(HttpSession session, Model model){
		MemberDTO memberDTO = null;
		
		try {
			memberDTO = memberService.memberView((MemberDTO)session.getAttribute("memberDTO"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		model.addAttribute("memberDTO", memberDTO);
	}
	
	@RequestMapping(value="memberUpdate", method=RequestMethod.POST)
	public String memberUpdate(MemberDTO memberDTO, MultipartFile f1, HttpSession session, RedirectAttributes redirectAttributes){
		String message = "Member Update Fail";
		int result = 0;
		FileSaver fileSaver = new FileSaver();
		
		if(!f1.getOriginalFilename().equals("")){
			//oname 세팅
			memberDTO.setOname(f1.getOriginalFilename());
		
			try {
				String path = session.getServletContext().getRealPath("resources/upload/member");
				// 파일 업로드
				memberDTO.setFname(fileSaver.saver(f1, path));
				
				// 정보 업데이트
				result = memberService.memberUpdate(memberDTO);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			memberDTO.setFname(" ");
			memberDTO.setOname(" ");
			try {
				result = memberService.memberUpdate(memberDTO);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		if(result>0){
			message="Member Update Success";
		}
		
		redirectAttributes.addFlashAttribute("message", message);
		session.setAttribute("memberDTO", memberDTO);
		
		return "redirect:/";
	}
	
	//아이디체크
	@RequestMapping(value="memberIdCheck", method=RequestMethod.POST)
	public String memberIdCheck(String id, Model model){
		boolean check = false;
		
		System.out.println("Checking ID : "+id);
		
		try {
			check = memberService.memberIdCheck(id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String message = "<font color='red'>이미 존재하는 아이디입니다.</font>";

		if(check == true){
			message = "<font color='blue'>사용가능한 아이디 입니다.</font>";
		}
		
		model.addAttribute("message", message);
		
		return "member/action/memberCheckResult";
	}
	
	//회원 사진 삭제
	@RequestMapping(value="memberFileDelete", method=RequestMethod.POST)
	public String MemberFileDelete(MemberDTO memberDTO, HttpSession session){
		
		FileManager fileManager = new FileManager();		
		fileManager.fileDelete(session.getServletContext().getRealPath("resources/upload/member"), memberDTO.getFname());
		
		try {
			memberService.memberFileDelete(memberDTO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "member/action/memberFileDeleteResult";
	}
	
	@RequestMapping(value="memberSearch", method=RequestMethod.GET)
	public void memberSearch(String kind, Model model){
		model.addAttribute("kind", kind);
	}

	//아이디 찾기
	@RequestMapping(value="memberSearchID", method=RequestMethod.POST)
	public String memberSearchID(String name, String email, RedirectAttributes redirectAttributes){
		String message = "";
		
		try {
			message = memberService.memberSearchID(name, email);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(message != null){
			redirectAttributes.addFlashAttribute("message", "회원님의 ID 는 "+message+" 입니다.");
		} else {
			redirectAttributes.addFlashAttribute("message", "회원 정보를 찾을 수 없습니다.");
		}

		return "redirect:/";
	}
	
	//질문 검색
	@RequestMapping(value="memberQuestionCheck", method=RequestMethod.POST)
	public String memberQuestionCheck(String id, Model model){
		String message = "?";
		try {
			message = memberService.memberQuestionCheck(id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		model.addAttribute("message", message);

		return "member/action/memberCheckResult";
	}
	
	@RequestMapping(value="memberSearchPW", method=RequestMethod.POST)
	public String memberSearchPW(String id, String email, String answer, RedirectAttributes redirectAttributes){
		String message = "";
		
		try {
			message = memberService.memberSearchPW(id, email, answer);
			System.out.println("Search ID : "+message);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(message != null){
			String from = "unique3552@gmail.com";
			String to = email;
			String subject = id+"님의 비밀번호입니다.";
			String contents = "회원님의 PW 는 "+message+" 입니다.";
			mailService.sendMail(from, to, subject, contents);
			redirectAttributes.addFlashAttribute("message", "회원님의 비밀번호를 이메일로 전송해드렸습니다.");
		} else if(message == null) {
			redirectAttributes.addFlashAttribute("message", "회원 정보를 찾을 수 없습니다.");
		}

		return "redirect:/";
	}	
}