package entity;

import java.util.Set;

public class Account {

	private Integer accountid;
	private String username;
	private String password;
	private Double balance;
	private Status status;
	private Role role;
	private Set<TransactionLog> transactions;
	private Personinfo personinfo;
	private Set<Bound> bounds;

	
	public Set<Bound> getBounds() {
		return bounds;
	}

	public void setBounds(Set<Bound> bounds) {
		this.bounds = bounds;
	}

	public Integer getAccountid() {
		return accountid;
	}

	public void setAccountid(Integer accountid) {
		this.accountid = accountid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Double getBalance() {
		return balance;
	}

	public void setBalance(Double balance) {
		this.balance = balance;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}





	public Set<TransactionLog> getTransactions() {
		return transactions;
	}

	public void setTransactions(Set<TransactionLog> transactions) {
		this.transactions = transactions;
	}

	public Personinfo getPersoninfo() {
		return personinfo;
	}

	public void setPersoninfo(Personinfo personinfo) {
		this.personinfo = personinfo;
	}

	public Account(String username, String password, Double balance, Status status, Role role) {
		super();
		this.username = username;
		this.password = password;
		this.balance = balance;
		this.status = status;
		this.role = role;
	}

	public Account(Integer accountid, String username, String password, Double balance, Status status, Role role,
			Personinfo personinfo) {
		super();
		this.accountid = accountid;
		this.username = username;
		this.password = password;
		this.balance = balance;
		this.status = status;
		this.role = role;
		this.personinfo = personinfo;
	}

	public Account() {
		super();
	}

}
