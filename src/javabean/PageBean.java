package javabean;



public class PageBean {
	private int currentpage = 1;
	private int pagesize = 8;  //每页条数
	int totalpage;            //总页数
	int start;               //当前页开始条数
	int end;                 //当前页结束条数
	private Integer totalrecord;//总条数


	public int getCurrentpage() {
		return currentpage;
	}

	public void setCurrentpage(int currentpage) {
		this.currentpage = currentpage;
	}

	public int getPagesize() {
		return pagesize;
	}

	public void setPagesize(int pagesize) {
		this.pagesize = pagesize;
	}

	public int getTotalpage() {
		return (int) Math.ceil((double)getTotalrecord()/getPagesize());
	}

	public void setTotalpage(int totalpage) {
		this.totalpage = totalpage;
	}

	public int getStart() {
		return (getCurrentpage()-1)*pagesize;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return getCurrentpage()*pagesize-1;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public int getTotalrecord() {
		if(totalrecord==0){
			return 1;
		}else{
			return totalrecord;
		}
		
	}

	public void setTotalrecord(Integer totalrecord) {
		this.totalrecord = totalrecord;
	}

}
