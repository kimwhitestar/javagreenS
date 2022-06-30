package com.spring.javagreenS.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.spring.javagreenS.vo.MemberVO;
import com.spring.javagreenS.vo.PersonVO;

public interface StudyDAO {
	public MemberVO getMemberVO(@Param("mid") String mid);

	public List<MemberVO> getMemberVOS();

	public void insertPerson(@Param("vo") PersonVO vo);

	public List<PersonVO> selectPersonList();
}