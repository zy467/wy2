package dao;


import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;


import entity.Account;
import entity.Admin;
import entity.AllTransaction;
import entity.Bound;
import entity.PayTransactionLog;
import entity.Personinfo;
import entity.Status;
import entity.TransactionLog;
import entity.TransactionType;
import javabean.PageBean;

public class DateBase {
	SessionFactory sessionFactory;
	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public Session getSession() {
		return sessionFactory.openSession();
	}
	
	/*与支付端交互*/
	/*绑卡*/
	//保存绑卡信息
	 public boolean saveBound(Bound b){
    	Session session = getSession();
		org.hibernate.Transaction tr= session.beginTransaction();
		try {
			session.save(b);
			tr.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		     tr.rollback();
			return false;
		}	
    }
	 //判断用户身份证号、卡号、真实姓名
	public Account findAccountByCardidandrealnameandpid(String cardid,String realname,String pid) {
		String hql = "select account from Personinfo where cardid=? and realname=? and pid=?";
		Query query = getSession().createQuery(hql);
		query.setParameter(0, cardid);
		query.setParameter(1, realname);
		query.setParameter(2, pid);
		return (Account) query.uniqueResult();
	}
	/*提现*/
	//获取Bound
	public Bound findBoundByBid(String bid){
		return (Bound) getSession().get(Bound.class, bid);//bid必须为主键，否则不能用此方法
	}
	//保存订单记录
	public boolean savePayTransactionLog(PayTransactionLog pt){
		Session session = getSession();
		org.hibernate.Transaction tr = session.beginTransaction();
		try{
			session.save(pt);
			tr.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		    tr.rollback();
			return false;
		}
	}
	//更新订单状态
	public boolean updateOrderStatus(PayTransactionLog pt){
		Session session = getSession();
		Transaction tr = session.beginTransaction();
		try {
			pt.setOrderstatus(1);
			session.merge(pt);
			tr.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return false;
		}finally{
			session.close();
		}
	}
	//查找支付交易信息
	 public PayTransactionLog findPayTransactionLog(Integer i) {
			return (PayTransactionLog) getSession().get(PayTransactionLog.class, i);
		}
	 
	 //根据流水号查找交易信息
	 public PayTransactionLog findPayTransactionLogByPaymentsn(String paymentsn) {
		 Query query = getSession().createQuery("from PayTransactionLog where paymentsn=?");
			query.setParameter(0, paymentsn);
			PayTransactionLog pay = (PayTransactionLog) query.uniqueResult();
			return pay;
		}
	 
	 //更新交易信息
	 public boolean updatePayTransaction(PayTransactionLog pay) {
			Session session = getSession();
			org.hibernate.Transaction tr = session.beginTransaction();
			try {
				session.update(pay);
				tr.commit();
				return true;
			} catch (Exception e) {
				e.printStackTrace();
				tr.rollback();
				return false;
			}
		}
	 
	 //插入交易信息
	 public Integer savePayTransaction(PayTransactionLog pay) {
			Session session = getSession();
			org.hibernate.Transaction tr = session.beginTransaction();
			Integer i;
			try {
				i =  (Integer) session.save(pay);
				tr.commit();
				return i;
			} catch (Exception e) {
				i=null;
				e.printStackTrace();
				tr.rollback();
				return i;
			}

		} 
	 //更新余额
	 public boolean updateAccountBalance(Account a, Account paymentAccount) {
			Session session = getSession();
			org.hibernate.Transaction tr = session.beginTransaction();
			try {
				session.merge(a);
				session.merge(paymentAccount);
				tr.commit();
				return true;
			} catch (Exception e) {
				e.printStackTrace();
				tr.rollback();
				return false;
			}

		}
	 //调账
	 @SuppressWarnings("unchecked")
		public List<Object[]> findPayTransactionLog(Date begindatetime,Date enddatetime,String paymentsn){
			//String hql="from PayTransactionLog where paymentsn like "+paymentsn+" and datetime"+" between "+begindatetime+" and "+enddatetime;
			String hql="select pay.trid,pay.tr_money,pay.bound.bid,pay.type.typeid,pay.orderstatus,pay.paymentsn,pay.datetime from PayTransactionLog pay where paymentsn like :paymentsn and datetime between :begindatetime and :enddatetime";
			Session session=getSession();
			Query query=session.createQuery(hql);
			query.setParameter("paymentsn", paymentsn);
			query.setParameter("begindatetime", begindatetime);
			query.setParameter("enddatetime", enddatetime);
			return query.list();
			
		}


