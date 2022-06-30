package com.spring.javagreenS.service;

import java.util.HashMap;
import java.util.List;
import org.springframework.web.multipart.MultipartFile;
import com.spring.javagreenS.vo.MemberVO;
import com.spring.javagreenS.vo.PersonVO;

public interface StudyService {

	public String[] getUnitKu(String unitDo);

	public List<String> getUnitKuList(String unitDo);

	public HashMap<Object, Object> getUnitKuMap(String unitDo);

	public MemberVO getMemberVO(String mid);

	public List<MemberVO> getMemberVOS();

	public int fileUpload(MultipartFile fName);

	public void insertPerson(PersonVO vo);

	public List<PersonVO> selectPersonList();
}