package com.spring.javagreenS.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conn.MysqlConn;
import member.database.MemberVO;

public class AdminMemberDAO {
	private final MysqlConn instance = MysqlConn.getInstance();
	private final Connection conn = instance.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private MemberVO vo = null;
	private String sql = new String("");

	//페이징 총 레코드건수 - 전체회원목록(활동중 회원)
	public int memberListTotRecCnt(char kindYmd, int term) {
		int totRecCnt = 0;
		try {
			int prepareIdx = 0;
			String addPrepareSQL1 = makeIntervalSQL(kindYmd, term, "startDate");
			sql = "select count(*) as totRecCnt from member where userDel = 'NO' ";
			if (0 < addPrepareSQL1.length()) sql = sql + "and " + addPrepareSQL1;
			pstmt = conn.prepareStatement(sql);
			if (0 < addPrepareSQL1.length()) pstmt.setInt(++prepareIdx, term);
			rs = pstmt.executeQuery();
			rs.next(); //ResultSet레코드움직이기(count함수는 무조건 0값조차 가져옴)
			totRecCnt = rs.getInt("totRecCnt");
		} catch (SQLException e) {
			e.getMessage();
		} finally {
			instance.pstmtClose();
			instance.rsClose();
		}
		return totRecCnt;
	}
	//페이징 총 레코드건수 - 신규가입회원목록(가입일 1개월차)
	public int recentlyEntryMemberListTotRecCnt(char kindYmd, int term) {
		int totRecCnt = 0;
		try {
			int prepareIdx = 0;
			String addPrepareSQL1 = makeIntervalSQL(kindYmd, term, "startDate");//기간별 검색키
			sql = "select count(*) as totRecCnt from member where " + makeIntervalSQL('M', 1, "startDate");//가입일 1개월차
			if (0 < addPrepareSQL1.length()) sql = sql + "and " + addPrepareSQL1;//기간별 검색키
			pstmt = conn.prepareStatement(sql);
			if (0 < addPrepareSQL1.length()) pstmt.setInt(++prepareIdx, term);
			rs = pstmt.executeQuery();
			rs.next(); //ResultSet레코드움직이기(count함수는 무조건 0값조차 가져옴)
			totRecCnt = rs.getInt("totRecCnt");
		} catch (SQLException e) {
			e.getMessage();
		} finally {
			instance.pstmtClose();
			instance.rsClose();
		}
		return totRecCnt;
	}
	//페이징 총 레코드건수 - 탈퇴회원목록(탈퇴신청 1개월차)
	public int pracLeaveMemberListTotRecCnt(char kindYmd, int term) {
		int totRecCnt = 0;
		try {
			String addPrepareSQL1 = makeIntervalSQL(kindYmd, term, "startDate");//기간별 검색키
			sql = "select count(*) as totRecCnt from member "
					+ "where userDel = 'OK' "//탈퇴회원(임시탈퇴자, 로그인삭)
					+ "and timestampdiff(day, lastDate, now()) >= 30 ";//임시탈퇴유지기간 30일
			if (0 < addPrepareSQL1.length()) sql = sql + "and " + addPrepareSQL1;//기간별 검색키
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next(); //ResultSet레코드움직이기(count함수는 무조건 0값조차 가져옴)
			totRecCnt = rs.getInt("totRecCnt");
		} catch (SQLException e) {
			e.getMessage();
		} finally {
			instance.pstmtClose();
			instance.rsClose();
		}
		return totRecCnt;
	}
	//기간별 조회 SQL 조건문 추가 - Interval ex) interval 5 day, interval 1 Month
	private String makeIntervalSQL(char kindYmd, int term, String columnName) {
		String sqlInterval = null;
		if ((0 != kindYmd 
			&& ('Y' == kindYmd || 'M' == kindYmd || 'D' == kindYmd)) 
			&& 0 < term) {
			String sqlIntervalDate = new String("interval ? ");
			switch(kindYmd) {
				case 'Y' : sqlIntervalDate += "year"; break;
				case 'M' : sqlIntervalDate += "month"; break;
				case 'W' : sqlIntervalDate += "week"; break;
				case 'D' : sqlIntervalDate += "day"; break;
				default : break;
			}
			String sqlTerm = new String("date_sub(now(), " + sqlIntervalDate + ")");
			sqlInterval = new String(sqlTerm + " <= " + columnName + " and " + columnName +" <= now() ");
		} else {
			sqlInterval = new String("");
		}
		return sqlInterval;
	}
	//전체회원목록 - 관리자는 userInfo의 '공개'여부 관계없이 모두 출력
	public List<MemberVO> searchMemberList(char kindYmd, int term, int startIndexNo, int pageSize) {
		List<MemberVO> vos = new ArrayList<>();
		try {
			int prepareIdx = 0;
			String addPrepareSQL1 = makeIntervalSQL(kindYmd, term, "startDate");
			sql = "select *, timestampdiff(day, lastDate, now()) as overDaysUserDel from member ";
			if(0 < addPrepareSQL1.length()) sql = sql + addPrepareSQL1;
			sql += "order by idx desc limit ?, ? ";
			pstmt = conn.prepareStatement(sql);
			if(0 < addPrepareSQL1.length()) pstmt.setInt(++prepareIdx, term);
			pstmt.setInt(++prepareIdx, startIndexNo);
			pstmt.setInt(++prepareIdx, pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo = new MemberVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setPwd(rs.getString("pwd"));//암호화 비밀번호ㅜㅜ
				vo.setNickName(rs.getString("nickName"));
				vo.setName(rs.getString("name"));
				vo.setGender(rs.getString("gender"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setTel(rs.getString("tel"));
				vo.setAddress(rs.getString("address"));
				vo.setEmail(rs.getString("email"));
				vo.setHomepage(rs.getString("homepage"));
				vo.setJob(rs.getString("job"));
				vo.setHobby(rs.getString("hobby"));
				vo.setPhoto(rs.getString("photo"));
				vo.setContent(rs.getString("content"));
				vo.setUserInfo(rs.getString("userInfo"));
				vo.setUserDel(rs.getString("userDel"));
				vo.setPoint(rs.getInt("point"));
				vo.setLevel(rs.getInt("level"));
				vo.setVisitCnt(rs.getInt("visitCnt"));
				vo.setStartDate(rs.getString("startDate"));
				vo.setLastDate(rs.getString("lastDate"));
				vo.setTodayCnt(rs.getInt("todayCnt"));
				vo.setOverDaysUserDel(rs.getInt("overDaysUserDel"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
			instance.rsClose();
		}
		return vos;
	}
	//신규회원가입한 목록 - 가입일 1개월차
	public List<MemberVO> searchRecentlyEntryMemberList(char kindYmd, int term, int startIndexNo, int pageSize) {
		List<MemberVO> vos = new ArrayList<>();
		try {
			int prepareIdx = 0;
			String addPrepareSQL1 = makeIntervalSQL('M', 1, "startDate");//가입일 1개월차
			String addPrepareSQL2 = makeIntervalSQL(kindYmd, term, "startDate");//검색조건키(weekly등)
			sql = "select *, timestampdiff(day, lastDate, now()) as overDaysUserDel from member where " + addPrepareSQL1; //가입 1개월차 기본조건
			if(0 < addPrepareSQL2.length()) sql = sql + "and " + addPrepareSQL2;
			sql += "order by idx desc limit ?, ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(++prepareIdx, 1);
			if(0 < addPrepareSQL2.length()) pstmt.setInt(++prepareIdx, term);
			pstmt.setInt(++prepareIdx, startIndexNo);
			pstmt.setInt(++prepareIdx, pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo = new MemberVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setPwd(rs.getString("pwd"));//암호화 비밀번호ㅜㅜ
				vo.setNickName(rs.getString("nickName"));
				vo.setName(rs.getString("name"));
				vo.setGender(rs.getString("gender"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setTel(rs.getString("tel"));
				vo.setAddress(rs.getString("address"));
				vo.setEmail(rs.getString("email"));
				vo.setHomepage(rs.getString("homepage"));
				vo.setJob(rs.getString("job"));
				vo.setHobby(rs.getString("hobby"));
				vo.setPhoto(rs.getString("photo"));
				vo.setContent(rs.getString("content"));
				vo.setUserInfo(rs.getString("userInfo"));
				vo.setUserDel(rs.getString("userDel"));
				vo.setPoint(rs.getInt("point"));
				vo.setLevel(rs.getInt("level"));
				vo.setVisitCnt(rs.getInt("visitCnt"));
				vo.setStartDate(rs.getString("startDate"));
				vo.setLastDate(rs.getString("lastDate"));
				vo.setTodayCnt(rs.getInt("todayCnt"));
				vo.setOverDaysUserDel(rs.getInt("overDaysUserDel"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
			instance.rsClose();
		}
		return vos;
	}
	//최근접속회원목록
	public List<MemberVO> searchRecentlyLoginMemberList(char kindYmd, int term, int startIndexNo, int pageSize) {
		List<MemberVO> vos = new ArrayList<>();
		try {
			int prepareIdx = 0;
			String addPrepareSQL1 = makeIntervalSQL(kindYmd, term, "lastDate");
			sql = "select *, timestampdiff(day, lastDate, now()) as overDaysUserDel from member where userDel = 'NO' ";
			if(0 < addPrepareSQL1.length()) sql = sql + "and " + addPrepareSQL1;
			sql = sql + "order by lastDate desc limit ?, ? ";
			pstmt = conn.prepareStatement(sql);
			if(0 < addPrepareSQL1.length()) pstmt.setInt(++prepareIdx, term);
			pstmt.setInt(++prepareIdx, startIndexNo);
			pstmt.setInt(++prepareIdx, pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo = new MemberVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setPwd(rs.getString("pwd"));//암호화 비밀번호ㅜㅜ
				vo.setNickName(rs.getString("nickName"));
				vo.setName(rs.getString("name"));
				vo.setGender(rs.getString("gender"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setTel(rs.getString("tel"));
				vo.setAddress(rs.getString("address"));
				vo.setEmail(rs.getString("email"));
				vo.setHomepage(rs.getString("homepage"));
				vo.setJob(rs.getString("job"));
				vo.setHobby(rs.getString("hobby"));
				vo.setPhoto(rs.getString("photo"));
				vo.setContent(rs.getString("content"));
				vo.setUserInfo(rs.getString("userInfo"));
				vo.setUserDel(rs.getString("userDel"));
				vo.setPoint(rs.getInt("point"));
				vo.setLevel(rs.getInt("level"));
				vo.setVisitCnt(rs.getInt("visitCnt"));
				vo.setStartDate(rs.getString("startDate"));
				vo.setLastDate(rs.getString("lastDate"));
				vo.setTodayCnt(rs.getInt("todayCnt"));
				vo.setOverDaysUserDel(rs.getInt("overDaysUserDel"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
			instance.rsClose();
		}
		return vos;
	}
	//탈퇴회원목록 - 회원삭제대상자(임시탈퇴유지기간 30일을 경과한 회원)
	public List<MemberVO> searchPracLeaveMemberList(char kindYmd, int term, int startIndexNo, int pageSize) {
		List<MemberVO> vos = new ArrayList<>();
		try {
			int prepareIdx = 0;
			String addPrepareSQL1 = makeIntervalSQL(kindYmd, term, "startDate");
			sql = "select *, timestampdiff(day, lastDate, now()) as overDaysUserDel from member "
					+ "where userDel = 'OK' "//탈퇴회원(임시탈퇴자, 로그인삭)
					+ "and timestampdiff(day, lastDate, now()) >= 30 ";//임시탈퇴유지기간 30일
			if(0 < addPrepareSQL1.length()) sql = sql + addPrepareSQL1;
			sql += "order by idx desc limit ?, ? ";
			pstmt = conn.prepareStatement(sql);
			if(0 < addPrepareSQL1.length()) pstmt.setInt(++prepareIdx, term);
			pstmt.setInt(++prepareIdx, startIndexNo);
			pstmt.setInt(++prepareIdx, pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo = new MemberVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setPwd(rs.getString("pwd"));//암호화 비밀번호ㅜㅜ
				vo.setNickName(rs.getString("nickName"));
				vo.setName(rs.getString("name"));
				vo.setGender(rs.getString("gender"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setTel(rs.getString("tel"));
				vo.setAddress(rs.getString("address"));
				vo.setEmail(rs.getString("email"));
				vo.setHomepage(rs.getString("homepage"));
				vo.setJob(rs.getString("job"));
				vo.setHobby(rs.getString("hobby"));
				vo.setPhoto(rs.getString("photo"));
				vo.setContent(rs.getString("content"));
				vo.setUserInfo(rs.getString("userInfo"));
				vo.setUserDel(rs.getString("userDel"));
				vo.setPoint(rs.getInt("point"));
				vo.setLevel(rs.getInt("level"));
				vo.setVisitCnt(rs.getInt("visitCnt"));
				vo.setStartDate(rs.getString("startDate"));
				vo.setLastDate(rs.getString("lastDate"));
				vo.setTodayCnt(rs.getInt("todayCnt"));
				vo.setOverDaysUserDel(rs.getInt("overDaysUserDel"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
			instance.rsClose();
		}
		return vos;
	}
	//회원탈퇴신청(userDel) 후 30일 경과시, 회원삭제 처리
	public int delete(int idx, String mid) {
		int res = 0;
		try {
			sql = "delete from member where idx = ? and mid = ? and 30 <= timestampdiff(day, lastDate, now()) and userDel = 'OK'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
		}
		return res;	
	}
	//관리자 - 전체회원 목록(공개회원)->선택된 회원의 등급 수정
	public int updateMemberLevel(String level, String idx, String mid) {
		int res = 0;
		try {
			sql = "update member set level = ? where idx = ? and mid = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(level));
			pstmt.setString(2, idx);
			pstmt.setString(3, mid);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
		}
		return res;	
	}
}