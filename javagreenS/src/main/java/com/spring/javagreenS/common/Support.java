package com.spring.javagreenS.common;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

public class Support {
	public int fileUpload(MultipartFile fName) {
		int res = 0;
		try {
			UUID uuid = UUID.randomUUID();//화일명 중복방지 랜덤 난수 id
			String orgFName = fName.getOriginalFilename();
			String saveFName = uuid + "_" + orgFName;
			
			//writeFile(fName, saveFName, "pds");
			writeFile(fName, saveFName, "test");
			res = 1;
		} catch (IOException e) {
			res = -1;
			System.out.println(e.getMessage());
		}
		return res;
	}
	
	public void writeFile(MultipartFile fName, String saveFName, String flag) throws IOException {
		byte[] data = fName.getBytes();
		String uploadPath = "";
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();//자료업로드시킬 request객체 생성
		if (flag.equals("member"))
			uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/member/");//절대경로web-app주소
		else if (flag.equals("pds"))
			uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/pds/");//절대경로web-app주소
		else 
			uploadPath = request.getSession().getServletContext().getRealPath("/resources/images/test/");//절대경로web-app주소
		FileOutputStream fos = new FileOutputStream(uploadPath + saveFName);
		fos.write(data);
		fos.close();
	}
	
	public void writeFile(MultipartFile fName, String saveFName) throws IOException {
		byte[] data = fName.getBytes();
		String uploadPath = "";
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();//자료업로드시킬 request객체 생성
		uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/pds/");//절대경로web-app주소
		FileOutputStream fos = new FileOutputStream(uploadPath + saveFName);
		fos.write(data);
		fos.close();
	}
}