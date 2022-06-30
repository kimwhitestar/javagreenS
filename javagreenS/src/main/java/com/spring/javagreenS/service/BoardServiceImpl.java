package com.spring.javagreenS.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javagreenS.dao.BoardDAO;
import com.spring.javagreenS.vo.BoardVO;

public class BoardServiceImpl implements BoardService {
	@Autowired
	public BoardDAO boardDao;

	@Override
	public List<BoardVO> searchBoardList(int startIndexNo, int pageSize) {
		return boardDao.searchBoardList(startIndexNo, pageSize);
	}
	@Override
	public List<BoardVO> searchBoardSearchList(int startIndexNo, int pageSize, String searchCondition, String searchingKeyWord) {
		return boardDao.searchBoardSearchList(startIndexNo, pageSize, searchCondition, searchingKeyWord);
	}

	@Override
	public void insertBoard(BoardVO vo) {
		boardDao.insertBoard(vo);
	}
	
	@Override
	public void imgUpdate(String content) {
		// src"/ 찾은 위치부터
		//     0123456789012345678901234567890123456789012345678901234567890123456789
		//<img src="/javagreenS/data/ckeditor/220622152242_map.jpg" style="height:838px"/>
		
		// content안에 그림파일(img src="/)가 있을 때만 처리
		if (-1 == content.indexOf("src=\"/")) return;
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();//자료업로드시킬 request객체 생성
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/board/");//절대경로web-app주소

		int position = 37;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			String orgFilePath = uploadPath + imgFile;
			String copyFilePath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/" + imgFile);
			
			fileCopyCheck(orgFilePath, copyFilePath);//board폴더 파일 삭제
			if ( -1 == nextImg.indexOf("src=\"/") ) {
				sw = false;
			} else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}
	
	@Override
	public void imgDelete(String content) {
		// src"/ 찾은 위치부터
		//     0123456789012345678901234567890123456789012345678901234567890123456789
		//<img src="/javagreenS/data/ckeditor/220622152242_map.jpg" style="height:838px"/>
		
		// content안에 그림파일(img src="/)가 있을 때만 처리
		if (-1 == content.indexOf("src=\"/")) return;
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();//자료업로드시킬 request객체 생성
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/board/");//절대경로web-app주소

		int position = 37;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			String orgFilePath = uploadPath + imgFile;
			
			fileDelete(orgFilePath);//board폴더 파일 삭제
			if ( -1 == nextImg.indexOf("src=\"/") ) {
				sw = false;
			} else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}

	//원본 사진 삭제(resources/data/ckeditor/board/사진)
	private void fileDelete(String orgFilePath) {
		File file = new File(orgFilePath);
		if (file.exists()) file.delete();
	}
	
	//게시글 등록할 때 그림파일은 파일서버에 추가
	@Override
	public void imgCheck(String content) {
		// src"/ 찾은 위치부터
		//     0123456789012345678901234567890123456789012345678901234567890123456789
		//<img src="/javagreenS/data/ckeditor/220622152242_map.jpg" style="height:838px"/>

		// content안에 그림파일(img src="/)가 있을 때만 처리
		if (-1 == content.indexOf("src=\"/")) return;
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();//자료업로드시킬 request객체 생성
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");//절대경로web-app주소

		int position = 31;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			String orgFilePath = uploadPath + imgFile;
			String copyFilePath = uploadPath + "board/" + imgFile;
			
			fileCopyCheck(orgFilePath, copyFilePath);//board폴더에 파일 복사
			if ( -1 == nextImg.indexOf("src=\"/") ) {
				sw = false;
			} else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}

	//실제서버폴더(ckeditor/)에 저장되어 있는 파일을 board폴더로 복사
	private void fileCopyCheck(String orgFilePath, String copyFilePath) {
		File orgFile = new File(orgFilePath);
		File copyFile = new File(copyFilePath);
		
		try {
			FileInputStream fis = new FileInputStream(orgFile);
			FileOutputStream fos = new FileOutputStream(copyFile);
			
			byte[] buffer = new byte[2048];
			int count = 0;
			while( -1 != (count = fis.read(buffer)) ) {
				fos.write(buffer, 0, count);
			}
			
			fos.flush();
			fos.close();
			fis.close();
		} catch(FileNotFoundException e) {
			System.out.println(e.getMessage());
		} catch(IOException e) {
			System.out.println(e.getMessage());
		}
	}

	@Override
	public void updateReadNum(int idx) {
		boardDao.updateReadNum(idx);
	}

	@Override
	public BoardVO searchBoard(int idx) {
		return boardDao.searchBoard(idx);
	}

	@Override
	public List<BoardVO> searchPrevNextBoard(int idx) {
		return boardDao.searchPrevNextBoard(idx);
	}
	@Override
	public void deleteBoard(int idx) {
		boardDao.deleteBoard(idx);
	}
	@Override
	public void updateBoard(BoardVO vo) {
		boardDao.updateBoard(vo);
	}
}