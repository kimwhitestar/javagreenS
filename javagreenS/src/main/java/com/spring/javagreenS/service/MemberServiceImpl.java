package com.spring.javagreenS.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS.common.Support;
import com.spring.javagreenS.dao.MemberDAO;
import com.spring.javagreenS.vo.MemberVO;

public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDAO memberDao;
	
	@Override
	public String searchMemberId(String mid) {
		return memberDao.searchMemberId(mid);
	}

	@Override
	public String searchNickName(String nickName) {
		return memberDao.searchNickName(nickName);
	}
	
	@Override
	public int insertMember(MultipartFile fName, MemberVO vo) {
		int res = 0;
		try {
			String orgFName = fName.getOriginalFilename();
			if (null == orgFName || orgFName.equals("")) { 
				vo.setPhoto("noimage.jpg");
			} else {
				UUID uuid = UUID.randomUUID();//화일명 중복방지 랜덤 난수 id
				String saveFName = uuid + "_" + orgFName;
				new Support().writeFile(fName, saveFName, "member");
				vo.setPhoto(saveFName);
			}
		} catch (IOException e) {
			res = -1;
			System.out.println(e.getMessage());
		}
		memberDao.insertMember(vo);
		res = 1;
		
		return res;
	}

	@Override
	public void updateTodayVisitCntAndPoint(String lastDate, int todayVisitCnt, int point, String mid) {
		//오늘방문횟수, 최종방문횟수, 포인트 증가
		memberDao.updateTodayVisitCntAndPoint(todayVisitCnt, point, mid);
	}

	@Override
	public MemberVO searchMemberLogin(String mid, String bCryptPwd) {
		return memberDao.searchMemberLogin(mid, bCryptPwd);
	}
	
	@Override
	public int searchMemberListTotRecCnt() {
		return memberDao.searchMemberListTotRecCnt();
	}
	
	@Override
	public List<MemberVO> searchMemberList(int startIndexNo, int pageSize) {
		return memberDao.searchMemberList(startIndexNo, pageSize);
	}

	@Override
	public MemberVO searchMember(String mid) {
		return memberDao.searchMember(mid);
	}

	@Override
	public int updateMember(MultipartFile fName, MemberVO vo) {
		int res = 0;
		try {
			String orgFName = fName.getOriginalFilename();
			if (null == orgFName || orgFName.equals("")) { 
//				vo.setPhoto("noimage.jpg");
			} else {
				UUID uuid = UUID.randomUUID();//화일명 중복방지 랜덤 난수 id
				String saveFName = uuid + "_" + orgFName;
				new Support().writeFile(fName, saveFName, "member");
				
				//기존화일 삭제
				//저장된 화일 실제 장소 : ~\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\javagreenS\resources
				if (!vo.getPhoto().equals("noimage.jpg")) { 
					HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();//자료업로드시킬 request객체 생성
					String uploadPath = request.getSession().getServletContext().getRealPath("/resources/member/");//절대경로web-app주소
					File file = new File(uploadPath + vo.getPhoto());
					file.delete();
				}
				//기존화일 삭제 후 upload된 수정파일명 설정
				vo.setPhoto(saveFName);
			}
		} catch (IOException e) {
			res = -1;
			System.out.println(e.getMessage());
		}
		memberDao.updateMember(vo);
		res = 1;
		
		return res;
	}

	@Override
	public MemberVO searchMemberIdPwd(String mid, String toMail) {
		return memberDao.searchMemberIdPwd(mid, toMail);
	}

	@Override
	public void updatePwd(String mid, String pwd) {
		memberDao.updatePwd(mid, pwd);
	}

	@Override
	public void updateUserDel(String mid) {
		memberDao.updateUserDel(mid);
	}

}