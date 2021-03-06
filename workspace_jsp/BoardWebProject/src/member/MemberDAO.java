package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.JDBCUtil;

//import member.MemberDTO; 같은 패키지 안에서 안써도됨

// DAO(Data Access Object) - DB연결, 해제, 질의를 담당
public class MemberDAO {
	
	// 생성자
	
	// 외부에서 인스턴스 여러개 생성 못함. 생성할려면 MemberDAO.getInstance(); 밖에 없음
	// Singleton Pattern(싱글톤 패턴) : 클래스에 인스턴스를 하나만 생성할 수 있음
	private MemberDAO() {
		
	}
	
	private static MemberDAO memberDAO = new MemberDAO(); 
	
	public static MemberDAO getInstance() { // 외부에서 써야함. public
		return memberDAO;
	}
	
	// DB 연결, 질의객체 선언
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	// 커넥션 획득 - Connection Pool 사용
	public static Connection getConnection() throws Exception { // 커넥션 리턴, 예외처리
		return JDBCUtil.getConnection();
	}
	
	// 커넥션 반납 - Connection, PreparedStatement : insert일 때, update일 때, delete일 때
	public static void close(Connection conn, PreparedStatement pstmt) {
		JDBCUtil.close(conn, pstmt);
	}
	
	// 커넥션 반납 - Connection, PreparedStatement, ResultSet : select일 때
	public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		JDBCUtil.close(conn, pstmt, rs);
	}
	
	// 메소드
	// 회원가입 메소드 
	public int insertMember(MemberDTO member) {
		String sql = "INSERT INTO member VALUES(?,?,?,?,?,?,NOW())";
		int cnt = 0;
		
		try {
			conn = JDBCUtil.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPwd());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getTel());
			pstmt.setString(6, member.getAddress());
			cnt = pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return cnt;
	}
	
	// 회원 ID 중복 체크
	public int checkId(String id){
		String sql = "SELECT * FROM member WHERE id = ?";
		int cnt = 0; // 성공 여부
		
		try {
			conn = JDBCUtil.getConnection();	
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();	
			
			if (!rs.next()) 
				// rs.next가 false => 가입 가능
				cnt = 1;  
				
		} catch(Exception e) {
			e.printStackTrace();	
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		
		return cnt;
		
	}
	
	// 로그인 메소드
	public int login(String id, String pwd) {
		String sql = "SELECT * FROM member WHERE id = ?";
		int cnt = -1; // -1: 아이디가 없음, 0 : 아이디는 있고 암호가 다름, 1: 아이디와 비밀번호가 모두 일치
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				// 아이디가 있음
				String dbPwd = rs.getString("pwd");
				if (pwd.equals(dbPwd)) {
					// 아이디와 비밀번호 일치
					cnt = 1;
				} else {
					// 아이디와 비밀번호 일치하지 않음
					cnt = 0;
				}
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		
		return cnt;
	}
	
	// 회원 정보 보기(1명, 자신의 정보)
	public MemberDTO getMember(String id) {
		String sql = "select * from member where id = ?";
		MemberDTO member = new MemberDTO(); // 인스턴스 생성
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				// 가입일 제외한 정보를 member 테이블로부터 가져와서 member 객체에 저장
				member.setId(rs.getString("id")); // db에서 가져온 id의 정보를 member 인스턴스에 넣음
				member.setPwd(rs.getString("pwd"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setTel(rs.getString("tel"));
				member.setAddress(rs.getString("address"));
				member.setRegDate(rs.getTimestamp("regDate"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return member;
	}
	
	// 회원 정보 수정
	public int updateMember(MemberDTO member) {
		// 멤버 정보를 다 가져와야하기 때문에 매개변수로 MemberDTO 인스턴스 씀
		String sql = "UPDATE member SET pwd=?, name=?, email=?, tel=?, address=? WHERE id = ?";
		int cnt = 0; // 성공 여부
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPwd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getTel());
			pstmt.setString(5, member.getAddress());
			pstmt.setString(6, member.getId());
			cnt = pstmt.executeUpdate(); // 0보다 크면 업데이트 성공		
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		
		return cnt;
	}

	// 회원 삭제(탈퇴)메소드 -> 해당 회원이 남긴 게시판의 글도 모두 삭제되도록 변경
	// 트랜잭션 처리
	public int deleteMember(String id, String pwd) {
		String sql1 = "DELETE FROM member WHERE id = ? AND pwd = ?";
		String sql2 = "DELETE FROM board WHERE writer = ?";
		int cnt = 0;
		
		try {
			
			conn = JDBCUtil.getConnection();
			
			// 트랜잭션(transaction) 처리 - DML(INSERT, UPDATE, DELETE)작업이 2개 이상 함께 처리되어야 할 때, 
			// 모두 처리되던지, 모두 처리되지 않게 하도록 하는 방법
			// All or Nothing
			
			// 트랜잭션 1단계 - auto commit 기능 끔
			conn.setAutoCommit(false);
			
			// 1작업: 회원 삭제(탈퇴) 작업
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			cnt = pstmt.executeUpdate(); // 0보다 크면 delete 성공
			
			// 2작업: 해당 회원이 남긴 게시판 글을 모두 삭제
			pstmt = conn.prepareStatement(sql2);
			pstmt.setNString(1, id);
			pstmt.executeUpdate();
			
			// 트랜잭션 2단계  - 모든 작업이 완료 되었을 때 커밋을 함.
			conn.commit();
			
			// 트랜잭션 3단계 - auto commit 기능을 다시 설정해놓아야함.
			conn.setAutoCommit(true);
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return cnt;
	}
}
