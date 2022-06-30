package com.spring.javagreenS.vo;

import lombok.Data;

public @Data class BoardReplyVO {
	private int idx;
	private int boardIdx;
	private String mid;
	private String nickName;
	private String content;
	private String wDate;
	private String hostIp;
	private int level; //table에 컬럼 추가
	private int levelOrder; //table에 컬럼 추가
}