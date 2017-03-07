package interceptor;


import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;

import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;



public class RequestInterceptor extends MethodFilterInterceptor {

	private static final long serialVersionUID = 1L;

	@Override
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> session = ActionContext.getContext().getSession();
		
		if (session.get("a") != null ) {
			String result=invocation.invoke();
			System.out.println(result);
			return result;
			
		} else {
		
			return "interceptor";
		}
		
	}

/*	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		// TODO Auto-generated method stub
		
		Map<String, Object> session = ActionContext.getContext().getSession();
	
		if (session.get("a") != null ) {
			String result=invocation.invoke();
			System.out.println(result);
			return result;
			
		} else {
		
			return "login";
		}

	
		
		
	}	*/

}
