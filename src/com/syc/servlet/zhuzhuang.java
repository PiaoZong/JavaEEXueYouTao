package com.syc.servlet;

import java.awt.Color;
import java.awt.Font;
import java.awt.GradientPaint;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.CategoryLabelPositions;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.IntervalMarker;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.ui.Layer;
import org.jfree.ui.RectangleAnchor;
import org.jfree.ui.TextAnchor;

import com.syc.java.DB;

public class zhuzhuang extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public zhuzhuang() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		CategoryDataset data = createDataset();
		  JFreeChart chart = createChart(data);
		  FileOutputStream fos_jpg = null;
		  try {
		   fos_jpg = new FileOutputStream(request.getServletContext().getRealPath("/admin/img/productcount.jpg"));
		   ChartUtilities.writeChartAsJPEG(fos_jpg, 0.9f, chart, 400, 300);// 0.9是图像的品质：0.0-1.0f
		  } finally {
		   try {
		    fos_jpg.close();
		   } catch (Exception e) {
		   }
		  }

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.println("<img src='"+request.getContextPath()+"/admin/img/productcount.jpg"+"'></img>");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.print(this.getClass());
		out.println(", using the POST method");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}
	
	 private static CategoryDataset createDataset() {
			Connection connection=null;
			Statement state=null;
			ResultSet reset=null;
			DefaultCategoryDataset defaultcategorydataset = new DefaultCategoryDataset();
			try {
				connection=DB.getConnection();
				state=DB.getStatement(connection);
				reset=DB.executeQuery(state, "select p.name,sum(item.count) from salesitem item join product p on p.id=item.productid group by p.id");
				while(reset.next()){
					defaultcategorydataset.addValue(reset.getInt(2), "", reset.getString(1));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				DB.closeResultSet(reset);
				DB.closeStatement(state);
				DB.closeConnection(connection);
			}
		  return defaultcategorydataset;
		 
		 /*String series1 = "第一";
		  String series2 = "第二";
		  String series3 = "第三";
		  String category1 = "类型 1";
		  String category2 = "类型 2";
		  String category3 = "类型 3";
		  String category4 = "类型 4";
		  String category5 = "类型 5";
		  DefaultCategoryDataset defaultcategorydataset = new DefaultCategoryDataset();
		  defaultcategorydataset.addValue(1.0D, series1, category1);
		  defaultcategorydataset.addValue(4D, series1, category2);
		  defaultcategorydataset.addValue(3D, series1, category3);
		  defaultcategorydataset.addValue(5D, series1, category4);
		  defaultcategorydataset.addValue(5D, series1, category5);
		  defaultcategorydataset.addValue(5D, series2, category1);
		  defaultcategorydataset.addValue(7D, series2, category2);
		  defaultcategorydataset.addValue(6D, series2, category3);
		  defaultcategorydataset.addValue(10D, series2, category4);
		  defaultcategorydataset.addValue(4D, series2, category5);
		  defaultcategorydataset.addValue(4D, series3, category1);
		  defaultcategorydataset.addValue(3D, series3, category2);
		  defaultcategorydataset.addValue(2D, series3, category3);
		  defaultcategorydataset.addValue(3D, series3, category4);
		  defaultcategorydataset.addValue(6D, series3, category5);
		  return defaultcategorydataset;*/
		 }
	
	 // 2、由ChartFactory 产生 JFreeChart 对象
	 private static JFreeChart createChart(CategoryDataset categorydataset) {
	  JFreeChart jfreechart = ChartFactory.createBarChart("柱状图例", // 图形标题名称
	    "类型",// domain 轴 Lable这里先简单理解为横坐标Lable好了
	    "值", // range 轴 Lable这里也先简单理解为纵坐标Lable好了
	    categorydataset, // dataset
	    PlotOrientation.VERTICAL, // 垂直显示
	    true, // legend?
	    true, // tooltips?
	    false); // URLs?
	  jfreechart.setBackgroundPaint(Color.white); // 设定背景色为白色
	  CategoryPlot categoryplot = jfreechart.getCategoryPlot(); // 获得
	                 // plot：CategoryPlot！！
	  categoryplot.setBackgroundPaint(Color.lightGray); // 设定图表数据显示部分背景色
	  categoryplot.setDomainGridlinePaint(Color.white); // 横坐标网格线白色
	  categoryplot.setDomainGridlinesVisible(true); // 可见
	  categoryplot.setRangeGridlinePaint(Color.white); // 纵坐标网格线白色
	  // 下面两行使纵坐标的最小单位格为整数
	  NumberAxis numberaxis = (NumberAxis) categoryplot.getRangeAxis();
	  numberaxis.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
	  BarRenderer barrenderer = (BarRenderer) categoryplot.getRenderer(); // 获得renderer
	                   // 注意这里是下嗍造型到BarRenderer！！
	  barrenderer.setDrawBarOutline(false); // Bar的外轮廓线不画
	  GradientPaint gradientpaint = new GradientPaint(0.0F, 0.0F, Color.blue,
	    0.0F, 0.0F, new Color(0, 0, 64)); // 设定特定颜色,三种:蓝色,绿色,红色
	  GradientPaint gradientpaint1 = new GradientPaint(0.0F, 0.0F,
	    Color.green, 0.0F, 0.0F, new Color(0, 64, 0));
	  GradientPaint gradientpaint2 = new GradientPaint(0.0F, 0.0F, Color.red,
	    0.0F, 0.0F, new Color(64, 0, 0));
	  // 把颜色加上去
	  barrenderer.setSeriesPaint(0, gradientpaint); // 给series1 Bar设定上面定义的颜色
	  barrenderer.setSeriesPaint(1, gradientpaint1); // 给series2 Bar
	              // 设定上面定义的颜色
	  barrenderer.setSeriesPaint(2, gradientpaint2); // 给series3 Bar
	              // 设定上面定义的颜色
	  CategoryAxis categoryaxis = categoryplot.getDomainAxis(); // 横轴上的
	                 // Lable
	                 // 45度倾斜,可以改成其他
	  categoryaxis.setCategoryLabelPositions(CategoryLabelPositions.UP_45);
	  categoryaxis.setTickLabelFont(new Font("SansSerif", 10, 12));// 设定字体、类型、字号
	  
	  
	  
	  // 一些重要的方法：（增加一块标记）
	  IntervalMarker intervalmarker = new IntervalMarker(4.5D, 7.5D);// 上下限制
	  intervalmarker.setLabel("目标值");// 目标名称
	  intervalmarker.setLabelFont(new Font("SansSerif", 2, 11));// 字体
	  intervalmarker.setLabelAnchor(RectangleAnchor.LEFT);// 标签的位置，左对齐
	  // intervalmarker.setLabelAnchor(RectangleAnchor.BOTTOM_LEFT);//标签的位置，左对齐
	  intervalmarker.setLabelTextAnchor(TextAnchor.CENTER_LEFT);// 整个背景的对齐方式
	  // intervalmarker.setLabelTextAnchor(TextAnchor.BASELINE_LEFT);//整个背景的对齐方式
	  intervalmarker.setPaint(new Color(222, 222, 255, 128));// 颜色
	  categoryplot.addRangeMarker(intervalmarker, Layer.BACKGROUND);// 作为以前图片的背景
	  
	  // 解决中文乱码问题,共要处理这三部分
	  // １、对标题
	  Font font1 = new Font("SansSerif", 10, 20); // 设定字体、类型、字号
	  // Font font1 = new Font("SimSun", 10, 20); //也可以
	  jfreechart.getTitle().setFont(font1); // 标题
	  // ２、对图里面的汉字设定,也就是Ｐlot的设定
	  Font font2 = new Font("SansSerif", 10, 16); // 设定字体、类型、字号
	  categoryplot.getDomainAxis().setLabelFont(font2);// 相当于横轴或理解为X轴
	  categoryplot.getRangeAxis().setLabelFont(font2);// 相当于竖轴理解为Y轴
	  // 3、下面的方块区域是 LegendTitle 对象
	  Font font3 = new Font("SansSerif", 10, 12); // 设定字体、类型、字号
	  jfreechart.getLegend().setItemFont(font3);// 最下方*/
	  return jfreechart;
	 }


}
