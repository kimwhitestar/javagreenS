package admin.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import common.SecurityUtil;
import conn.MysqlConn;

public class AdminDAO {
	private final MysqlConn instance = MysqlConn.getInstance();
	private final Connection conn = instance.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = new String("");

	public AdminDAO() {}
	
	//관리자(level:'0')의 로그인정보(mid,pwd) 검색
	public int searchAdminLogin(String mid, String pwd) {
		int res = 0;
		try {
			sql = "select * from member where level = 0 and mid = ? and pwd = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, new SecurityUtil().encryptSHA256(pwd));//비밀번호 암호화처리-SHA2(sha256)
			rs = pstmt.executeQuery();
			if (rs.next()) res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
			instance.rsClose();
		}
		return res;
	}
}
