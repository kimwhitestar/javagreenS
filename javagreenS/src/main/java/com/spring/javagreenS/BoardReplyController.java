package com.spring.javagreenS;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS.service.BoardReplyService;
import com.spring.javagreenS.vo.BoardReplyVO;

@RequestMapping("/board")
@Controller
public class BoardReplyController {
	
	@Autowired
	public BoardReplyService boardReplyService;
	
	@ResponseBody
	@RequestMapping(value = "/boardReplyInput", method = RequestMethod.POST)
	public String boardReplyInputPost(BoardReplyVO replyVo) {
		//int level = 0;
		int levelOrder = 0;
		
		String strLevelOrder = boardReplyService.maxLevelOrder(replyVo.getBoardIdx());
		if(strLevelOrder != null) levelOrder =  Integer.parseInt(strLevelOrder) + 1;
		replyVo.setLevelOrder(levelOrder);
		
		boardReplyService.setBoardReplyInput(replyVo);
		
		return "1";
	}
	
	// 대댓글의 경우 나중에 쓴 댓글이 먼저 나오게 처리한것
	@ResponseBody
	@RequestMapping(value = "/boardReplyInput2", method = RequestMethod.POST)
	public String boardReplyInput2Post(BoardReplyVO replyVo) {
		boardReplyService.levelOrderPlusUpdate(replyVo);				// 부모댓글의 levelOrder값보다 큰 모든 댓글의 levelOrder값을 +1 시켜준다(update)
		replyVo.setLevel(replyVo.getLevel()+1);  					// 자신의 level은 부모 level 보다 +1 시켜준다.
		replyVo.setLevelOrder(replyVo.getLevelOrder()+1);	// 자신의 levelOrder은 부모의 levelOrder보다 +1 시켜준다.
		
		boardReplyService.setBoardReplyInput2(replyVo);
		
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/boardReplyDelete", method = RequestMethod.POST)
	public String boardReplyDeletePost(int idx) {
		boardReplyService.setBoardReplyDeleteOk(idx);
		return "";
	}
}