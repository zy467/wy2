package entity;

import java.util.Date;

public class PayTransactionLog {
	private Integer trid;
	private Double tr_money;
	private Date datetime;
	private Integer orderstatus;
	private TransactionType type;
	private String paymentsn;
	private Bound bound;
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
	public Integer getOrderstatus() {
		return orderstatus;
	}
	public void setOrderstatus(Integer orderstatus) {
		this.orderstatus = orderstatus;
	}
	public TransactionType getType() {
		return type;
	}
	public void setType(TransactionType type) {
		this.type = type;
	}
	public String getPaymentsn() {
		return paymentsn;
	}
	public void setPaymentsn(String paymentsn) {
		this.paymentsn = paymentsn;
	}
	public Bound getBound() {
		return bound;
	}
	public void setBound(Bound bound) {
		this.bound = bound;
	}
	public PayTransactionLog(Double tr_money, Date datetime, TransactionType type, String paymentsn, Bound bound) {
		super();
		this.tr_money = tr_money;
		this.datetime = datetime;
		this.type = type;
		this.paymentsn = paymentsn;
		this.bound = bound;
		this.orderstatus=0;
	}
	public PayTransactionLog() {
		super();
	}
	
}
