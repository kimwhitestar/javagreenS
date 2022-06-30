package com.spring.javagreenS;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS.service.StudyService;
import com.spring.javagreenS.vo.MemberVO;

@Controller
@RequestMapping("/study")
public class StudyController {
	
	@Autowired
	private StudyService studyService;
	
	//ckeditor에서 글을 올릴 때 image와 함께 올리려면, 이곳에서 서버파일시스템에 그림파일을 저장할 수 있도록 처리
	@ResponseBody
	@RequestMapping(value="/imageUpload", method=RequestMethod.GET)
	public void imageUploadGet(HttpServletRequest request, HttpServletResponse response,
		MultipartFile upload) throws Exception {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String orgFName = upload.getOriginalFilename();
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddhhmmss");
		orgFName = sdf.format(date) + "_" + orgFName;
		
		//서버파일시스템에 사진 저장(전송하지 않아도, 호일읽는 것만으로 아래폴더에 사진이 저장되고, 사진을 뺀다고 지워지지않는다.
		byte[] bytes = upload.getBytes();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		OutputStream os = new FileOutputStream(new File(uploadPath + orgFName));
		os.write(bytes);
		
		//서버파일시스템에 저장된 파일을 화면에 보여주기위한 작업
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/ckeditor/" + orgFName;

		// Json type으로 출력(전송) { key : value, key : value } 
		out.println("{\"orgFName\":\""+orgFName+"\",\"uploaded\":1, \"url\":\""+fileUrl+"\"}");
		
		out.flush();
		os.close();
	}

	@RequestMapping(value="/fileUpload", method=RequestMethod.GET)
	public String fileUploadGet() {
		return "pds/fileUpload";
	}
	
	@RequestMapping(value="/fileUpload", method=RequestMethod.POST)
	public String fileUploadPost(MultipartFile fName) {
		int res = studyService.fileUpload(fName);
		if (1 == res) {
			return "redirect:/msg/fileUploadOk";
		} else {
			return "redirect:/msg/fileUploadNo";
		}
//		CommonsMultipartResolver cmr;
	}
	
	@RequestMapping(value = "/uuid/uuidForm", method = RequestMethod.GET)
	public String uuidFormGet() {
		return "study/uuid/uuidForm";
	}
	

	
	@RequestMapping(value="/uuidCheck", method=RequestMethod.GET)
	public String uuidCheckGet() {
		return "uuid/uuidCheck";
	}
	
	@ResponseBody //ajax응답용
	@RequestMapping(value="/uuidCheck", method=RequestMethod.POST)
	public String uuidCheckPost() {
		UUID uuid = UUID.randomUUID();
		return uuid.toString();
	}
	
	@RequestMapping(value="/pwdCheck1", method=RequestMethod.GET)
	public String pwdCheck1Get() {
		return "encoding/pwdCheck1";
	}
	
	@RequestMapping(value="/pwdCheck1", method=RequestMethod.POST)
	public String pwdCheck1Post(long pwd, Model model) {
		long key = 0x1234ABCD;//암호화를 위한 키 : 16진수
		long encPwd, decPwd;
		
		//암호화(ExclusiveOR연산자 : ^)
		encPwd = pwd ^ key;// 암호화는 DB저장
		//복호화(ExclusiveOR연산자 : ^)
		decPwd = encPwd ^ key;//복호화는 DB읽어서 바꾸기
		model.addAttribute("pwd", pwd);
		model.addAttribute("encPwd", encPwd);
		model.addAttribute("decPwd", decPwd);
		
		return "encoding/pwdCheck1";
	}
	
	@RequestMapping(value="/ajaxMenu", method=RequestMethod.GET)
	public String ajaxMenuGet() {
		return "ajax/ajaxMenu";
	}
	
	@RequestMapping(value="/ajaxTest1", method=RequestMethod.GET)
	public String ajaxTest1Get() {
		return "ajax/ajaxTest1";
	}
	
	@ResponseBody //ajax에 문자(return String), 문자배열(return String[]) 전송할 때 필요
	@RequestMapping(value="/ajaxTest1", method=RequestMethod.POST)
	public String[] ajaxTest1Post(String unitDo) {
		//"ajax/ajaxTest1"
		return studyService.getUnitKu(unitDo);
	}
	
	@RequestMapping(value="/ajaxTest2", method=RequestMethod.GET)
	public String ajaxTest2Get() {
		return "ajax/ajaxTest2";
	}
	
	@ResponseBody //ajax에 List 전송할 때 필요
	@RequestMapping(value="/ajaxTest2", method=RequestMethod.POST)
	public List<String> ajaxTest2Post(String unitDo) {
		//"ajax/ajaxTest2"
		return studyService.getUnitKuList(unitDo);
	}
	
	@RequestMapping(value="/ajaxTest3", method=RequestMethod.GET)
	public String ajaxTest3Get() {
		return "ajax/ajaxTest3";
	}
	
	@ResponseBody //ajax에 HashMap 전송할 때 필요
	@RequestMapping(value="/ajaxTest3", method=RequestMethod.POST)
	public HashMap<Object, Object> ajaxTest3Post(String unitDo) {
		//"ajax/ajaxTest3"
		return studyService.getUnitKuMap(unitDo);
	}
	
	@RequestMapping(value="/ajaxTest4", method=RequestMethod.GET)
	public String ajaxTest4Get() {
		return "ajax/ajaxTest4";
	}
	
	@ResponseBody //ajax에 VO 전송할 때 필요
	@RequestMapping(value="/ajaxTest4", method=RequestMethod.POST)
	public MemberVO ajaxTest4Post(String oid) {
		//"ajax/ajaxTest4"
		return studyService.getMemberVO(oid);//ajax는 null값을 응답할 수 없는데.. jsp에서 null로 받나? 아니면 null을 공백으로 바꿔서 받나?
	}

	@RequestMapping(value="/ajaxTest5", method=RequestMethod.GET)
	public String ajaxTest5Get() {
		return "ajax/ajaxTest5";
	}
	
	@ResponseBody //ajax에 VOS 전송할 때 필요
	@RequestMapping(value="/ajaxTest5", method=RequestMethod.POST)
	public List<MemberVO> ajaxTest5Post() {
		//"ajax/ajaxTest5"
		return studyService.getMemberVOS();//ajax는 null값을 응답할 수 없는데.. jsp에서 null로 받나? 아니면 null을 공백으로 바꿔서 받나?
	}
}