	/*前端设计*/
	/*管理员*/
	//管理员登录
	public Admin findAdminByUsername(String username) {
		Query query = getSession().createQuery("from Admin where username=?");
		query.setParameter(0, username);
		Admin adm = (Admin) query.uniqueResult();
		return adm;
	}
	// 管理员修改密码
	public int updateAdminPassword(String password, String username) {
		String sql = "update Admin set password=? where username=?";
		Query query = getSession().createQuery(sql);
		query.setParameter(0, password);
		query.setParameter(1, username);
		return query.executeUpdate();
	}
	//启用状态
	public int updateStatus(int sid,String username){
		Session session = getSession();
		String sql = "update Account set sid=? where username=?";
		Query query = session.createQuery(sql);
		query.setParameter(0, sid);
		query.setParameter(1, username);
		return query.executeUpdate();
	}
	//查询用户状态
	public Status findAccountStatusByAccoundId(Integer accountid){
		Query query = getSession().createQuery("select status from Account where accountid=?");
		query.setParameter(0, accountid);
		return (Status)query.uniqueResult();
	}
	
	
	// 修改公告(未完成)
	// updateNotice
	
	/*用户*/
	//用户登录
	public Account findAccountByUsername(String username) {
		Query query = getSession().createQuery("from Account where username=?");
		query.setParameter(0, username);
		Account a = (Account) query.uniqueResult();
		return a;
	}
	// 注册
	public boolean insertAccountAndPersonInfo(Personinfo p) {
		Session session = getSession();
		Transaction tr=session.beginTransaction();
		try {
			session.save(p);
			tr.commit();
			return true;
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return false;
		}
	}
	//验证身份证号
	public Account findPersoninfoByPid(String pid){
		Query query = getSession().createQuery("select account from Personinfo where pid=?");
		query.setParameter(0, pid);
		Account a = (Account) query.uniqueResult();
		return a;
	}
	// 用户修改密码
	public int updateAccountPassword(String password, String username) {
		String sql = "update Account set password=? where username=?";
		Query query = getSession().createQuery(sql);
		query.setParameter(0, password);
		query.setParameter(1, username);
		return query.executeUpdate();
	}
	// 修改个人信息
	public int updatePersoninfo(String telephone, String pid) {
		String sql = "update Personinfo set telephone=? where pid=?";
		Query query = getSession().createSQLQuery(sql);
		query.setParameter(0, telephone);
		query.setParameter(1, pid);
		return query.executeUpdate();
	}
	
	//转账
	public Account findAccountByCardid(String cardid) {
		String sql = "select account from Personinfo where cardid=?";
		Query query = getSession().createQuery(sql);
		query.setParameter(0, cardid);
		return (Account) query.uniqueResult();
	}
	// 获取交易类型
	public TransactionType getTransactionType(int typeId) {
		return (TransactionType) getSession().get(TransactionType.class, typeId);
	}
	//更新余额
	public boolean updateBalance(Account account, Account otherAccount, Double tr_money) {
		Session session = getSession();
		Transaction tr = session.beginTransaction();
		try {
			account.setBalance(account.getBalance() - tr_money);
			otherAccount.setBalance(otherAccount.getBalance() + tr_money);
			session.merge(account);
			session.merge(otherAccount);
			tr.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return false;
		}finally{
			session.close();
		}
	}
	//生成交易记录
	public void makeTransactionLog(TransactionLog transactionlog) {
		  Session session=getSession();
		try {
			session.merge(transactionlog);
		    session.beginTransaction().commit();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			session.close();
		}
	}
	// 挂失
	public int userFreeze(String username) {
		String sql = "update Account set sid=1 where username=?";
		Query query = getSession().createQuery(sql);
		query.setParameter(0, username);
		return query.executeUpdate();
	}
	
	/*分页*/
	//查询用户总数
	public int findAllUsersCount(){
		Session session = getSession();
		Query query = session.createSQLQuery("select count(*) from Account where rid=0");
		BigDecimal big = (BigDecimal) query.uniqueResult();
		return big.intValue();
	}
	
	//查看当前页的用户
	@SuppressWarnings("unchecked")
	public List<Account> findCurrentPageUsers(PageBean page){
		Session session = getSession();
		Query query = session.createQuery("from Account where role.rid=0");
		query.setFirstResult(page.getStart());
		query.setMaxResults(page.getPagesize());
		session.clear();
		return query.list();
	}
	
