package com.spring.javagreenS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS.vo.BoardVO;

public interface BoardDAO {

	public int searchBoardListTotRecCnt();

	public int searchBoardListTotSearchRecCnt(@Param("searchCondition") String searchCondition, @Param("searchingKeyWord") String searchingKeyWord);
	
	public List<BoardVO> searchBoardList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public List<BoardVO> searchBoardSearchList(@Param("startIndexNo") int startIndexNo, 
			@Param("pageSize") int pageSize, 
			@Param("searchCondition") String searchCondition, 
			@Param("searchString") String searchString);

	public void insertBoard(@Param("vo") BoardVO vo);

	public void updateReadNum(int idx);

	public BoardVO searchBoard(int idx);

	public List<BoardVO> searchPrevNextBoard(@Param("idx") int idx);

	public void deleteBoard(@Param("idx") int idx);

	public void updateBoard(@Param("vo") BoardVO vo);

//	private final MysqlConn instance = MysqlConn.getInstance();
//	private final Connection conn = instance.getConn();
//	private PreparedStatement pstmt = null;
//	private ResultSet rs = null;
//	private BoardVO vo = null;
//	private String sql = new String("");
//	
//	//게시판 전체목록 페이징(총 레코드 건수) - 검색조건
//	public int boardListTotRecCnt(char kindYmd, int term, String searchConditionKey, String searchConditionValue) {
//		int totRecCnt = 0;
//		try {
//			int prepareIdx = 0;
//			boolean isExistSearchCondition = isExistSearchCondition(searchConditionKey, searchConditionValue);
//			boolean isExistInterval = isExistInterval(kindYmd, term);
//			sql = "select count(*) as totRecCnt from board ";
//			if (isExistSearchCondition || isExistInterval) sql += "where "; 
//			String addPrepareSQL1 = searchConditionKey + " like ? ";
//			if (isExistSearchCondition) sql += addPrepareSQL1;
//			String addPrepareSQL2 = makeIntervalSQL(kindYmd, term, "wDate");
//			if (isExistSearchCondition && isExistInterval) {
//				sql = sql + "and " + addPrepareSQL2;
//			} else if (!isExistSearchCondition && isExistInterval) {
//				sql += addPrepareSQL2;
//			}
//			pstmt = conn.prepareStatement(sql);
//			if(isExistSearchCondition) pstmt.setString(++prepareIdx, "%" + searchConditionValue + "%");
//			if(isExistInterval) pstmt.setInt(++prepareIdx, term);
//			rs = pstmt.executeQuery();
//			rs.next(); //ResultSet레코드움직이기(count함수는 무조건 0값조차 가져옴)
//			totRecCnt = rs.getInt("totRecCnt");
//		} catch (SQLException e) {
//			e.getMessage();
//		} finally {
//			instance.rsClose();
//			instance.pstmtClose();
//		}
//		return totRecCnt;
//	}
//	private boolean isExistSearchCondition(String searchConditionKey, String searchConditionValue) {
//		boolean isExistSearchCondition = false;
//		if (null != searchConditionKey && searchConditionKey.trim().length() > 0 
//			&& null != searchConditionValue && searchConditionValue.trim().length() > 0)
//			isExistSearchCondition = true;
//		return isExistSearchCondition;
//	}
//	private boolean isExistInterval(char kindYmd, int term) {
//		boolean isExistInterval = false;
//		if ((0 != kindYmd 
//			&& ('Y' == kindYmd || 'M' == kindYmd || 'D' == kindYmd)) 
//			&& 0 < term) 
//			isExistInterval = true;
//		return isExistInterval;
//	}
//	//기간별 조회 SQL 조건문 추가 - Interval ex) interval 5 day, interval 1 Month
//	private String makeIntervalSQL(char kindYmd, int term, String columnName) {
//		String sqlInterval = null;
//		if (isExistInterval(kindYmd, term)) {
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
//	
//	//게시판 목록 조회-검색조건
//	//select *, (select count(*) from boardreply where boardIdx = board.idx) as replyCnt --이큐조인
//	//from board
//	//where searchConditionKey like '%searchConditionValue%' --검색조건(제목,작성자,글내용)
//	//and date_sub(now(), interval term kindYmd) <= wDate and wDate <= now() --기간별조회(daily, weekly, monthly, yearly)
//	//order by idx desc limit startIndexNo, pageSize ;
//	public List<BoardVO> searchBoardList(char kindYmd, int term, String searchConditionKey, String searchConditionValue, int startIndexNo, int pageSize) {
//		List<BoardVO> vos = new ArrayList<>();
//		try {
//			int prepareIdx = 0;
//			boolean isExistSearchCondition = isExistSearchCondition(searchConditionKey, searchConditionValue);
//			boolean isExistInterval = isExistInterval(kindYmd, term);
//			sql = "select *, 0 as replyCnt from board ";
//			if (isExistSearchCondition || isExistInterval) sql += "where "; 
//			String addPrepareSQL1 = searchConditionKey + " like ? ";
//			if (isExistSearchCondition) sql += addPrepareSQL1;
//			String addPrepareSQL2 = makeIntervalSQL(kindYmd, term, "wDate");
//			if (isExistSearchCondition && isExistInterval) {
//				sql = sql + "and " + addPrepareSQL2;
//			} else if (!isExistSearchCondition && isExistInterval) {
//				sql += addPrepareSQL2;
//			}
//			sql += "order by idx desc limit ?, ?";
//			pstmt = conn.prepareStatement(sql);
//			if (isExistSearchCondition) pstmt.setString(++prepareIdx, "%"+searchConditionValue+"%");
//			if (isExistInterval) pstmt.setInt(++prepareIdx, term);
//			pstmt.setInt(++prepareIdx, startIndexNo);
//			pstmt.setInt(++prepareIdx, pageSize);
//			rs = pstmt.executeQuery();
//			while (rs.next()) {
//				vo = new BoardVO();
//				vo.setIdx(rs.getInt("idx"));
//				vo.setNickName(rs.getString("nickName"));
//				vo.setTitle(rs.getString("title"));
//				vo.setEmail(rs.getString("email"));
//				vo.setHomepage(rs.getString("homepage"));
//				vo.setContent(rs.getString("content"));
//				vo.setStrWdate(rs.getString("wDate"));
//				vo.setIntWDate(new TimeDiff().timeDiff(vo.getStrWdate()));//오늘날짜와 글쓴날짜의 시간차이
//				vo.setwDate(rs.getString("wDate"));
//				vo.setReadNum(rs.getInt("readNum"));
//				vo.setHostIp(rs.getString("hostIp"));
//				vo.setRecommendNum(rs.getInt("recommendNum"));
//				vo.setMid(rs.getString("mid"));
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
//	//게시글 조회
//	public BoardVO search(int idx) {
//		try {
//			sql = "SELECT "
//					+ "		IDX, "
//					+ "		NICKNAME, "
//					+ "		TITLE, "
//					+ "		EMAIL, "
//					+ "		HOMEPAGE, "
//					+ "		CONTENT, "
//					+ "		WDATE, "
//					+ "		READNUM, "
//					+ "		HOSTIP, "
//					+ "		RECOMMENDNUM, "
//					+ "		MID "
//					+ "FROM "
//					+ "		BOARD "
//					+ "WHERE"
//					+ "		IDX = ?";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, idx);
//			rs = pstmt.executeQuery();
//			if (rs.next()) {
//				vo = new BoardVO();
//				vo.setIdx(rs.getInt("idx"));
//				vo.setNickName(rs.getString("nickName"));
//				vo.setTitle(rs.getString("title"));
//				vo.setEmail(rs.getString("email"));
//				vo.setHomepage(rs.getString("homepage"));
//				vo.setContent(rs.getString("content"));
//				vo.setStrWdate(rs.getString("wDate"));
//				vo.setIntWDate(new TimeDiff().timeDiff(vo.getStrWdate()));//오늘날짜와 글쓴날짜의 시간차이
//				vo.setwDate(rs.getString("wDate"));
//				vo.setReadNum(rs.getInt("readNum"));
//				vo.setHostIp(rs.getString("hostIp"));
//				vo.setRecommendNum(rs.getInt("recommendNum"));
//				vo.setMid(rs.getString("mid"));
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
//	//회원의 게시판에 올린 글 수
//	public int searchBoardWriteCnt(String mid, String nickname) {
//		int cnt = 0;
//		try {
//			sql = "select count(mid) as count from board where mid = ? and nickName = ? ";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, mid);
//			pstmt.setString(2, nickname);
//			rs = pstmt.executeQuery();
//			rs.next(); //count()는 데이타가 없으면 '0'값을 취득하면서 rs도 같이 리턴하므로, 레코드를 읽는 목적으로 rs.next()사용
//			cnt = rs.getInt("count"); 
//		} catch (SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//			instance.rsClose();
//		}
//		return cnt;
//	}
//	
//	//회원의 댓글에 올린 글 수
//	public int searchBoardreplyWriteCnt(String mid, String nickname) {
//		int cnt = 0;
//		try {
//			sql = "select count(mid) as count from boardreply where mid = ? and nickName = ? ";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, mid);
//			pstmt.setString(2, nickname);
//			rs = pstmt.executeQuery();
//			rs.next(); //count()는 데이타가 없으면 '0'값을 취득하면서 rs도 같이 리턴하므로, 레코드를 읽는 목적으로 rs.next()사용
//			cnt = rs.getInt("count"); 
//		} catch (SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//			instance.rsClose();
//		}
//		return cnt;
//	}
//	
//	//게시글 등록
//	public int insert(BoardVO vo) {
//		int res = 0;
//		try {
//			sql = "insert into board values ( default, ?, ?, ?, ?, ?, default, ?, ?, default, default, default, default )";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, vo.getNickName());
//			pstmt.setString(2, vo.getTitle());
//			pstmt.setString(3, vo.getEmail());
//			pstmt.setString(4, vo.getHomepage());
//			pstmt.setString(5, vo.getContent());
//			pstmt.setString(6, vo.getMid());
//			pstmt.setString(7, vo.getHostIp());
//			res = pstmt.executeUpdate();
//		} catch(SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//		}
//		return res;
//	}
//
//	//게시글 조회수 1회 증가
//	public int updateReadNum(int idx) {
//		int res = 0;
//		try {
//			sql = "update board set readNum = readNum + 1 where idx = ? ";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, idx);
//			res = pstmt.executeUpdate();
//		} catch(SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//		}
//		return res;
//	}
//
//	//게시글 좋아요수 1회 증가 및 싫어요 1회 감소
//	public int updateRecommendNum(int idx) {
//		int res = 0;
//		try {
//			sql = "update "
//					+ "	board "
//					+ "set"
//					+ "	recommendNum = recommendNum + 1 ," //좋아요 1회 증가
//					+ "	noRecommendNum = case noRecommendNum when 0 then 0 else noRecommendNum -1 end " //싫어요 1회 감소
//					+ "where "
//					+ "	idx = ? ";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, idx);
//			res = pstmt.executeUpdate();
//		} catch(SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//		}
//		return res;
//	}
//
//	//게시글 싫어요수 1회 증가 및 좋아요 1회 감소
//	public int updateNoRecommendNum(int idx) {
//		int res = 0;
//		try {
//			sql = "update "
//					+ "	board "
//					+ "set"
//					+ "	noRecommendNum = noRecommendNum + 1 ," //싫어요 1회 증가
//					+ "	recommendNum = case recommendNum when 0 then 0 else recommendNum -1 end " //좋아요 1회 감소
//					+ "where "
//					+ "	idx = ? ";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, idx);
//			res = pstmt.executeUpdate();
//		} catch(SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//		}
//		return res;
//	}
//	
//	//게시글 좋아요 총횟수 조회
//	public int searchBoardRecommendNum(int idx) {
//		int recommendNum = -1;
//		try {
//			sql = "select recommendNum from board where idx = ? ";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, idx);
//			rs = pstmt.executeQuery();
//			if(rs.next()) recommendNum = rs.getInt("recommendNum"); 
//		} catch (SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//			instance.rsClose();
//		}
//		return recommendNum;
//	}
//
//	//게시글 수정
//	public int update(BoardVO vo) {
//		int res = 0;
//		try {
//			sql = "update board set title = ?, email = ?, homepage = ?, content = ?, hostIp = ? where idx = ? and mid = ?";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, vo.getTitle());
//			pstmt.setString(2, vo.getEmail());
//			pstmt.setString(3, vo.getHomepage());
//			pstmt.setString(4, vo.getContent());
//			pstmt.setString(5, vo.getHostIp());
//			pstmt.setInt(6, vo.getIdx());
//			pstmt.setString(7, vo.getMid());
//			res = pstmt.executeUpdate();
//		} catch(SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//		}
//		return res;	
//	}
//
//	//게시글 삭제
//	public int delete(int idx, String mid) {
//		int res = 0;
//		try {
//			sql = "delete from board where idx = ? and mid = ? ";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, idx);
//			pstmt.setString(2, mid);
//			res = pstmt.executeUpdate();
//		} catch(SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//		}
//		return res;	
//	}
}
