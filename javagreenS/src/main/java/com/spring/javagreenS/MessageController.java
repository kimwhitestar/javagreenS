package com.spring.javagreenS;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
//@RequestMapping("/msg/{msgFlag}")
public class MessageController {

	@RequestMapping(value="/msg/{msgFlag}", method=RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag, Model m, 
		String mid,
		String nickName) {
		System.out.println("msgFlag : " + msgFlag);
		
		if (msgFlag.equals("memberInputOk")) {
			m.addAttribute("msg", "회원 등록됬습니다");
			m.addAttribute("url", "member/memberLogin");
		} else if (msgFlag.equals("memberInputNo")) {
			m.addAttribute("msg", "회원 등록 실패");
			m.addAttribute("url", "member/memberInputNo");
		} else if (msgFlag.equals("memberPwdCheckNo")) {
			m.addAttribute("msg", "비밀번호를 확인하세요");
			m.addAttribute("url", "member/memberPwdCheck");
		} else if (msgFlag.equals("memberUpdateOk")) {
			m.addAttribute("msg", "회원 수정됬습니다");
			m.addAttribute("url", "member/memberUpdate");
		} else if (msgFlag.equals("memberUpdateNo")) {
			m.addAttribute("msg", "회원정보 수정 실패");
			m.addAttribute("url", "member/memberUpdate");
		}	else if (msgFlag.equals("memberDeleteOk")) {
			m.addAttribute("msg", nickName + "님 회원 탈퇴됬습니다\\n 같은 아이디로 1개월간 가입할 수 없습니다");
			m.addAttribute("url", "member/memberLogin");
		} else if (msgFlag.equals("memberLoginOk")) {
			m.addAttribute("msg", "로그인됬습니다");
			m.addAttribute("url", "member/memberMain");
		} else if (msgFlag.equals("memberLoginNo")) {
			m.addAttribute("msg", "아이디를 확인하세요");
			m.addAttribute("url", "member/memberLogin");
		} else if (msgFlag.equals("memberLogoutOk")) {
			m.addAttribute("msg", nickName + "님 로그아웃됬습니다");
			m.addAttribute("url", "member/memberLogin");
		} else if (msgFlag.equals("memberNo")) {
			m.addAttribute("msg", "로그인하면 사용할 수 있습니다");
			m.addAttribute("url", "member/memberLogin");
		} else if (msgFlag.equals("levelLow")) {
			m.addAttribute("msg", "현재등급은 사용할 수 없습니다");
			m.addAttribute("url", "member/memberLogin");
		} else if (msgFlag.equals("guestInputOk")) {
			m.addAttribute("msg", "방명록 등록됬습니다");
			m.addAttribute("url", "guest/guestList");
		} else if (msgFlag.equals("memberIdCheckNo")) {
			m.addAttribute("msg", "아이디가 중복됬습니다");
			m.addAttribute("url", "member/memberJoin");
		} else if (msgFlag.equals("memberNickNameCheckNo")) {
			m.addAttribute("msg", "닉네임이 중복됬습니다");
			m.addAttribute("url", "member/memberJoin");
		} else if (msgFlag.equals("memberNickNameCheckNo2")) {
			m.addAttribute("msg", "닉네임이 중복됬습니다");
			m.addAttribute("url", "member/memberUpdate");
		} else if (msgFlag.equals("fileUploadOk")) {
			m.addAttribute("msg", "파일이 업로드됬습니다");
			m.addAttribute("url", "pdf/fileUpload");
		} else if (msgFlag.equals("fileUploadNo")) {
			m.addAttribute("msg", "파일업로드 실패");
			m.addAttribute("url", "pdf/fileUpload");
		} else if (msgFlag.equals("memberIdPwdFindoutOk")) {
			m.addAttribute("msg", "임시비밀번호가 이메일로 전송됬습니다");
			m.addAttribute("url", "member/memberLogin");
		} else if (msgFlag.equals("memberIdPwdFindoutNo")) {
			m.addAttribute("msg", "임시비밀번호 발급 실패");
			m.addAttribute("url", "member/memberLogin");
		} else if (msgFlag.equals("boardInputOk")) {
			m.addAttribute("msg", "게시글 등록됬습니다");
			m.addAttribute("url", "board/boardList");
		} else if (msgFlag.equals("boardDeleteOk")) {
			m.addAttribute("msg", "게시글 삭제됬습니다");
			m.addAttribute("url", "board/boardList");
		} else if (msgFlag.equals("boardUpdateOk")) {
			m.addAttribute("msg", "게시글 수정됬습니다");
			m.addAttribute("url", "board/boardList");
		} else if (msgFlag.equals("pdsInputOk")) {
			m.addAttribute("msg", "자료파일이 등록됬습니다");
			m.addAttribute("url", "pds/pdsList");
		} else if (msgFlag.equals("personInputOk")) {
			m.addAttribute("msg", "트랜잭션 정보가 등록됬습니다");
			m.addAttribute("url", "study/transaction/personList");
		}
		
		return "msg/message";
	}
	
//	@RequestMapping(value="/msgLogout/{msgFlag}/{name}", method=RequestMethod.GET)
//	public String msgLogoutGet(@PathVariable String msgFlag, @PathVariable String name, Model m) {
//		System.out.println("msgFlag : " + msgFlag);
//		System.out.println("name : " + name);
//		
//		if (msgFlag.equals("memberLogout")) {
//			m.addAttribute("msg", name + "님 로그아웃됬습니다");
//			m.addAttribute("url", "member/memberLogin");
//		}
//		
//		return "include/message";
//	}
}