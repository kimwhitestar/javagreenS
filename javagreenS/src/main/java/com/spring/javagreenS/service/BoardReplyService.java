package com.spring.javagreenS.service;

import java.util.List;

import com.spring.javagreenS.vo.BoardReplyVO;

public interface BoardReplyService {

	public String maxLevelOrder(int boardIdx);

	public void setBoardReplyInput(BoardReplyVO replyVo);

	public List<BoardReplyVO> getBoardReply(int idx);

	public void levelOrderPlusUpdate(BoardReplyVO replyVo);

	public void setBoardReplyInput2(BoardReplyVO replyVo);

	public void setBoardReplyDeleteOk(int idx);
}