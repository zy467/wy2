package entity;

public class Personinfo {
	private String pid;
	private Account account;
	private String realname;
	private Integer age;
	private String sex;
	private String cardid;
	private String telephone;
    




	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getRealname() {
		return realname;
	}

	public void setRealname(String realname) {
		this.realname = realname;
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	

	public String getCardid() {
		return cardid;
	}

	public void setCardid(String cardid) {
		this.cardid = cardid;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}

	

	public Personinfo(String pid, Account account, String realname, Integer age, String sex, String cardid,
			String telephone) {
		super();
		this.pid = pid;
		this.account = account;
		this.realname = realname;
		this.age = age;
		this.sex = sex;
		this.cardid = cardid;
		this.telephone = telephone;
	}

	public Personinfo() {
		super();
	}
}
