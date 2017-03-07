package entity;

import java.util.Date;

public class NbTransactionLog {
	private Integer trid;
	private Double tr_money;
	private Date datetime;
	private TransactionType type;
	private Integer orderstatus;
	private String paymentsn;
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
	public String getPaymentsn() {
		return paymentsn;
	}
	public void setPaymentsn(String paymentsn) {
		this.paymentsn = paymentsn;
	}
}
