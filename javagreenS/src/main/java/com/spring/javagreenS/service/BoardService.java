package com.spring.javagreenS.service;

import java.util.List;

import com.spring.javagreenS.vo.BoardVO;

public interface BoardService {

	public List<BoardVO> searchBoardList(int startIndexNo, int pageSize);

	public List<BoardVO> searchBoardSearchList(int startIndexNo, int pageSize, String searchCondition, String searchingKeyWord);
	
	public void insertBoard(BoardVO vo);

	public void updateReadNum(int idx);

	public BoardVO searchBoard(int idx);

	public List<BoardVO> searchPrevNextBoard(int idx);

	public void deleteBoard(int idx);

	public void imgCheck(String content);

	public void imgUpdate(String content);
	
	public void imgDelete(String content);

	public void updateBoard(BoardVO vo);
}