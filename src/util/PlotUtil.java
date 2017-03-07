package util;


import java.awt.Font;

import org.jfree.chart.ChartColor;
import org.jfree.chart.ChartFactory;

import org.jfree.chart.JFreeChart;
import org.jfree.chart.labels.StandardPieSectionLabelGenerator;
import org.jfree.chart.plot.PiePlot;
//import org.jfree.chart.plot.PiePlot3D;
import org.jfree.data.general.DefaultPieDataset;


public class PlotUtil {
	public static JFreeChart createPlot(double d1,double d2,double d3){
		DefaultPieDataset dpd=new DefaultPieDataset(); //建立一个默认的饼图
        dpd.setValue("充值", d1);  //输入数据
        dpd.setValue("提现", d2);
        dpd.setValue("转账", d3);
              
              
        //可以查具体的API文档,第一个参数是标题，第二个参数是一个数据集，第三个参数表示是否显示Legend，第四个参数表示是否显示提示，第五个参数表示图中是否存在URL
        JFreeChart chart=ChartFactory.createPieChart("个人账单",dpd,true,false,false); 
       
        //解决标题乱码问题
        chart.getTitle().setFont(new Font("宋体", Font.BOLD,26));  
     // 设置总的背景颜色
        chart.setBackgroundImageAlpha(ChartColor.TRANSLUCENT);
      //这句代码解决了标签乱码的问题    
        PiePlot plot = (PiePlot) chart.getPlot();
        plot.setLabelFont(new Font("宋体", Font.BOLD,11));
        //设置标签
        plot.setLabelGenerator(new StandardPieSectionLabelGenerator("{0}({1})/{2}"));     
        //这句代码解决了底部汉字乱码的问题   
        chart.getLegend().setItemFont(new Font("宋体", Font.PLAIN, 12));
        //边框不可见
       // chart.setBorderVisible(false);
        
        //plot.setOutlinePaint(Color.WHITE); // 设置绘图面板外边的填充颜色
        plot.setOutlineVisible(false);
        //plot.setShadowPaint(Color.WHITE); // 设置绘图面板阴影的填充颜色
      
        //设置plot的前景色透明度
        plot.setForegroundAlpha(0.7f);

        //设置plot的背景色透明度
        plot.setBackgroundAlpha(0.0f);
     
        
/*        plot.setStartAngle(150D);  
        //设置方向为”顺时针方向“  
        plot.setDirection(Rotation.CLOCKWISE);  
        //设置透明度，0.5F为半透明，1为不透明，0为全透明  
        plot.setForegroundAlpha(0.5F);*/
		return chart;  
        
        //以图片输出
        /*try {
			ChartUtilities.saveChartAsJPEG(new File("d:/pie.jpg"), chart, 900, 600);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		
	       /* //chart要放在Java容器组件中，ChartFrame继承自java的Jframe类。该第一个参数的数据是放在窗口左上角的，不是正中间的标题。
        ChartFrame chartFrame=new ChartFrame("某组织数据图",chart); 
        chartFrame.pack(); //以合适的大小展现图形
        chartFrame.setVisible(true);//图形是否可见
*/	 
	}
}
