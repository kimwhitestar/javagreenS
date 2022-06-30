package com.spring.javagreenS;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS.common.Paging;
import com.spring.javagreenS.service.MemberService;
import com.spring.javagreenS.vo.MemberVO;
import com.spring.javagreenS.vo.PagingVO;

@RequestMapping("/member")
@Controller
public class MemberController {
	
	@Autowired
	public MemberService memberService;
	
	@Autowired
	public BCryptPasswordEncoder bCrypt;
	
//	@Autowired
//	public JavaMailSender mailSender;
	
	@Autowired
	public Paging paging;

	@RequestMapping(value = "/memberLogin", method = RequestMethod.GET)
	public String memberLoginGet(HttpServletRequest request) {

		Cookie[] cookies = request.getCookies();
		String mid = "";
		for (int i=0; i<cookies.length; i++) {
			if (cookies[i].getName().equals("cMid")) {
				mid = cookies[i].getValue();
				request.setAttribute("mid", mid);
				break;
			}
		}
		return "member/memberLogin";
	}
	
	@RequestMapping(value = "/memberLogin", method = RequestMethod.POST)
	public String memberLoginPost(HttpSession session, HttpServletRequest request, HttpServletResponse response,
		@RequestParam("mid") String mid,
		@RequestParam("pwd") String pwd,
		@RequestParam(name="idSave", defaultValue="", required=false) String idSave,
		Model model) {//Model쓸때는 RedirectAttribute를 같이 쓸 수 없다
		
//		if (bCrypt.matches(pwd, vo.getPwd())) {
//		}

		//로그인 정보 확인
		String bCryptPwd = bCrypt.encode(pwd);
		MemberVO loginVo = memberService.searchMemberLogin(mid, bCryptPwd);
		if (null == loginVo || !loginVo.getUserDel().equals("NO")) {
			//비회원 화면
			return "redirect:/msg/memberLoginNo";
		}
		
		String strLevel = "";
		switch( loginVo.getLevel() ) {
			case 0 : strLevel = "관리자"; break;
			case 1 : strLevel = "운영자"; break;
			case 2 : strLevel = "우수회원"; break;
			case 3 : strLevel = "정회원"; break;
			case 4 : strLevel = "준회원"; break;
			default : strLevel = "";
		}
		//회원인증 후 세션저장
		session.setAttribute("sMid", mid);
		session.setAttribute("sNickName", loginVo.getNickName());
		session.setAttribute("sLevel", loginVo.getLevel());
		session.setAttribute("strLevel", strLevel);

		//id저장
		if (idSave.equals("on")) {
			Cookie cookie = new Cookie("cMid", mid);
			cookie.setMaxAge(60*60*24*7); //쿠키저장기간 : 7일(단위:초)
			response.addCookie(cookie);
		} else {
			Cookie[] cookies = request.getCookies();
			for (int i=0; i<cookies.length; i++) {
				if (cookies[i].getName().equals("cMid")) {
					cookies[i].setMaxAge(0); //쿠키저장기간 : 0일(단위:초) -> 삭제
					response.addCookie(cookies[i]);
					break;
				}
			}
		}
		
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String strNow = sdf.format(now);
		//최종방문일과 오늘날짜 비교 후 다르면, 오늘방문횟수를 0으로 셋팅
		if (! loginVo.getLastDate().substring(0, 10).equals(strNow)) {
			loginVo.setTodayCnt(1);
			loginVo.setPoint(loginVo.getPoint() + 10); 
		} else {
			if (5 >= loginVo.getTodayCnt()) {
				loginVo.setTodayCnt(loginVo.getTodayCnt() + 1);
				loginVo.setPoint(loginVo.getPoint() + 10); 
			}
		}
		
		//오늘방문횟수, 최종방문횟수, 포인트 증가
		memberService.updateTodayVisitCntAndPoint(loginVo.getLastDate(), loginVo.getTodayCnt(), loginVo.getPoint(), mid);
		session.setAttribute("sPoint", loginVo.getPoint());
		session.setAttribute("sLastDate", loginVo.getLastDate());

		model.addAttribute("loginVo", loginVo);
		
		//회원 화면
		return "redirect:/msg/memberLoginOk";
	}
	
	@RequestMapping(value = "/memberMain", method =  RequestMethod.POST)
	public String memberMainPost(HttpSession session, MemberVO loginVo, Model model) {
		String sMid = (String)session.getAttribute("sMid");
		String sLevel = (String)session.getAttribute("sLevel");
		
		if ((null == sMid || 0 == sMid.trim().length())
			&& (null == sLevel || 0 == sLevel.trim().length())) {
			//비회원 화면
			return "redirect:/msg/memberLoginNo";
		}
		
		model.addAttribute("loginVo", loginVo);
		
		//회원방 화면
		return "member/memberMain";
	}
	
