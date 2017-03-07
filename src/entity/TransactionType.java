package entity;

public class TransactionType {
	private Integer typeid;
	private String typename;

	public Integer getTypeid() {
		return typeid;
	}

	public void setTypeid(Integer typeid) {
		this.typeid = typeid;
	}

	public String getTypename() {
		return typename;
	}

	public void setTypename(String typename) {
		this.typename = typename;
	}

	public TransactionType(Integer typeid, String typename) {
		super();
		this.typeid = typeid;
		this.typename = typename;
	}

	public TransactionType() {
		super();
	}

}
