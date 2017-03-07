package entity;

import java.util.Date;

public class TransactionLog {
	private Integer trid;
	private Double tr_money;
	private Date datetime;
	private TransactionType type;
	private String otherid;
	private Integer orderstatus;
	private Account account;

	public Integer getTrid() {
		return trid;
	}
	public void setTrid(Integer trid) {
		this.trid = trid;
	}
	
	public Double getTr_money() {
		return tr_money;
	}
	public void setTr_money(Double tr_money) {
		this.tr_money = tr_money;
	}
	public Date getDatetime() {
		return datetime;
	}
	public void setDatetime(Date datetime) {
		this.datetime = datetime;
	}

	public TransactionType getType() {
		return type;
	}
	public void setType(TransactionType type) {
		this.type = type;
	}

	
	public String getOtherid() {
		return otherid;
	}
	public void setOtherid(String otherid) {
		this.otherid = otherid;
	}
	public Integer getOrderstatus() {
		return orderstatus;
	}
	public void setOrderstatus(Integer orderstatus) {
		this.orderstatus = orderstatus;
	}

	public Account getAccount() {
		return account;
	}
	public void setAccount(Account account) {
		this.account = account;
	}
	public TransactionLog(Double tr_money, TransactionType type, String otherid, Account account) {
		super();
		this.tr_money = tr_money;
		this.type = type;
		this.otherid = otherid;
		this.account = account;
		this.datetime=new Date();
		this.orderstatus = 1;
	}
	public TransactionLog() {
		super();
	}

	

}
