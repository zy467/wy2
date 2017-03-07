package javabean;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Map;



import com.opensymphony.xwork2.conversion.impl.DefaultTypeConverter;

public class DateConverter extends DefaultTypeConverter {
	@SuppressWarnings("rawtypes")
	public Object convertValue(Map<String,Object> context, Object value, Class toType) {
		String dataStr = ((String[]) value)[0];
		//if (toType == Date.class) {
			SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try {
				System.out.println(f.parse(dataStr).toString());
				return f.parse(dataStr);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return null;
				
			}
	/*	} else if (toType == String.class) {
			String dataStr = ((Date) value).toString();
			return dataStr;
		}else{
			return null;
		}*/
		

	}
}
