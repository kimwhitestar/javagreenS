package com.spring.javagreenS;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javagreenS.service.StudyService;
import com.spring.javagreenS.vo.PersonVO;

@RequestMapping("/study")
@Controller 
public class TransactionController {

	@Autowired
	public StudyService studyService;
	
	//트랜잭션 정보 저장
	@RequestMapping(value="/transaction/personInput", method=RequestMethod.GET)
	public String personInputGet() {
		return "transaction/personInput";
	}
	
	//트랜잭션 정보 저장
	@RequestMapping(value="/transaction/personInput", method=RequestMethod.POST)
	public String personInputPost(PersonVO vo) {
		studyService.insertPerson(vo);
		return "redirect:/msg/personInputOk";
	}
	
	//트랜잭션 정보 저장
	@RequestMapping(value="/transaction/personList", method=RequestMethod.GET)
	public String personListGet(Model model) {
		List<PersonVO> vos = studyService.selectPersonList();
		model.addAttribute("vos", vos);
		return "transaction/personList";
	}
	
	// error처리 
	@RequestMapping(value="/error/error500", method=RequestMethod.POST)
	public String error500Post() {
		return "error/error500";
	} 
	
}