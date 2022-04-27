package test;

public class TestBean {
	
	// property
	private String id;   // 사용자 아이디
	private String name; // 사용자 이름
	
	// setter
	public void setId(String id) {
		this.id = id;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	// getter
	public String getId() {
		return id; // return this.id;
	}
	
	public String getName() {
		return name; // return this.name;
	}
}
