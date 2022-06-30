package com.spring.javagreenS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS.vo.MemberVO;

public interface MemberDAO {
	
	public String searchMemberId(@Param("mid") String mid);

	public String searchNickName(@Param("nickName") String nickName);

	public void insertMember(@Param("vo") MemberVO vo);

	public void updateVisitCnt(@Param("mid") String mid);

	public void updateTodayVisitCntAndPoint(@Param("todayVisitCnt") int todayVisitCnt, @Param("point") int point, @Param("mid") String mid);

	public MemberVO searchMemberLogin(@Param("mid") String mid, @Param("bCryptPwd") String bCryptPwd);

	public int searchMemberListTotRecCnt();
	
	public List<MemberVO> searchMemberList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public MemberVO searchMember(@Param("mid") String mid);

	public void updateMember(@Param("vo") MemberVO vo);

	public MemberVO searchMemberIdPwd(@Param("mid") String mid, @Param("toMail") String toMail);

	public void updatePwd(@Param("mid") String mid, @Param("pwd") String pwd);

	public void updateUserDel(@Param("mid") String mid);


	
//	//전체회원목록 페이징(총 레코드건수) - 운영자회원(level=4) : userDel='NO'(활동중), userInfo='공개' 회원조회
//	public int memberListTotRecCnt(char kindYmd, int term) {
//		int totRecCnt = 0;
//		try {
//			String addPrepareSQL1 = makeIntervalSQL(kindYmd, term, "startDate");
//			sql = "select count(*) as totRecCnt from member where userDel = 'NO' and userInfo = '공개' ";
//			if(0 < addPrepareSQL1.length()) sql = sql + "and " + addPrepareSQL1;
//			pstmt = conn.prepareStatement(sql);
//			if(0 < addPrepareSQL1.length()) pstmt.setInt(1, term);
//			rs = pstmt.executeQuery();
//			rs.next(); //ResultSet레코드움직이기(count함수는 무조건 0값조차 가져옴)
//			totRecCnt = rs.getInt("totRecCnt");
//		} catch (SQLException e) {
//			e.getMessage();
//		} finally {
//			instance.pstmtClose();
//			instance.rsClose();
//		}
//		return totRecCnt;
//	}
//	//기간별 조회 SQL 조건문 추가 - Interval ex) interval 5 day, interval 1 Month
//	private String makeIntervalSQL(char kindYmd, int term, String columnName) {
//		String sqlInterval = null;
//		if ((0 != kindYmd 
//			&& ('Y' == kindYmd || 'M' == kindYmd || 'D' == kindYmd)) 
//			&& 0 < term) {
//			String sqlIntervalDate = new String("interval ? ");
//			switch(kindYmd) {
//				case 'Y' : sqlIntervalDate += "year"; break;
//				case 'M' : sqlIntervalDate += "month"; break;
//				case 'W' : sqlIntervalDate += "week"; break;
//				case 'D' : sqlIntervalDate += "day"; break;
//				default : break;
//			}
//			String sqlTerm = new String("date_sub(now(), " + sqlIntervalDate + ")");
//			sqlInterval = new String(sqlTerm + " <= " + columnName + " and " + columnName +" <= now() ");
//		} else {
//			sqlInterval = new String("");
//		}
//		return sqlInterval;
//	}
//	//전체회원목록 - 운영자회원(level=4) : userDel='NO'(활동중), userInfo='공개' 회원조회
//	public List<MemberVO> searchMemberList(char kindYmd, int term, int startIndexNo, int pageSize) {
//		List<MemberVO> vos = new ArrayList<>();
//		try {
//			int prepareIdx = 0;
//			String addPrepareSQL1 = makeIntervalSQL(kindYmd, term, "startDate");
//			sql = "select * , timestampdiff(day, lastDate, now()) as overDaysUserDel from member where userDel = 'NO' and userInfo = '공개' ";
//			if(0 < addPrepareSQL1.length()) sql = sql + addPrepareSQL1;
//			sql += "order by idx desc limit ?, ? ";
//			pstmt = conn.prepareStatement(sql);
//			if(0 < addPrepareSQL1.length()) pstmt.setInt(++prepareIdx, term);
//			pstmt.setInt(++prepareIdx, startIndexNo);
//			pstmt.setInt(++prepareIdx, pageSize);
//			rs = pstmt.executeQuery();
//			while(rs.next()) {
//				vo = new MemberVO();
//				vo.setIdx(rs.getInt("idx"));
//				vo.setMid(rs.getString("mid"));
//				vo.setPwd(rs.getString("pwd"));//암호화 비밀번호ㅜㅜ
//				vo.setNickName(rs.getString("nickName"));
//				vo.setName(rs.getString("name"));
//				vo.setGender(rs.getString("gender"));
//				vo.setBirthday(rs.getString("birthday"));
//				vo.setTel(rs.getString("tel"));
//				vo.setAddress(rs.getString("address"));
//				vo.setEmail(rs.getString("email"));
//				vo.setHomepage(rs.getString("homepage"));
//				vo.setJob(rs.getString("job"));
//				vo.setHobby(rs.getString("hobby"));
//				vo.setPhoto(rs.getString("photo"));
//				vo.setContent(rs.getString("content"));
//				vo.setUserInfo(rs.getString("userInfo"));
//				vo.setUserDel(rs.getString("userDel"));
//				vo.setPoint(rs.getInt("point"));
//				vo.setLevel(rs.getInt("level"));
//				vo.setVisitCnt(rs.getInt("visitCnt"));
//				vo.setStartDate(rs.getString("startDate"));
//				vo.setLastDate(rs.getString("lastDate"));
//				vo.setTodayCnt(rs.getInt("todayCnt"));
//				vo.setOverDaysUserDel(rs.getInt("overDaysUserDel"));
//				vos.add(vo);
//			}
//		} catch (SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//			instance.rsClose();
//		}
//		return vos;
//	}
//	
//	// --------------------------------------------------
//	// 로그인 - 로그인 성공시 처리는 아래 update함수에서 처리 <계속>
//	// --------------------------------------------------
//	// 1. 오늘방문횟수 1회씩 증가 - login
//	// 2. 전체방문횟수 1회씩 증가 - login
//	// 3. 회원가입포인트(최초100-insert시 db default 증가, 방문시마다 1포인트씩 증가, 1일 10회 이하) - login
//	// --------------------------------------------------
//	public MemberVO searchMemberLogin(String mid, String pwd) {
//		try {
//			sql = "select *, (select levelName from memberlevel where level = member.level) as levelName "
//					+ "from member "
//					+ "where mid = ? and pwd = ? and userDel = 'No'";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, mid);
//			pstmt.setString(2, new SecurityUtil().encryptSHA256(pwd));//비밀번호 암호화 처리
//			rs = pstmt.executeQuery();
//			if (rs.next()) { //1개 검색된 ResultSet DTO의 레코드로 이동 
//				vo = new MemberVO();
//				vo.setIdx(rs.getInt("idx"));
//				vo.setMid(rs.getString("mid"));
//				vo.setLevel(rs.getInt("level"));
//				vo.setLevelName(rs.getString("levelName"));
//				vo.setName(rs.getString("name"));
//				vo.setNickName(rs.getString("nickName"));
//				vo.setLastDate(rs.getString("lastDate"));
//				vo.setTodayCnt(rs.getInt("todayCnt"));
//				vo.setVisitCnt(rs.getInt("visitCnt"));
//				vo.setPoint(rs.getInt("point"));
//			}
//		} catch (SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//			instance.rsClose();
//		}
//		return vo;
//	}
//
//	// --------------------------------------------------
//	// 로그인 성공시 처리 내용
//	// --------------------------------------------------
//	// 1. 오늘방문횟수 1회씩 증가 - login
//	// 2. 전체방문횟수 1회씩 증가 - login
//	// 3. 회원가입포인트(최초100-insert시 db default 증가, 방문시마다 1포인트씩 증가, 1일 10회 이하) - login
//	// --------------------------------------------------
//	// 로그인 성공시 처리 내용 3. 포인트 1포인트씩 증가 - 로그인시 마다 1 포인트씩 증가(1일 10회 이하 조건은 세션 처리) 
//	public int updatePoint(int idx, String mid) {
//		int res = 0;
//		try {
//			sql = "update member set point = point+5 where idx = ? and mid = ? and userDel = 'No' ";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1 , idx);
//			pstmt.setString(2 , mid);
//			res = pstmt.executeUpdate();
//		} catch (SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//		}
//		return res;
//	}
//	
//	// --------------------------------------------------
//	// 로그인 성공시 처리 내용
//	// --------------------------------------------------
//	// 1. 오늘방문횟수 1회씩 증가 - login
//	// 2. 전체방문횟수 1회씩 증가 - login
//	// 3. 회원가입포인트(최초100-insert시 db default 증가, 방문시마다 1포인트씩 증가, 1일 10회 이하) - login
//	// --------------------------------------------------
//	// 로그인 성공시 처리 내용 1. 오늘방문횟수 1회씩 증가 - login
//	// 로그인 성공시 처리 내용 2. 전체방문횟수 1회씩 증가 - login
//	public int updateVisitCntAndTodayCnt(int idx, String mid) {
//		int res = 0;
//		try {
//			sql = "update member set visitCnt = visitCnt+1, todayCnt = todayCnt+1, lastDate=now() where idx = ? and mid = ? and userDel = 'No' ";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1 , idx);
//			pstmt.setString(2 , mid);
//			res = pstmt.executeUpdate();
//		} catch (SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//		}
//		return res;
//	}
//	
//	//마지막방문일과 오늘방문일(로그인날짜)를 비교해서 다르면, 오늘방문횟수 = 0(초기화)
//	public int updateTodayCnt(int idx, String mid) {
//		int res = 0;
//		try {
//			sql = "update member set todayCnt = 0 where idx = ? and mid = ? and userDel = 'No' ";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1 , idx);
//			pstmt.setString(2 , mid);
//			res = pstmt.executeUpdate();
//		} catch (SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//		}
//		return res;
//	}
//
//	//회원의 아이디 찾기
//	public String searchMid(String email, String pwd) {
//		String mid = null;
//		try {
//			sql = "select mid from member where userDel = 'No' and email = ? and pwd = ? ";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, email);
//			pstmt.setString(2, new SecurityUtil().encryptSHA256(pwd));
//			rs = pstmt.executeQuery();
//			if (rs.next()) mid = rs.getString("mid");//회원의 아이디
//		} catch (SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//			instance.rsClose();
//		}
//		return mid;	
//	}
//
//	//회원의 비밀번호 수정
//	public int updatePwd(String mid, String email, String pwd) {
//		int res = 0;
//		try {
//			sql = "update member set pwd = ? where userDel = 'No' and mid = ? and email = ? ";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1 , new SecurityUtil().encryptSHA256(pwd));
//			pstmt.setString(2 , mid);
//			pstmt.setString(3 , email);
//			res = pstmt.executeUpdate();
//		} catch (SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//		}
//		return res;
//	}
//
//	//회원 개별정보 취득
//	public MemberVO search(int idx, String mid) {
//		try {
//			sql = "select * from member where idx = ? and mid = ? and userDel = 'No'";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, idx);
//			pstmt.setString(2, mid);
//			rs = pstmt.executeQuery();
//			if (rs.next()) {
//				vo = new MemberVO();
//				vo.setIdx(rs.getInt("idx"));
//				vo.setMid(rs.getString("mid"));
//				vo.setPwd(rs.getString("pwd"));//암호화 비밀번호ㅜㅜ
//				vo.setNickName(rs.getString("nickName"));
//				vo.setName(rs.getString("name"));
//				vo.setGender(rs.getString("gender"));
//				vo.setBirthday(rs.getString("birthday"));
//				vo.setTel(rs.getString("tel"));
//				vo.setAddress(rs.getString("address"));
//				vo.setEmail(rs.getString("email"));
//				vo.setHomepage(rs.getString("homepage"));
//				vo.setJob(rs.getString("job"));
//				vo.setHobby(rs.getString("hobby"));
//				vo.setPhoto(rs.getString("photo"));
//				vo.setContent(rs.getString("content"));
//				vo.setUserInfo(rs.getString("userInfo"));
//				vo.setUserDel(rs.getString("userDel"));
//				vo.setPoint(rs.getInt("point"));
//				vo.setLevel(rs.getInt("level"));
//				vo.setVisitCnt(rs.getInt("visitCnt"));
//				vo.setStartDate(rs.getString("startDate"));
//				vo.setLastDate(rs.getString("lastDate"));
//				vo.setTodayCnt(rs.getInt("todayCnt"));
//			} else {
//				vo = null;
//			}
//		} catch (SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//			instance.rsClose();
//		}
//		return vo;
//	}
//
//	//아이디 체크
//	public boolean memberIdCheck(String mid) {
//		boolean isExist = false;
//		try {
//			sql = "select mid from member where mid = ?";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, mid);
//			rs = pstmt.executeQuery();
//			if (rs.next()) isExist = true;//아이디 존재
//		} catch (SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//			instance.rsClose();
//		}
//		return isExist;
//	}
//	
//	//닉네임 체크
//	public boolean memberNickNameCheck(String nickName) {
//		boolean isExist = false;
//		try {
//			sql = "select nickName from member where nickName = ?";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, nickName);
//			rs = pstmt.executeQuery();
//			if (rs.next()) isExist = true;//닉네임 존재
//		} catch (SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//			instance.rsClose();
//		}
//		return isExist;
//	}
//	
//	//이메일 체크
//	public boolean memberEmailCheck(String email) {
//		boolean isExist = false;
//		try {
//			sql = "select email from member where email = ?";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, email);
//			rs = pstmt.executeQuery();
//			if (rs.next()) isExist = true;//이메일 존재
//		} catch (SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//			instance.rsClose();
//		}
//		return isExist;
//	}
//	
//	//개별회원등록 - 가입포인트 100은 db에서 default 증가
//	public int insert(MemberVO vo) {
//		int res = 0;
//		try {
//			sql = "insert into member values ( default, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, default , default, default, default, default, default, default)";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1 , vo.getMid());
//			pstmt.setString(2 , vo.getPwd());
//			pstmt.setString(3 , vo.getNickName());
//			pstmt.setString(4 , vo.getName());
//			pstmt.setString(5 , vo.getGender());
//			pstmt.setString(6 , vo.getBirthday());
//			pstmt.setString(7 , vo.getTel());
//			pstmt.setString(8 , vo.getAddress());
//			pstmt.setString(9 , vo.getEmail());
//			pstmt.setString(10 , vo.getHomepage());
//			pstmt.setString(11 , vo.getJob());
//			pstmt.setString(12 , vo.getHobby());
//			pstmt.setString(13 , vo.getPhoto());
//			pstmt.setString(14 , vo.getContent());
//			pstmt.setString(15 , vo.getUserInfo());
//			res = pstmt.executeUpdate();
//
//		} catch (SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//		}
//		return res;
//	}
//	
//	//개별회원정보수정
//	public int update(MemberVO vo) {
//		int res = 0;
//		try {
//			sql = "update member set"
//					+ "		nickName = ?, name = ?, gender = ?, birthday = ?, tel = ?, address = ?,"
//					+ "		email = ?, homepage = ?, job = ?, hobby = ?, photo = ?, content = ?, userInfo = ? "
//					+ "where idx = ? and mid = ? and userDel = 'No' ";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1 , vo.getNickName());
//			pstmt.setString(2 , vo.getName());
//			pstmt.setString(3 , vo.getGender());
//			pstmt.setString(4 , vo.getBirthday());
//			pstmt.setString(5 , vo.getTel());
//			pstmt.setString(6 , vo.getAddress());
//			pstmt.setString(7 , vo.getEmail());
//			pstmt.setString(8 , vo.getHomepage());
//			pstmt.setString(9 , vo.getJob());
//			pstmt.setString(10 , vo.getHobby());
//			pstmt.setString(11 , vo.getPhoto());
//			pstmt.setString(12 , vo.getContent());
//			pstmt.setString(13 , vo.getUserInfo());
//			pstmt.setInt(14 , vo.getIdx());
//			pstmt.setString(15 , vo.getMid());
//			res = pstmt.executeUpdate();
//
//		} catch (SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//		}
//		return res;
//	}
//	
//	//개별회원탈퇴 - 30일 회원정보유지(userDel=OK(회원탈퇴), lastDate=오늘(탈퇴날짜) 수정)
//	public int updateUserDel(int idx, String mid) {
//		int res = 0;
//		try {
//			sql = "update member set userDel = 'OK', lastDate = now() where idx = ? and mid = ?";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1 , idx);
//			pstmt.setString(2 , mid);
//			res = pstmt.executeUpdate();
//		} catch (SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//		}
//		return res;	
//	}
}