	@RequestMapping(value = "/memberList", method =  RequestMethod.POST)
	public String memberListPost(Model model, 
			@RequestParam(name="pageNo", defaultValue="1", required=false) int pageNo,
			@RequestParam(name="pageSize", defaultValue="3", required=false) int pageSize) {
		
		int blockSize = 3;//페이징할 블록 갯수
		PagingVO pagingVo = paging.totRecCnt(blockSize, pageNo, pageSize, "member", null, null);
		List<MemberVO> vos = memberService.searchMemberList(pagingVo.getStartIndexNo(), pagingVo.getPageSize());
		
		model.addAttribute("vos", vos);
		model.addAttribute("pagingVo", pagingVo);
		return "member/memberList";
	}
	
	@RequestMapping(value = "/memberDetail", method =  RequestMethod.POST)
	public String memberDetailPost(Model model, @RequestParam(name="mid", defaultValue="", required=true) String mid) {
		MemberVO vo = memberService.searchMember(mid);
		model.addAttribute("vo", vo);
		return "member/memberDetail";
	}
	
	@RequestMapping(value = "/memberPwdCheck", method = RequestMethod.GET)
	public String memberPwdCheckGet() {
		return "member/memberPwdCheck";
	}
	
	@RequestMapping(value = "/memberPwdCheck", method = RequestMethod.POST)
	public String memberPwdCheckPost(HttpSession session, Model model,
		@RequestParam(name="pwd", defaultValue="", required=true) String pwd) {
		
		String sMid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.searchMemberLogin(sMid, bCrypt.encode(pwd));
		
		//if (null != vo && bCrypt.matches(pwd, vo.getPwd()) {
		if (null != vo) {
			model.addAttribute("vo", vo);
			return "member/memberUpdate";
		} else {
			return "redirect:/msg/memberPwdCheckNo";
		}
	}
	
	@RequestMapping(value = "/memberLogout", method = RequestMethod.GET)
	public String memberLogoutGet(HttpSession session, Model model) {
		String sMid = (String) session.getAttribute("sMid");
		String sNickName = (String) session.getAttribute("sNickName");
		session.invalidate();//세션삭제
		model.addAttribute("mid", sMid);
		model.addAttribute("nickName", sNickName);
		return "redirect:/msg/memberLogoutOk";
	}
	
	@RequestMapping(value = "/memberIdCheck", method = RequestMethod.GET)
	public String memberIdCheckGet() {
		return "member/memberIdCheck";
	}
	
	@ResponseBody //ajax응답용
	@RequestMapping(value = "/memberIdCheck", method = RequestMethod.POST)
	public String memberIdCheckPost(@RequestParam("mid") String mid) {
		return memberService.searchMemberId(mid);
	}
	
	@RequestMapping(value = "/memberNickNameCheck", method = RequestMethod.GET)
	public String memberNickNameCheckGet() {
		return "member/memberNickNameCheck";
	}
	
	@ResponseBody //ajax응답용
	@RequestMapping(value = "/memberNickNameCheck", method = RequestMethod.POST)
	public String memberNickNameCheckPost(@RequestParam("nickName") String nickName) {
		return memberService.searchNickName(nickName);
	}
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public String memberJoinGet() {
		return "member/memberJion";
	}
	
