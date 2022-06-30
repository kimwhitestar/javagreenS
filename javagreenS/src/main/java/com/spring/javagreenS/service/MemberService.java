package com.spring.javagreenS.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS.vo.MemberVO;

public interface MemberService {

	public String searchMemberId(String mid);

	public String searchNickName(String nickName);

	public int insertMember(MultipartFile fName, MemberVO vo);

	public void updateTodayVisitCntAndPoint(String lastDate, int todayVisitCnt, int point, String mid);

	public int searchMemberListTotRecCnt();

	public List<MemberVO> searchMemberList(int startIndexNo, int pageSize);

	public MemberVO searchMember(String mid);

	public int updateMember(MultipartFile fName, MemberVO vo);

	public void updateUserDel(String mid);

	public void updatePwd(String mid, String pwd);

	public MemberVO searchMemberIdPwd(String mid, String toMail);

	public MemberVO searchMemberLogin(String mid, String bCryptPwd);
}