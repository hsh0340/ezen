package board;

import java.sql.Timestamp;

// DTO, VO, DataBean - jsp 페이지에서 board 데이터의 이동을 담당

public class BoardDTO {
	// 프로퍼티(property)
	private int num; // 글번호
	private String writer; // 글쓴이
	private String subject; // 글제목
	private String content; // 글내용
	private Timestamp regDate; // 등록일시
	private int readcount; // 조회수
	private int ref; // 댓글 그룹
	private int re_step; // 댓글 순서
	private int re_level; // 댓글 레벨
	public int getNum() {
		return num;
	}
	public String getWriter() {
		return writer;
	}
	public String getSubject() {
		return subject;
	}
	public String getContent() {
		return content;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public int getReadcount() {
		return readcount;
	}
	public int getRef() {
		return ref;
	}
	public int getRe_step() {
		return re_step;
	}
	public int getRe_level() {
		return re_level;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}
	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}
	@Override
	public String toString() {
		return "BoardDTO [num=" + num + ", writer=" + writer + ", subject=" + subject + ", content=" + content
				+ ", regDate=" + regDate + ", readcount=" + readcount + ", ref=" + ref + ", re_step=" + re_step
				+ ", re_level=" + re_level + "]";
	}
}
