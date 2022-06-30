package com.spring.javagreenS.vo;

import lombok.Data;

public @Data class BoardVO {
	private int idx;
	private String nickName;
	private String title;
	private String email;
	private String homepage;
	private String content;
	private String orgContent;
	private String wDate;
	private String mid;
	private String hostIp;
	private int readNum;//조회수
	private int recommendNum;//좋아요
	private int noRecommendNum;//싫어요
	private int replyNum;//댓글수
	//날짜형식필드를 '문자'와 '숫자'로 나눔
	private String diffTime;
}