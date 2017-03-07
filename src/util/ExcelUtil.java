package util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;

import java.io.IOException;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

import entity.AllTransaction;

public class ExcelUtil {
	// 使用POI创建excel工作簿
	@SuppressWarnings("resource")
	public static ByteArrayInputStream createWorkBook(List<AllTransaction> list) throws IOException {
		// 创建excel工作簿
		Workbook wb = new HSSFWorkbook();
		// 创建第一个sheet（页），命名为 new sheet
		Sheet sheet = wb.createSheet("交易记录");
		// Row 行
		// Cell 方格
		// Row 和 Cell 都是从0开始计数的

		Row row0 = sheet.createRow((short)0);
		row0.createCell(0).setCellValue("订单号");
		row0.createCell(1).setCellValue("交易金额");
		row0.createCell(2).setCellValue("对方账户");
		row0.createCell(3).setCellValue("交易类型");
		row0.createCell(4).setCellValue("订单状态");
		row0.createCell(5).setCellValue("交易时间");
		for(int i=0;i<list.size();i++){
			
			// 创建一行，在页sheet上
			Row row = sheet.createRow((short) i+1);
			int orderstatus=list.get(i).getOrderstatus();
			String otherAccount=list.get(i).getOtherAccount();
			String s = "";
             if(orderstatus==0){
				 s="失败";
			}else if(orderstatus==1){
				 s="成功";
			}else if(orderstatus==3){
				 s="退款";
			}
			if("100000".equals(otherAccount)){
				otherAccount="平台一";
			}else if("200000".equals(otherAccount)){
				otherAccount="平台二";
			}
			// 在row行上创建一个方格
			Cell cell = row.createCell(0);
			// 设置方格的显示
			cell.setCellValue(list.get(i).getTrid());

			// Or do it on one line.
		
			row.createCell(1).setCellValue(list.get(i).getTr_money());
			row.createCell(2).setCellValue(otherAccount);
			row.createCell(3).setCellValue(list.get(i).getType().getTypename());
			row.createCell(4).setCellValue(s);
			row.createCell(5).setCellValue(list.get(i).getDatetime().toString());  
		}
		
	

		/*// 创建一个文件 命名为workbook.xls
		FileOutputStream fileOut = new FileOutputStream("D:\\workbook.xlsx");
		// 把上面创建的工作簿输出到文件中
		wb.write(fileOut);
		// 关闭输出流
		fileOut.close();*/
		
		  //第七步，将文件存到流中  
        ByteArrayOutputStream os = new ByteArrayOutputStream();  
        wb.write(os);  
        
        byte[] fileContent = os.toByteArray();  
        ByteArrayInputStream is = new ByteArrayInputStream(fileContent);  
        return is;
        /*private InputStream excelStream;  //输出流变量  
        private String excelFileName; //下载文件名  
      
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
        excelStream = is;             //文件流  
        excelFileName = "report.xls"; //设置下载的文件名  
*/	}

	// 使用POI读入excel工作簿文件
/*	public static void readWorkBook() throws Exception {
		// poi读取excel
		// 创建要读入的文件的输入流
		InputStream inp = new FileInputStream("D:\\workbook.xlsx");

		// 根据上述创建的输入流 创建工作簿对象
		Workbook wb = WorkbookFactory.create(inp);
		// 得到第一页 sheet
		// 页Sheet是从0开始索引的
	    Sheet sheet = wb.getSheetAt(0);
		// 利用foreach循环 遍历sheet中的所有行
		for (Row row : sheet) {
			// 遍历row中的所有方格
			for (Cell cell : row) {
				// 输出方格中的内容，以空格间隔
				System.out.print(cell.toString() + "  ");
			}
			// 每一个行输出之后换行
			System.out.println();
		}
		// 关闭输入流
		inp.close();
	}*/
/*    public static void main(String[] args) throws Exception { 
       
    	//ExcelUtil.createWorkBook();
    	//ExcelUtil.readWorkBook(); 
    } */
}