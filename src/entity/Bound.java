package entity;

import java.util.Set;

public class Bound {
	private String bid;
	private Integer paymentid;
	private Account account;
    private Set<PayTransactionLog> paytransactionlogs;
    
	public String getBid() {
		return bid;
	}



	public void setBid(String bid) {
		this.bid = bid;
	}



	public Integer getPaymentid() {
		return paymentid;
	}



	public void setPaymentid(Integer paymentid) {
		this.paymentid = paymentid;
	}



	public Account getAccount() {
		return account;
	}



	public void setAccount(Account account) {
		this.account = account;
	}


	public Bound(String bid, Integer paymentid, Account account) {
		super();
		this.bid = bid;
		this.paymentid = paymentid;
		this.account = account;
	}



	public Bound() {
		super();
	}



	public Set<PayTransactionLog> getPaytransactionlogs() {
		return paytransactionlogs;
	}



	public void setPaytransactionlogs(Set<PayTransactionLog> paytransactionlogs) {
		this.paytransactionlogs = paytransactionlogs;
	}







	


    



}