	//查询已冻结用户总数
	public int findFreezerCount(){
		Session session = getSession();
		Query query = session.createSQLQuery("select count(*) from Account where sid=1 and rid=0");
		BigDecimal big = (BigDecimal) query.uniqueResult();
		return big.intValue();
	}
	// 查询当前页已冻结账户
	@SuppressWarnings("unchecked")
	public List<Account> findAllUserFreeze(PageBean page) {
		Session session = getSession();
		Query query = session.createQuery("from Account where status.sid=1 and role.rid=0");
		query.setFirstResult(page.getStart());
		query.setMaxResults(page.getPagesize());
		session.clear();
		return query.list();
	}
	//查询已启用用户总数
	public int findSuCount() {
		Session session = getSession();
		Query query = session.createSQLQuery("select count(*) from Account where sid=0 and rid=0");
		BigDecimal big = (BigDecimal) query.uniqueResult();
		return big.intValue();
	}
	//查询当前页已启动账户
	@SuppressWarnings("unchecked")
	public List<Account> findAllUserSu(PageBean page){
		Session session = getSession();
		Query query = session.createQuery("from Account where status.sid=0 and role.rid=0");
		query.setFirstResult(page.getStart());
		query.setMaxResults(page.getPagesize());
		System.out.println("page.getStrat"+page.getStart());
		System.out.println("page.getPagesize"+page.getPagesize());
		System.out.println("page.getEnd"+page.getEnd());
		session.clear();
		return  query.list();
	}
	//查询个人交易记录条数
	public Integer findAllTransactionLogCount(String username){
		Session session=getSession();
	  Query query=session.createSQLQuery("select count(*) from alltransaction where myaccount=?");
	  query.setParameter(0, username);
	 BigDecimal big=(BigDecimal) query.uniqueResult();
	 session.clear();
	 //session.close();
		return big.intValue();
	}
	//返回当前页面个人交易记录
	@SuppressWarnings("unchecked")
	public List<TransactionLog> findTransactionLogPage(PageBean page,String username){
		Session session=getSession();
		Query query=getSession().createQuery("from AllTransaction where myAccount=? order by datetime desc");
		query.setParameter(0, username);
		query.setFirstResult(page.getStart());
		query.setMaxResults(page.getPagesize());
		session.clear();
		//session.close();
		return query.list();
	}
	
	//下载个人交易记录
	@SuppressWarnings("unchecked")
	public List<AllTransaction> findTransactionLog(String username){
		Session session=getSession();
		Query query=getSession().createQuery("from AllTransaction where myAccount=? order by datetime desc");
		query.setParameter(0, username);
		session.clear();
		//session.close();
		return query.list();
	}

	//查询个人交易记录条数按时间查询
		public Integer findAllTransactionLogCountByDatetime(String username,Date starttime,Date endtime){
			Session session=getSession();
		  Query query=session.createQuery("select count(*) from AllTransaction where myaccount=? and datetime between ? and ?");
		  query.setParameter(0, username);
		  query.setParameter(1, starttime);
		   query.setParameter(2, endtime);
		  Long big=(Long) query.uniqueResult();
		 session.clear();
		 //session.close();
			return big.intValue();
		}
		//返回当前页面个人交易记录按时间查询
		@SuppressWarnings("unchecked")
		public List<TransactionLog> findTransactionLogPageByDatetime(PageBean page,String username,Date starttime,Date endtime){
			Session session=getSession();
			Query query=getSession().createQuery("from AllTransaction where myAccount=? and datetime between ? and ? order by datetime desc");
			query.setParameter(0, username);
		    query.setParameter(1, starttime);
		    query.setParameter(2, endtime);
			query.setFirstResult(page.getStart());
			query.setMaxResults(page.getPagesize());
			session.clear();
			//session.close();
			return query.list();
		}
		//下载时间段
		@SuppressWarnings("unchecked")
		public List<AllTransaction> findTransactionLogByDatetime(String username,Date starttime,Date endtime){
			Session session=getSession();
			Query query=getSession().createQuery("from AllTransaction where myAccount=? and datetime between ? and ? order by datetime desc");
			query.setParameter(0, username);
			query.setParameter(1, starttime);
			query.setParameter(2, endtime);
			session.clear();
			//session.close();
			return query.list();
		}
		
	//查询系统交易条数
	public Integer findAllPayTransactionLogCount(){
		Session session=getSession();
		Query query=session.createSQLQuery("select count(*) from PayTransactionLog");
		BigDecimal big=(BigDecimal) query.uniqueResult();
		session.clear();
		//session.close();
		return big.intValue();
	}
	 //返回当前系统页面交易记录
	@SuppressWarnings("unchecked")
	public List<PayTransactionLog> findPayTransactionLogPage(PageBean page){
		Session session=getSession();
		Query query=getSession().createQuery("from PayTransactionLog order by datetime desc");
		query.setFirstResult(page.getStart());
		query.setMaxResults(page.getPagesize());
		session.clear();
		//session.close();
		return query.list();
	}
	
	//删除普通用户账户
	public void deleteAccout(int accountid){
		Session session=getSession();
		Account account=(Account) session.get(Account.class, accountid);
		session.delete(account);
		session.beginTransaction().commit();
		
	}
	
	//查询个人充值,提现,转账总金额
	public double selectSumMoney(String username,int typeid){
		Query query=getSession().createSQLQuery("select nvl(sum(tr_money),0) from alltransaction where myaccount=? and typeid=?");
		query.setParameter(0, username);
		query.setParameter(1, typeid);
		BigDecimal big=(BigDecimal) query.uniqueResult();
		return Math.abs(big.doubleValue());
	}
	
}