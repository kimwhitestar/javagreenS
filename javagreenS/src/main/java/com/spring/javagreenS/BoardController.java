package com.spring.javagreenS;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javagreenS.common.Paging;
import com.spring.javagreenS.service.BoardService;
import com.spring.javagreenS.service.MemberService;
import com.spring.javagreenS.vo.BoardVO;
import com.spring.javagreenS.vo.MemberVO;
import com.spring.javagreenS.vo.PagingVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	public BoardService boardService;
	
	@Autowired
	public MemberService memberService;
	
	@Autowired
	public Paging paging;
	
	@RequestMapping(value="/boardList", method=RequestMethod.POST)
	public String boardListPost(
		@RequestParam(name="pageNo", defaultValue="1", required=false) int pageNo,
		@RequestParam(name="pageSize", defaultValue="3", required=false) int pageSize,
		@RequestParam(name="searchCondition", defaultValue="", required=false) String searchCondition,
		@RequestParam(name="searchString", defaultValue="", required=false) String searchingKeyWord,
		Model model) {
		
		int blockSize = 3;
		PagingVO pagingVo = null;
		List<BoardVO> vos = null;
		
		if (searchCondition.equals("") || searchingKeyWord.equals("")) {
			pagingVo = paging.totRecCnt(blockSize, pageNo, pageSize, "board", null, null);
			vos = boardService.searchBoardList(pagingVo.getStartIndexNo(), pagingVo.getPageSize());
		} else {
			pagingVo = paging.totRecCnt(blockSize, pageNo, pageSize, "board", searchCondition, searchingKeyWord);
			vos = boardService.searchBoardSearchList(pagingVo.getStartIndexNo(), pagingVo.getPageSize(), searchCondition, searchingKeyWord);
		}
		
		model.addAttribute("vos", vos);
		model.addAttribute("pagingVo", pagingVo);
		model.addAttribute("searchCondition", searchCondition);
		model.addAttribute("searchString", searchingKeyWord);
		model.addAttribute("searchCount", pagingVo.getTotRecCnt());
		
		return "board/boardList";
	}
	
	@RequestMapping(value="/boardDetail", method=RequestMethod.POST)
	public String boardDetailPost(Model model, HttpSession session,
			@RequestParam(name="idx", defaultValue="0", required=false) int idx,
			@RequestParam(name="pageNo", defaultValue="1", required=false) int pageNo,
			@RequestParam(name="pageSize", defaultValue="3", required=false) int pageSize,
			@RequestParam(name="searchCondition", defaultValue="", required=false) String searchCondition,
			@RequestParam(name="searchString", defaultValue="", required=false) String searchingKeyWord) {
		
		//????????? ?????? (????????????)
		ArrayList<String> contentIdx = (ArrayList) session.getAttribute("sContentIdx");
		if (null == contentIdx) contentIdx = new ArrayList<>();
		
		String imsiContentIdx = "board" + idx;
		if (!imsiContentIdx.contains(imsiContentIdx)) {
			boardService.updateReadNum(idx);
			contentIdx.add(imsiContentIdx);
		}
		session.setAttribute("sContentIdx", contentIdx);
		
		//????????? ????????????
		BoardVO vo = boardService.searchBoard(idx);
		
		//?????????/????????? ????????????
		List<BoardVO> prevNextVos = boardService.searchPrevNextBoard(idx);

		//?????????/????????? VO
		BoardVO prevVo = null, nextVo = null, imsiVO = null;
		if (null != prevNextVos) {
			for (int i=0; i<prevNextVos.size(); i++) {
				imsiVO = prevNextVos.get(i);
				if (imsiVO.getIdx() > idx) {
					nextVo = imsiVO;
				} else if (imsiVO.getIdx() < idx) {
					prevVo = imsiVO;
				}
			}
		}
		
		model.addAttribute("vo", vo);
		model.addAttribute("prevVo", prevVo);
		model.addAttribute("nextVo", nextVo);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("searchCondition", searchCondition);
		model.addAttribute("searchString", searchingKeyWord);
		return "board/boardDetail";
	}
	
	@RequestMapping(value="/boardUpdate", method=RequestMethod.POST)
	public String boardUpdatePost(Model model,
		@RequestParam(name="idx", defaultValue="0", required=false) int idx,
		@RequestParam(name="pageNo", defaultValue="3", required=false) int pageNo,
		@RequestParam(name="pageSize", defaultValue="3", required=false) int pageSize,
		@RequestParam(name="searchCondition", defaultValue="", required=false) String searchCondition,
		@RequestParam(name="searchString", defaultValue="", required=false) String searchingKeyWord) {
		
		//???????????? ????????? ????????????, ?????? ???????????? ?????? ??????
		BoardVO vo = boardService.searchBoard(idx);
		if (-1 == vo.getContent().indexOf("src=\"/")) {
			boardService.imgUpdate(vo.getContent());
		}
		
		model.addAttribute("vo", vo);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("searchCondition", searchCondition);
		model.addAttribute("searchString", searchingKeyWord);
		return "board/boardUpdate";
	}
	
	@RequestMapping(value="/boardUpdateOk", method=RequestMethod.POST)
	public String boardUpdateOkPost(BoardVO vo, Model model,
		@RequestParam(name="pageNo", defaultValue="3", required=false) int pageNo,
		@RequestParam(name="pageSize", defaultValue="3", required=false) int pageSize,
		@RequestParam(name="searchCondition", defaultValue="", required=false) String searchCondition,
		@RequestParam(name="searchString", defaultValue="", required=false) String searchingKeyWord) {

		System.out.println("boardVO.getContent() : " + vo.getContent());
		
		BoardVO orgVo = boardService.searchBoard(vo.getIdx());
		System.out.println("orgVo.getContent() : " + orgVo.getContent());

		if (!orgVo.getContent().equals(vo.getContent())) {

			//????????? ?????????, ?????? ???????????? ?????? ??????
			if (-1 == vo.getContent().indexOf("src=\"/")) {
				boardService.imgDelete(orgVo.getContent());
			}
			
			//????????????????????? /data/ckeditor/ ??? ??????
			vo.setContent(vo.getContent().replace("/data/ckeditor/board/", "/data/ckeditor/"));

			//????????? ????????? /data/ckeditor/board/????????? ??????
			boardService.imgCheck(vo.getContent());
			
			//????????????????????? /data/ckeditor/board/ ??? ??????
			orgVo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/board/"));

			//vo??? DB??? ??????
			boardService.updateBoard(orgVo);
		}
		
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("searchCondition", searchCondition);
		model.addAttribute("searchString", searchingKeyWord);
		return "redirect:/msg/boardUpdateOk";
	}
	
	@RequestMapping(value="/boardDelete", method=RequestMethod.POST)
	public String boardDeletePost(Model model,
		@RequestParam(name="idx", defaultValue="0", required=false) int idx,
		@RequestParam(name="pageSize", defaultValue="3", required=false) int pageSize,
		@RequestParam(name="searchCondition", defaultValue="", required=false) String searchCondition,
		@RequestParam(name="searchString", defaultValue="", required=false) String searchingKeyWord) {
		
		//???????????? ????????? ????????????, ?????? ???????????? ?????? ??????
		BoardVO vo = boardService.searchBoard(idx);
		if (-1 == vo.getContent().indexOf("src=\"/")) {
			boardService.imgDelete(vo.getContent());
		}
		
		//????????? DB ??????
		boardService.deleteBoard(idx);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("searchCondition", searchCondition);
		model.addAttribute("searchString", searchingKeyWord);
		return "redirect:/msg/boardDeleteOk";
	}
	
	@RequestMapping(value="/boardInput", method=RequestMethod.GET)
	public String boardInputGet(Model model, HttpSession session,
			@RequestParam(name="pageSize", defaultValue="3", required=false) int pageSize,
			@RequestParam(name="searchCondition", defaultValue="", required=false) String searchCondition,
			@RequestParam(name="searchString", defaultValue="", required=false) String searchingKeyWord) {
		String sMid = (String) session.getAttribute("sMid");
		MemberVO memberVo = memberService.searchMember(sMid);
		model.addAttribute("memberVo", memberVo);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("searchCondition", searchCondition);
		model.addAttribute("searchString", searchingKeyWord);
		return "board/inputBoard";
	}
	
	@RequestMapping(value="/boardInput", method=RequestMethod.POST)
	public String boardInputPost(BoardVO vo, Model model, 
			@RequestParam(name="pageSize", defaultValue="3", required=false) int pageSize,
			@RequestParam(name="searchCondition", defaultValue="", required=false) String searchCondition,
			@RequestParam(name="searchString", defaultValue="", required=false) String searchingKeyWord) {
		System.out.println("vo : " + vo);
		
		//?????? content??? ???????????? ???????????? ?????????, ????????? ??????????????? /resources/data/ckeditor/board/ ????????? ??????
		boardService.imgCheck(vo.getContent());
		
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/board/"));
		boardService.insertBoard(vo);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("searchCondition", searchCondition);
		model.addAttribute("searchString", searchingKeyWord);
		return "redirect:/msg/boardInputOk";
	}
}