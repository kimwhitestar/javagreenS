package com.spring.javagreenS.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS.dao.StudyDAO;
import com.spring.javagreenS.vo.MemberVO;
import com.spring.javagreenS.vo.PersonVO;

@Service
public class StudyServiceImpl implements StudyService {
	
	@Autowired
	private StudyDAO studyDao;

	@Override
	public int fileUpload(MultipartFile fName) {
		int res = 0;
		try {
			UUID uuid = UUID.randomUUID();//화일명 중복방지 랜덤 난수 id
			String orgFName = fName.getOriginalFilename();
			String saveFName = uuid + "_" + orgFName;
			
			writeFile(fName, saveFName);
			res = 1;
		} catch (IOException e) {
			res = -1;
			System.out.println(e.getMessage());
		}
		return res;
	}
	
	private void writeFile(MultipartFile fName, String saveFName) throws IOException {
		byte[] data = fName.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();//자료업로드시킬 request객체 생성
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/images/test/");//절대경로web-app주소
		FileOutputStream fos = new FileOutputStream(uploadPath + saveFName);
		fos.write(data);
		fos.close();
	}
	
	@Override
	public String[] getUnitKu(String unitDo) {
		String[] ssamKu = new String[100];
		if (unitDo.equals("경성")) {
			ssamKu[0] = "서대문구";
			ssamKu[1] = "마포구";
			ssamKu[2] = "강남구";
			ssamKu[3] = "강서구";
			ssamKu[4] = "강동구";
			ssamKu[5] = "강북구";
		} else if (unitDo.equals("경상")) {
			ssamKu[0] = "대구시 가로등예쁜산구";
			ssamKu[1] = "대구시 가세구";
			ssamKu[2] = "부산시 사막구";
			ssamKu[3] = "울산시 사마귀예쁜산구";
		} else if (unitDo.equals("인천")) {
			ssamKu[0] = "백령도 꽃여우구";
			ssamKu[1] = "백인천구";
			ssamKu[2] = "마이구";
		} else if (unitDo.equals("충북")) {
			ssamKu[0] = "왕십리쪽구";
			ssamKu[1] = "니미자동차구";
		} else if (unitDo.equals("전라")) {
			ssamKu[0] = "뿌직찍 미술짤구";
			ssamKu[1] = "뿌직찍 살찐구";
			ssamKu[2] = "뿌직찍 야시구";
		}
		return ssamKu;
	}

	@Override
	public List<String> getUnitKuList(String unitDo) {
		List<String> ssamKu = new ArrayList<>();
		if (unitDo.equals("경성")) {
			ssamKu.add("서대문구");
			ssamKu.add("마포구");
			ssamKu.add("강남구");
			ssamKu.add("강서구");
			ssamKu.add("강동구");
			ssamKu.add("강북구");
		} else if (unitDo.equals("경상")) {
			ssamKu.add("대구시 가로등예쁜산구");
			ssamKu.add("대구시 가세구");
			ssamKu.add("부산시 사막구");
			ssamKu.add("울산시 사마귀예쁜산구");
		} else if (unitDo.equals("인천")) {
			ssamKu.add("백령도 꽃여우구");
			ssamKu.add("백인천구");
			ssamKu.add("마이구");
		} else if (unitDo.equals("충북")) {
			ssamKu.add("왕십리쪽구");
			ssamKu.add("니미자동차구");
		} else if (unitDo.equals("전라")) {
			ssamKu.add("뿌직찍 미술짤구");
			ssamKu.add("뿌직찍 살찐구");
			ssamKu.add("뿌직찍 야시구");
		}
		return ssamKu;
	}

	@Override
	public HashMap<Object, Object> getUnitKuMap(String unitDo) {
		HashMap<Object, Object> ssamKu = new HashMap<>();
		
		if (unitDo.equals("경성")) {
			ssamKu.put(1, "서대문구");
			ssamKu.put(2, "마포구");
			ssamKu.put(3, "강남구");
			ssamKu.put(4, "강서구");
			ssamKu.put(5, "강동구");
			ssamKu.put(6, "강북구");
		} else if (unitDo.equals("경상")) {
			ssamKu.put(1, "대구시 가로등예쁜산구");
			ssamKu.put(2, "대구시 가세구");
			ssamKu.put(3, "부산시 사막구");
			ssamKu.put(4, "울산시 사마귀예쁜산구");
		} else if (unitDo.equals("인천")) {
			ssamKu.put(1, "백령도 꽃여우구");
			ssamKu.put(2, "백인천구");
			ssamKu.put(3, "마이구");
		} else if (unitDo.equals("충북")) {
			ssamKu.put(1, "왕십리쪽구");
			ssamKu.put(2, "니미자동차구");
		} else if (unitDo.equals("전라")) {
			ssamKu.put(1, "뿌직찍 미술짤구");
			ssamKu.put(2, "뿌직찍 살찐구");
			ssamKu.put(3, "뿌직찍 야시구");
		}
		System.out.println("map key size = " + ssamKu.size());
		return ssamKu;
	}

	@Override
	public MemberVO getMemberVO(String mid) {
		return studyDao.getMemberVO(mid);
	}

	@Override
	public List<MemberVO> getMemberVOS() {
		return studyDao.getMemberVOS();
	}
	
	@Transactional
	@Override
	public void insertPerson(PersonVO vo) {
		studyDao.insertPerson(vo);
	}

	@Override
	public List<PersonVO> selectPersonList() {
		return studyDao.selectPersonList();
	}
}