	@RequestMapping(value="/memberJoin", method=RequestMethod.POST)
	public String memberJoinPost(MemberVO vo, MultipartFile fName) { //file 1개씩 올리기
		
		//아이디체크
		if (null != memberService.searchMemberId(vo.getMid())) {
			return "redirect:/msg/memberIdCheckNo";
		}
		
		//닉네임체크
		if (null != memberService.searchNickName(vo.getNickName())) {
			return "redirect:/msg/memberNickNameCheckNo";
		}
		
		//비밀번호 암호화 처리
		//vo.setPwd(bCrypt.encode(vo.getPwd()));
		
		//회원가입폼 DATA를 DB저장
		int res = memberService.insertMember(fName, vo); //사진화일이름만 별도 
		
		if (1 == res) return "redirect:/msg/memberInputOk";
		else return "redirect:/msg/memberInputNo";
	}
	
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.GET)
	public String memberUpdateGet() {
		return "member/memberUpdate";
	}
	
	@RequestMapping(value="/memberUpdate", method=RequestMethod.POST)
	public String memberUpdatePost(MultipartFile fName, MemberVO vo, HttpSession session) {
		
		//닉네임체크
		String sNickName = (String) session.getAttribute("sNickName");
		if (null != memberService.searchNickName(vo.getNickName()) 
			&& !sNickName.equals(vo.getNickName())) {
			return "redirect:/msg/memberNickNameCheckNo2";
		}
		
		//비밀번호 암호화 처리
		vo.setPwd(bCrypt.encode(vo.getPwd()));
		
		//회원정보수정폼 DATA를 DB저장
		int res = memberService.updateMember(fName, vo); //사진화일이름만 별도 
		
		if (1 == res) return "redirect:/msg/memberUpdateOk";
		else return "redirect:/msg/memberUpdateNo";
	}
	
	@RequestMapping(value = "/uuid/uuidForm", method = RequestMethod.GET)
	public String uuidFormGet() {
		return "study/uuid/uuidForm";
	}
	
	@RequestMapping(value = "/memberDelete", method = RequestMethod.GET)
	public String memberDeleteGet(HttpSession session, Model model) {
		String sMid = (String) session.getAttribute("sMid");
		String sNickName = (String) session.getAttribute("sNickName");
		//회원탈퇴는 userDel = 'OK'로 DB수정 -> 1개월 후 관리자가 회원삭제에서 DB delete처리
		memberService.updateUserDel(sMid); 
		session.invalidate(); //세션삭제
		model.addAttribute("nickName", sNickName);
		return "redirect:/msg/memberDeleteOk";
	}
	
	@RequestMapping(value = "/memberIdPwdFindout", method = RequestMethod.GET)
	public String memberIdPwdFindoutGet() {
		return "member/memberIdPwdFindout";
	}
	
	@RequestMapping(value = "/memberIdPwdFindout", method = RequestMethod.POST)
	public String memberIdPwdFindoutPost(
		@RequestParam(name="mid", defaultValue="", required = true) String mid, 
		@RequestParam(name="toMail", defaultValue="", required = true) String toMail) {
		
		MemberVO vo = memberService.searchMemberIdPwd(mid, toMail);
		if (null == vo) {
			return "redirect:/msg/memberIdPwdFindoutNo";
			
		} else {
			//memberId를 찾아서 회원확인이 되면, 임시비빌번호를 만든다
			UUID uuid = UUID.randomUUID();
			String pwd = uuid.toString().substring(0, 8);
			
			//임시비밀번호를 DB 저장
			memberService.updatePwd(mid, bCrypt.encode(pwd));
			
			//임시비밀번호를 메일로 전송
			String content = pwd;
			//return "redirect:/member/mailSend";
			String res = "0";//mailSend(toMail, content);
			if (res.equals("1")) return "redirect:/msg/memberIdPwdFindoutOk";
			else return "redirect:/msg/memberIdPwdFindoutNo";
		}
	}
	
	//임시 비밀번호 메일로 발송하기
//	//@RequestMapping(value="/mailSend", method=RequestMethod.POST)
//	public String mailSend(String toMail, String content) {
//		try {
//			String title = "임시비밀번호를 보냅니다";
//			
//			//메세지 변환하여 보관함에 저장(messageHelper)
//			MimeMessage message = mailSender.createMimeMessage();
//			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
//			
//			//메일보관함에 회원이 보내온 메세지를 모두 저장
//			messageHelper.setTo(toMail);
//			messageHelper.setSubject(title);
//			messageHelper.setText(content);
//			
//			// 메세지 보관함의 내용을 편집해서 다시 보관함에 담아둔다.
//			content = "<hr/>임시 비밀번호는 : <font color='red'><b>" + content + "</b></font>";
//			content += "<br><hr/>아래의 주소로 다시 로그인하여 비밀번호를 변경해주세요<hr/><br>";
//			content += "<p><img src=\"cid:main.jpg\" width='500px'></p><hr>";
//			content += "<p>방문하기 : <a href='http://49.142.157.251:9090/cjgreen'>javagreenS 스프링수업</a></p>";//선생님pc-테스트금지
//			content += "<hr>";
//			messageHelper.setText(content, true);
//			
//			// 본문에 기재된 그림파일의 경로를 따로 표시시켜준다.
//			FileSystemResource file = new FileSystemResource("D:\\JavaGreen\\springframework\\works\\javagreenS\\src\\main\\webapp\\resources\\images\\main.jpg");
//			messageHelper.addInline("main.jpg", file);
//			
//			// 메일 전송하기
//			mailSender.send(message);
//			
//		} catch (IOException e) {
//			System.out.println(e.getMessage());
//		}
//		return "1";
//	}
}