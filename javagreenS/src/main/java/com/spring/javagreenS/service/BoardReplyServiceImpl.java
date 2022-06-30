package com.spring.javagreenS.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.spring.javagreenS.dao.BoardReplyDAO;
import com.spring.javagreenS.vo.BoardReplyVO;

public class BoardReplyServiceImpl implements BoardReplyService {

	@Autowired
	public BoardReplyDAO boardReplyDao;
	
	@Override
	public String maxLevelOrder(int boardIdx) {
		return boardReplyDao.maxLevelOrder(boardIdx);
	}

	@Override
	public void setBoardReplyInput(BoardReplyVO replyVo) {
		boardReplyDao.setBoardReplyInput(replyVo);
	}

	@Override
	public List<BoardReplyVO> getBoardReply(int idx) {
		return boardReplyDao.getBoardReply(idx);
	}

	@Override
	public void levelOrderPlusUpdate(BoardReplyVO replyVo) {
		boardReplyDao.levelOrderPlusUpdate(replyVo);
	}

	@Override
	public void setBoardReplyInput2(BoardReplyVO replyVo) {
		boardReplyDao.setBoardReplyInput2(replyVo);
	}

	@Override
	public void setBoardReplyDeleteOk(int idx) {
		boardReplyDao.setBoardReplyDeleteOk(idx);
	}
	
}
