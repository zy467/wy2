package action;

import java.awt.image.BufferedImage;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;

import com.opensymphony.xwork2.ActionSupport;

import dao.DateBase;
import entity.Account;
import entity.Admin;
import entity.AllTransaction;
import entity.Bound;
import entity.PayTransactionLog;
import entity.Personinfo;
import entity.Role;
import entity.Status;
import entity.TransactionLog;
import entity.TransactionType;
import javabean.PageBean;
import net.sf.json.JSONObject;
import util.ExcelUtil;
import util.ImageUtil;
import util.NoteUtil;
import util.PlotUtil;

public class RequestAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	DateBase dateBase;
	Account a;
	Personinfo p;
	List<TransactionLog> t;
	Object obj;
	List<Account> list;
	TransactionLog tr;
	Admin adm;
	Set<Account> set;
	Collection<Account> c;
	Bound b;
	PayTransactionLog pay;
	List<PayTransactionLog> record;
	PageBean page;
	String returnType;
	Date starttime;
	Date endtime;
	InputStream excelStream;  //输出流变量  
    String excelFileName; //下载文件名

	public HttpServletResponse getResponse() {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/json");
		response.setCharacterEncoding("utf-8");
		return response;
	}

	/* 与支付端交互 */
	// 绑卡
	public void cardBound() {
		try {
			JSONObject jsonObject = new JSONObject();
			PrintWriter out = getResponse().getWriter();
			if (this.b.getPaymentid() != 100000 && this.b.getPaymentid() != 200000) {
				jsonObject.put("verify", "error payment");
			} else {
			Account a = dateBase.findAccountByCardidandrealnameandpid(this.p.getCardid(),new String(this.p.getRealname().getBytes("iso-8859-1"), "utf-8"), this.p.getPid());
	//			Account a = dateBase.findAccountByCardidandrealnameandpid(this.p.getCardid(),this.p.getRealname(), this.p.getPid());
				Bound b = new Bound(this.b.getBid(), this.b.getPaymentid(), a);
				if (a == null) {
					jsonObject.put("verify", "no exist");
				} else {
					if (this.b.getBid() == null) {
						jsonObject.put("verify", "need bid");
					} else {
						if (dateBase.saveBound(b)) {
							jsonObject.put("verify", true);
							jsonObject.put("bid", b.getBid());
						} else {
							jsonObject.put("verify", false);
						}
					}
				}
			}
			System.out.println(jsonObject.toString());
			out.println(jsonObject.toString());
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 提现
	public void putOff() {
		String username;
		PrintWriter out = null;
		JSONObject jsonObject = new JSONObject();
		// 绑卡协议号
		Bound b = dateBase.findBoundByBid(this.b.getBid());
		// 交易类型：支付一、支付二
		TransactionType type = dateBase.getTransactionType(2);
		// 生成订单状态为0的记录:0表示还未进行加钱减钱
		PayTransactionLog pt = new PayTransactionLog(this.pay.getTr_money(), this.pay.getDatetime(), type,
				this.pay.getPaymentsn(), b);
		if (!dateBase.savePayTransactionLog(pt)) {
			jsonObject.put("verify", false);
		} else {
			try {
				out = getResponse().getWriter();
				Account yonghu = b.getAccount();
				if ((this.pay.getPaymentsn()).charAt(0) == '1') {
					username = "zf1";
				} else {
					System.out.println((this.pay.getPaymentsn()).charAt(0));
					username = "zf2";
				}
				Account qiye = dateBase.findAccountByUsername(username);

				if (dateBase.updateBalance(qiye, yonghu, this.pay.getTr_money())) {
					if (dateBase.updateOrderStatus(pt)) {
						jsonObject.put("paymentsn", pay.getPaymentsn());
						jsonObject.put("verify", "success");

					} else {
						jsonObject.put("paymentsn", pay.getPaymentsn());
						jsonObject.put("verify", false);
					}
				} else {
					jsonObject.put("verify", false);
				}

				out.println(jsonObject.toString());
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				out.flush();
				out.close();
			}
		}
	}

	// 快捷支付
	public void quickPay() {
		TransactionType type = new TransactionType(0, "quickPay");
		Bound b = dateBase.findBoundByBid(this.b.getBid());
		Account paymentAccount;
		if (b.getPaymentid() == 100000) {
			paymentAccount = dateBase.findAccountByUsername("zf1");
		} else {
			paymentAccount = dateBase.findAccountByUsername("zf2");
		}
		try {
			JSONObject jsonObject = new JSONObject();
			PrintWriter out = getResponse().getWriter();
			PayTransactionLog pay = new PayTransactionLog(-this.pay.getTr_money(), this.pay.getDatetime(), type,
					this.pay.getPaymentsn(), b);
			Object i = dateBase.savePayTransaction(pay);
			if (b.getAccount().getStatus().getSid() == 1) {
				jsonObject.put("paymentsn", this.pay.getPaymentsn());
				jsonObject.put("verify", "the account is frozen");
			} else {
				if (i != null) {
					System.out.println(i);
					if ((this.pay.getTr_money()) > b.getAccount().getBalance()) {
						jsonObject.put("verify", "insufficient balance");
					} else {
						Account a = b.getAccount();
						a.setBalance(b.getAccount().getBalance() - this.pay.getTr_money());
						paymentAccount.setBalance(paymentAccount.getBalance() + this.pay.getTr_money());
						if (dateBase.updateAccountBalance(a, paymentAccount)) {
							PayTransactionLog pay1 = dateBase.findPayTransactionLog((Integer) i);
							pay1.setOrderstatus(1);
							dateBase.updatePayTransaction(pay1);
							jsonObject.put("paymentsn", pay1.getPaymentsn());
							jsonObject.put("verify", "success");
						} else {
							jsonObject.put("verify", "failed");
						}
					}
				} else {
					jsonObject.put("paymentsn", this.pay.getPaymentsn());
					jsonObject.put("verify", "order generation failed");
				}
			}

			System.out.println(jsonObject.toString());
			out.println(jsonObject.toString());
			out.flush();
			out.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 退款
	public void refund() {
		Bound b = dateBase.findBoundByBid(this.b.getBid());
		PayTransactionLog pay = dateBase.findPayTransactionLogByPaymentsn(this.pay.getPaymentsn());
		Account paymentAccount;
		if (b.getPaymentid() == 100000) {
			paymentAccount = dateBase.findAccountByUsername("zf1");
		} else {
			paymentAccount = dateBase.findAccountByUsername("zf2");
		}
		try {
			JSONObject jsonObject = new JSONObject();
			PrintWriter out = getResponse().getWriter();
			// Object i=pay.getTrid();
			if (pay != null) {
				if ((pay.getOrderstatus()) != 1||pay.getType().getTypeid()==2) {
					jsonObject.put("paymentsn", this.pay.getPaymentsn());
					jsonObject.put("verify", " no payment");
				} else {
					Account a = b.getAccount();
					a.setBalance(b.getAccount().getBalance() + this.pay.getTr_money());
					paymentAccount.setBalance(paymentAccount.getBalance() - this.pay.getTr_money());
					if (dateBase.updateAccountBalance(a, paymentAccount)) {
						Object i = pay.getTrid();
						PayTransactionLog pay1 = dateBase.findPayTransactionLog((Integer) i);
						pay1.setOrderstatus(3);
						dateBase.updatePayTransaction(pay1);
						jsonObject.put("paymentsn", this.pay.getPaymentsn());
						jsonObject.put("verify", "success");
					} else {
						jsonObject.put("paymentsn", this.pay.getPaymentsn());
						jsonObject.put("verify", "failed");
					}
				}
			} else {
				jsonObject.put("paymentsn", this.pay.getPaymentsn());
				jsonObject.put("verify", "payment no exist");
			}
			System.out.println(jsonObject.toString());
			out.println(jsonObject.toString());
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
	}

	// 调账
	@SuppressWarnings("static-access")
	public void adjustment() {
		Date enddatetime = this.pay.getDatetime();
		Calendar cld = Calendar.getInstance();
		cld.setTime(enddatetime);
		cld.add(cld.HOUR, -1);
		Date begindatetime = cld.getTime();
		String sn;
		if (this.b.getPaymentid() == 100000) {
			sn = "1%";
		} else {
			sn = "2%";
		}
		List<Object[]> l = dateBase.findPayTransactionLog(begindatetime, enddatetime, sn);
		JSONObject jsonObject = new JSONObject();
		try {
			PrintWriter out = getResponse().getWriter();
			for (int i = 0; i < l.size(); i++) {

				Date d = (Date) l.get(i)[6];
				DateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String s = f.format(d);
				(l.get(i))[6] = s;
			}
			jsonObject.put("tansactionlog", l);
			out.println(jsonObject.toString());
			out.flush();
			out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/* 主页 */
	// 注册
	// 验证用户名
	public void verify() {
		try {
			JSONObject jsonObject = new JSONObject();
			PrintWriter out = getResponse().getWriter();
			// 验证用户名
			if (this.a.getUsername().equals("")) {
				jsonObject.put("verify", "不能为空");// 不能为空
			} else {
				Account a = dateBase.findAccountByUsername(this.a.getUsername());
				if (a == null) {
					jsonObject.put("verify", "可以使用！");
				} else {
					jsonObject.put("verify", "用户名已存在！");
				}
			}

			System.out.println(jsonObject.toString());
			out.println(jsonObject.toString());
			out.flush();
			out.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	// 验证证件号码
	public void qwe() {
		try {
			JSONObject jsonObject = new JSONObject();
			PrintWriter out = getResponse().getWriter();
			String reg = "(\\d{14}[0-9a-zA-Z])|(\\d{17}[0-9a-zA-Z])";
			// 验证身份证号
			if (this.a.getPersoninfo().getPid().equals("")) {
				jsonObject.put("qwe", "can't be null");
			} else if (!this.a.getPersoninfo().getPid().matches(reg)) {
				jsonObject.put("qwe", "证件号码有误(提示18位纯数字或17位纯数字+1位大写英文字母)");
			} else {
				Account a = dateBase.findPersoninfoByPid(this.a.getPersoninfo().getPid());
				if (a == null) {
					jsonObject.put("qwe", "可以使用!");
				} else {
					jsonObject.put("qwe", "身份证已被注册");
				}
			}
			System.out.println(jsonObject.toString());
			out.println(jsonObject.toString());
			out.flush();
			out.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	// 注册界面
	public String add() throws Exception {
		Role r = new Role();
		Status s = new Status();
		Account a = new Account(this.a.getUsername(), NoteUtil.md5(this.a.getPassword() + "asdfghjkl"),
				this.a.getBalance(), s, r);
		Personinfo p = new Personinfo(this.a.getPersoninfo().getPid(), a, this.a.getPersoninfo().getRealname(),
				this.a.getPersoninfo().getAge(), this.a.getPersoninfo().getSex(), this.a.getPersoninfo().getCardid(),
				this.a.getPersoninfo().getTelephone());

		if (dateBase.insertAccountAndPersonInfo(p)) {
            getRequest().setAttribute("successmessage", "注册成功,请登录");
			return "login";
		} else {

			getRequest().setAttribute("registermessage", "error");
			return "register";
		}
	}

	// 管理员登录
	public String alogin() throws Exception {
		Admin adm = dateBase.findAdminByUsername(this.adm.getUsername());

		if (adm == null) {
			getRequest().setAttribute("adm", "账号密码不能为空！");
			return "alogin";
		} else if (NoteUtil.md5(this.adm.getPassword() + "asdfghjkl").equals(adm.getPassword())) {
			getSession().setAttribute("adm", adm);
			return "asuccess";
		} else {
			getRequest().setAttribute("adm", "密码输入不正确！");
			return "alogin";
		}
	}

	// 验证码
	public void createImg() throws IOException {
		// 生成验证码及图片
		Object[] objs = ImageUtil.createImage();
		// 将验证码存入session
		String imgCode = (String) objs[0];
		// System.out.println("的十分骄傲的师傅介绍的来看："+imgCode);
		getSession().setAttribute("imgCode", imgCode);
		// 将图片输出给浏览器
		BufferedImage img = (BufferedImage) objs[1];
		// 该输出流由tomcat创建，目标是浏览器
		OutputStream os = getResponse().getOutputStream();
		ImageIO.write(img, "jpeg", os);
		os.close();
	}

	// 用户登录
	public void login() throws Exception {
		JSONObject jsonObject = new JSONObject();
		PrintWriter out = getResponse().getWriter();
		Account a = dateBase.findAccountByUsername(this.a.getUsername());
		// 检查验证码
		String code = getRequest().getParameter("code");
		String imgcode = (String) getSession().getAttribute("imgCode");
		// System.out.println("asda："+code+imgcode);
		if (!imgcode.equalsIgnoreCase(code) || code == null || code.equals("")) {
			jsonObject.put("loginmsg", "验证码错误");
			// getRequest().setAttribute("loginmsg", "验证码错误");
			
		} else if (a == null) {
			//getRequest().setAttribute("loginmsg", "用户不存在");
			jsonObject.put("loginmsg", "用户不存在");
			//return "login";
		} else if (NoteUtil.md5(this.a.getPassword() + "asdfghjkl").equals(a.getPassword())) {
			getSession().setAttribute("a", a);
			System.out.println(a.getPassword());
			System.out.println(a.getPersoninfo().getRealname());
			jsonObject.put("loginmsg", "success");
			//return SUCCESS;
		} else {
			//getRequest().setAttribute("loginmsg", "密码错误");
			jsonObject.put("loginmsg", "密码错误");
			//return LOGIN;
		}
		out.println(jsonObject.toString());
		out.flush();
		out.close();
	}

	// 用户修改密码
	public String userMPwd() throws Exception {
		String username = ((Account) getSession().getAttribute("a")).getUsername();
		String password = this.a.getPassword();
		int i = dateBase.updateAccountPassword(NoteUtil.md5(password + "asdfghjkl"), username);
		if (i == 0) {
			getRequest().setAttribute("passwordmsg", "密码修改失败");
			return "userModifyPassword";
		} else {
			getRequest().setAttribute("passwordmsg", "密码修改成功，请重新登录！");
			return "login";
		}
	}

	// 用户修改密码之验证旧密码ajax
	public void oldpwd() throws Exception {
		try {
			JSONObject jsonObject = new JSONObject();
			PrintWriter out = getResponse().getWriter();
			String password = ((Account) getSession().getAttribute("a")).getPassword();
			if (password.equals(NoteUtil.md5(this.a.getPassword() + "asdfghjkl"))) {
				jsonObject.put("verify", true);
			} else {
				jsonObject.put("verfiy", false);
			}
			out.println(jsonObject);
			out.flush();
			out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 管理员旧密码验证
	public void adminOldpwd() throws Exception {
		try {
			JSONObject jsonObject = new JSONObject();
			PrintWriter out = getResponse().getWriter();
			String password = ((Admin) getSession().getAttribute("adm")).getPassword();
			if (password.equals(NoteUtil.md5(this.adm.getPassword() + "asdfghjkl"))) {
				jsonObject.put("verify", true);
			} else {
				jsonObject.put("verfiy", false);
			}
			out.println(jsonObject);
			out.flush();
			out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 管理员修改密码
	public String adminModifyPwd() throws Exception {
		String username = ((Admin) getSession().getAttribute("adm")).getUsername();
		String password = this.adm.getPassword();
		int i = dateBase.updateAdminPassword(NoteUtil.md5(password + "asdfghjkl"), username);
		if (i == 0) {
			getRequest().setAttribute("adm", "密码修改失败");
			return "adminModifyPassword";
		} else {
			getRequest().setAttribute("adm", "密码修改成功，请重新登录！");
			return "alogin";
		}
	}

	// 管理员删除用户账户
	public String adminDeleteAccout() throws Exception {
		dateBase.deleteAccout(this.a.getAccountid());
		if ("allAccount".equals(returnType)) {
			return "zjb";
		} else if ("su".equals(returnType)) {
			return "zyp";
		} else {
			return "zhj";
		}
	}

	/*
	 * //冻结 public String adminFreeze() throws Exception{
	 * dateBase.deleteAccout(this.a.getAccountid()); return "freeze"; } //启用
	 * public String adminSu() throws Exception{
	 * dateBase.deleteAccout(this.a.getAccountid()); return "startUsing"; }
	 */
	// 查询交易记录
	public String findAllTransactionLog() {
		Account account = ((Account) getSession().getAttribute("a"));
		this.page.setTotalrecord(dateBase.findAllTransactionLogCount(account.getUsername()));
		t = dateBase.findTransactionLogPage(page, account.getUsername());
		return "userCheckTransaction";
	}
     //下载所有交易记录excel
	public String downloadAllTransactionLog() throws Exception{
		Account account = ((Account) getSession().getAttribute("a"));
		List<AllTransaction> list = dateBase.findTransactionLog(account.getUsername());
		excelStream=ExcelUtil.createWorkBook(list);
		excelFileName="alltransaction.xlsx";
		return "downloadExcel";
	}
    //下载时间段交易记录excel
	public String downloadAllTransactionLogByDatetime() throws Exception{
		Account account = ((Account) getSession().getAttribute("a"));
		List<AllTransaction> list = dateBase.findTransactionLogByDatetime(account.getUsername(), starttime, endtime);
		excelStream=ExcelUtil.createWorkBook(list);
		excelFileName=starttime.toString()+"--"+endtime.toString()+"transaction.xlsx";
		return "downloadExcel";
	}
	
	// 查询个人信息
	public String findpersoninfo() {
		Account account = dateBase.findAccountByUsername(((Account) getSession().getAttribute("a")).getUsername());
		p = account.getPersoninfo();
		return "userCheckInformation";
	}

	/* 分页查询 */
	// 查询系统支付提现交易记录
	public String findAllSystemRecord() {
		/*
		 * record = dateBase.findAllRecord();
		 * System.out.println("adad::"+record);
		 */
		int payCount = dateBase.findAllPayTransactionLogCount();
		this.page.setTotalrecord(payCount);// 设置pageBean
		record = dateBase.findPayTransactionLogPage(page);
		return "systemRecord";
	}

	// 查询所有账户
	public String findAllAccount() {
		// 查询数据库里的用户数量
		int i = dateBase.findAllUsersCount();
		System.out.println(i);
		// 设置page总记录数
		this.page.setTotalrecord(i);
		// 查看当前页的账户
		System.out.println(page.getStart());
		System.out.println(page.getTotalpage());
		c = dateBase.findCurrentPageUsers(page);
		return "users";
	}

	// 查询已冻结账户
	public String findAllFreeze() {
		int i = dateBase.findFreezerCount();
		System.out.println(i);
		this.page.setTotalrecord(i);
		System.out.println(page.getStart());
		System.out.println(page.getTotalpage());
		c = dateBase.findAllUserFreeze(page);
		return "freeze";
	}

	// 查询已启用账户
	public String findAllSu() {
		int i = dateBase.findSuCount();
		System.out.println(i);
		System.out.println(i);
		this.page.setTotalrecord(i);
		System.out.println(page.getStart());
		System.out.println("激动撒附近啦page.getEnd" + page.getEnd());
		System.out.println(page.getTotalpage());
		c = dateBase.findAllUserSu(page);
		return "startUsing";
	}

	// 修改手机号码
	public void updatePersoninfoByPid() {
		JSONObject jsonObject = new JSONObject();
		try {
			PrintWriter out = getResponse().getWriter();
			Account account = (Account) getSession().getAttribute("a");
			String username = account.getUsername();
			Personinfo p = account.getPersoninfo();
			String pid = p.getPid();
			String telephone = this.p.getTelephone();
			int i = dateBase.updatePersoninfo(telephone, pid);
			if (i == 0) {
				jsonObject.put("verify", "手机号码修改失败，请重新输入");
			} else {
				account = dateBase.findAccountByUsername(username);
				getSession().setAttribute("a", account);
				jsonObject.put("verify", "修改手机号码成功！");
			}
			out.println(jsonObject);
			out.flush();
			out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 修改账户状态
	public String updateStatus() {
		Account account = dateBase.findAccountByUsername(this.a.getUsername());
		int sid = account.getStatus().getSid();
		if (sid == 0) {
			sid = 1;
		} else {
			sid = 0;
		}
		int i = dateBase.updateStatus(sid, this.a.getUsername());
		if (i == 1) {
			getRequest().setAttribute("status", "更改状态成功");
		} else {
			getRequest().setAttribute("status", "更改状态失败！");
		}

		if ("allAccount".equals(returnType)) {
			return "zjb";
		} else if ("su".equals(returnType)) {
			return "zyp";
		} else {
			return "zhj";
		}

	}

	/* 转账 */
	// 用户转账并生成交易记录
	public void userTransaction() throws ParseException {
		// 获取登录用户的账户信息
		JSONObject jsonObject = new JSONObject();
		try {
			PrintWriter out = getResponse().getWriter();
			Account account = dateBase.findAccountByUsername(((Account) getSession().getAttribute("a")).getUsername());
			Double balance = account.getBalance();
			/*
			 * 1.检查是否存在被转账的卡号 2.如果不存在提示"卡号不存在" 3.检查当前用户余额是否充足
			 * 4.如果余额小于转账金额则提示"余额不足" 5.对方卡号加钱，自己卡号减钱
			 */
			Account otherAccount = dateBase.findAccountByCardid(this.tr.getOtherid());
			String mycardid = account.getPersoninfo().getCardid();
			String otherid = this.tr.getOtherid();
			double tr_money = this.tr.getTr_money();
			TransactionType type = dateBase.getTransactionType(1);
			int accountid = account.getAccountid();
			Status status = dateBase.findAccountStatusByAccoundId(accountid);
			int statusId = status.getSid();
			if (statusId == 1) {
				jsonObject.put("verify", "账号已冻结，不能转账！");
			} else if (otherAccount == null) {
				jsonObject.put("verify", "卡号不存在！");
			} else if (balance < this.tr.getTr_money()) {
				jsonObject.put("verify", "余额不足！");
			} else if (dateBase.updateBalance(account, otherAccount, this.tr.getTr_money())) {
				jsonObject.put("verify", "转账成功！");
				/*
				 * 转账成功后生成交易记录
				 * 1.获取信息：trid、otherid、tr_money、type、orderstatus、datetime
				 * 2.调用database的存储记录方法 3.成功后返回结果。
				 */
				TransactionLog localTransactionlog = new TransactionLog(-tr_money, type, otherid, account);
				TransactionLog otherAccountTransactionlog = new TransactionLog(tr_money, type, mycardid, otherAccount);
				dateBase.makeTransactionLog(localTransactionlog);
				dateBase.makeTransactionLog(otherAccountTransactionlog);
			} else {
				jsonObject.put("verify", "转账失败！");
			}
			out.println(jsonObject.toString());
			out.flush();
			out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 挂失
	public void userFreeze() {
		JSONObject jsonObject = new JSONObject();
		try {
			PrintWriter out = getResponse().getWriter();
			Account account = (Account) getSession().getAttribute("a");
			int accountid = account.getAccountid();
			Status status = dateBase.findAccountStatusByAccoundId(accountid);
			int statusid = status.getSid();
			String username = account.getUsername();
			int i = dateBase.userFreeze(username);
			if (statusid == 1) {
				jsonObject.put("verify", "账号已处于冻结状态！");
			} else if (i == 1) {
				jsonObject.put("verify", "挂失成功！");
			} else {
				jsonObject.put("verify", "挂失失败！");
			}
			out.println(jsonObject.toString());
			out.flush();
			out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//生成报表
	public void createPlot() throws Exception{
		Account account = ((Account) getSession().getAttribute("a"));
		double d1=dateBase.selectSumMoney(account.getUsername(), 0);
		double d2=dateBase.selectSumMoney(account.getUsername(), 2);
		double d3=dateBase.selectSumMoney(account.getUsername(), 1);
		 JFreeChart chart=PlotUtil.createPlot(d1,d2,d3);
		OutputStream os = getResponse().getOutputStream();
		ChartUtilities.writeChartAsJPEG(os,chart,950,365);
		os.close();
		
	}
	//时间查询
	public String findUserTransactionByDate() throws Exception{
		Account account = ((Account) getSession().getAttribute("a"));
		this.page.setTotalrecord(dateBase.findAllTransactionLogCountByDatetime(account.getUsername(), starttime, endtime));
		t = dateBase.findTransactionLogPageByDatetime(page, account.getUsername(), starttime, endtime);
		return "userCheckTransaction";

	}
	
	
	/* 跳转界面 */

	public String register() throws Exception {
		return "register";
	}

	// 用户
	// 修改密码
	public String userModifyPassword() throws Exception {
		return "userModifyPassword";
	}

	// 转账
	public String userTransfer() {
		return "userTransfer";
	}

	// 注销
	public String loginout() {
		System.out.println("用户");
		getSession().invalidate();
		getRequest().setAttribute("a", "账户已注销！");
		return "login";
	}

	// 管理员注销
	public String aloginout() {
		System.out.println("管理员");
		getSession().invalidate();
		getRequest().setAttribute("adm", "账户已注销！");
		return "alogin";
	}

	// 主页
	public String toUserIndex() {
		return "success";
	}
	// 管理员

	public String users() {
		return "users";
	}

	public List<PayTransactionLog> getRecord() {
		return record;
	}

	public void setRecord(List<PayTransactionLog> record) {
		this.record = record;
	}

	public String freeze() {
		return "freeze";
	}

	public String toAdminIndex() {
		return "asuccess";
	}

	public String startUsing() {
		return "startUsing";
	}

	public String modifyNotice() {
		return "modifyNotice";
	}

	public String adminModifyPassword() {
		return "adminModifyPassword";
	}
	
	public String toPlot(){
		return "plot";
		
	}

	/* get/set方法 */
	public Admin getAdm() {
		return adm;
	}

	public PayTransactionLog getPay() {
		return pay;
	}

	public void setPay(PayTransactionLog pay) {
		this.pay = pay;
	}

	public void setAdm(Admin adm) {
		this.adm = adm;
	}

	public TransactionLog getTr() {
		return tr;
	}

	public void setTr(TransactionLog tr) {
		this.tr = tr;
	}

	public List<Account> getList() {
		return list;
	}

	public void setList(List<Account> list) {
		this.list = list;
	}

	public List<TransactionLog> getT() {
		return t;
	}

	public void setT(List<TransactionLog> t) {
		this.t = t;
	}

	public DateBase getDateBase() {
		return dateBase;
	}

	public void setDateBase(DateBase dateBase) {
		this.dateBase = dateBase;
	}

	public Account getA() {
		return a;
	}

	public void setA(Account a) {
		this.a = a;
	}

	public Personinfo getP() {
		return p;
	}

	public void setP(Personinfo p) {
		this.p = p;
	}

	public Object getObj() {
		return obj;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}

	public Set<Account> getSet() {
		return set;
	}

	public void setSet(Set<Account> set) {
		this.set = set;
	}

	public Collection<Account> getC() {
		return c;
	}

	public void setC(Collection<Account> c) {
		this.c = c;
	}

	public Bound getB() {
		return b;
	}

	public void setB(Bound b) {
		this.b = b;
	}

	public PageBean getPage() {
		return page;
	}

	public void setPage(PageBean page) {
		this.page = page;
	}

	public HttpServletRequest getRequest() {
		HttpServletRequest request = ServletActionContext.getRequest();
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return request;
	}

	public String getReturnType() {
		return returnType;
	}

	public void setReturnType(String returnType) {
		this.returnType = returnType;
	}


	public Date getStarttime() {
		return starttime;
	}

	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}

	public Date getEndtime() {
		return endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}

	public InputStream getExcelStream() {
		return excelStream;
	}

	public void setExcelStream(InputStream excelStream) {
		this.excelStream = excelStream;
	}

	public String getExcelFileName() {
		return excelFileName;
	}

	public void setExcelFileName(String excelFileName) {
		this.excelFileName = excelFileName;
	}

	public HttpSession getSession() {
		return getRequest().getSession();
	}
}
