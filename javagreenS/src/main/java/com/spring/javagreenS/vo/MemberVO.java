package com.spring.javagreenS.vo;

import lombok.Data;

public @Data class MemberVO {
	private int idx;
	private String mid;
	private String pwd;
	private String nickName;
	private String name;
	private String gender;
	private String birthday;
	private String tel;
	private String address;
	private String email;
	private String homepage;
	private String job;
	private String hobby;
	private String photo;
	private String content;
	private String userInfo;
	private String userDel;
	private int point;
	private int level;//회원등급코드
	private int visitCnt;
	private String startDate;
	private String lastDate;
	private int todayCnt;
	private int overDaysUserDel; //회원삭제신청 경과일(30일 경과시 회원탈퇴처리)
}