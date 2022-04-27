package test;

/*
< 자바빈 >
- id, pwd, name, clubname, age, tel, email, addr

1. 자바빈을 완성하시오.
2. clubUserForm.jsp에서 입력폼을 만들어 clubUserPro.jsp에서 처리하도록 하시오.
3. clubUserForm.jsp에서는 액션태그를 사용하여 정보를 처리하고, 테이블 형태로 출력하시오.

해결시간 : 20분
 */

public class ClubUser {

	// 프로퍼티
	private String id;
	private String pwd;
	private String name;
	private String clubName;
	private int age;
	private String tel;
	private String email;
	private String addr;

	// setter
	public void setId(String id) {
		this.id = id;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setClubname(String clubName) {
		this.clubName = clubName;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	// getter
	public String getId() {
		return id; // return this.id;
	}

	public String getPwd() {
		return pwd;
	}

	public String getName() {
		return name;
	}

	public String getClubname() {
		return clubName;
	}

	public int getAge() {
		return age;
	}

	public String getTel() {
		return tel;
	}

	public String getEmail() {
		return email;
	}

	public String getAddr() {
		return addr;
	}

}
