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
		   ChartUtilities.writeChartAsJPEG(fos_jpg, 0.9f, chart, 400, 300);// 0.9��ͼ���Ʒ�ʣ�0.0-1.0f
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
		 
		 /*String series1 = "��һ";
		  String series2 = "�ڶ�";
		  String series3 = "����";
		  String category1 = "���� 1";
		  String category2 = "���� 2";
		  String category3 = "���� 3";
		  String category4 = "���� 4";
		  String category5 = "���� 5";
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
	
	 // 2����ChartFactory ���� JFreeChart ����
	 private static JFreeChart createChart(CategoryDataset categorydataset) {
	  JFreeChart jfreechart = ChartFactory.createBarChart("��״ͼ��", // ͼ�α�������
	    "����",// domain �� Lable�����ȼ����Ϊ������Lable����
	    "ֵ", // range �� Lable����Ҳ�ȼ����Ϊ������Lable����
	    categorydataset, // dataset
	    PlotOrientation.VERTICAL, // ��ֱ��ʾ
	    true, // legend?
	    true, // tooltips?
	    false); // URLs?
	  jfreechart.setBackgroundPaint(Color.white); // �趨����ɫΪ��ɫ
	  CategoryPlot categoryplot = jfreechart.getCategoryPlot(); // ���
	                 // plot��CategoryPlot����
	  categoryplot.setBackgroundPaint(Color.lightGray); // �趨ͼ��������ʾ���ֱ���ɫ
	  categoryplot.setDomainGridlinePaint(Color.white); // �����������߰�ɫ
	  categoryplot.setDomainGridlinesVisible(true); // �ɼ�
	  categoryplot.setRangeGridlinePaint(Color.white); // �����������߰�ɫ
	  // ��������ʹ���������С��λ��Ϊ����
	  NumberAxis numberaxis = (NumberAxis) categoryplot.getRangeAxis();
	  numberaxis.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
	  BarRenderer barrenderer = (BarRenderer) categoryplot.getRenderer(); // ���renderer
	                   // ע���������������͵�BarRenderer����
	  barrenderer.setDrawBarOutline(false); // Bar���������߲���
	  GradientPaint gradientpaint = new GradientPaint(0.0F, 0.0F, Color.blue,
	    0.0F, 0.0F, new Color(0, 0, 64)); // �趨�ض���ɫ,����:��ɫ,��ɫ,��ɫ
	  GradientPaint gradientpaint1 = new GradientPaint(0.0F, 0.0F,
	    Color.green, 0.0F, 0.0F, new Color(0, 64, 0));
	  GradientPaint gradientpaint2 = new GradientPaint(0.0F, 0.0F, Color.red,
	    0.0F, 0.0F, new Color(64, 0, 0));
	  // ����ɫ����ȥ
	  barrenderer.setSeriesPaint(0, gradientpaint); // ��series1 Bar�趨���涨�����ɫ
	  barrenderer.setSeriesPaint(1, gradientpaint1); // ��series2 Bar
	              // �趨���涨�����ɫ
	  barrenderer.setSeriesPaint(2, gradientpaint2); // ��series3 Bar
	              // �趨���涨�����ɫ
	  CategoryAxis categoryaxis = categoryplot.getDomainAxis(); // �����ϵ�
	                 // Lable
	                 // 45����б,���Ըĳ�����
	  categoryaxis.setCategoryLabelPositions(CategoryLabelPositions.UP_45);
	  categoryaxis.setTickLabelFont(new Font("SansSerif", 10, 12));// �趨���塢���͡��ֺ�
	  
	  
	  
	  // һЩ��Ҫ�ķ�����������һ���ǣ�
	  IntervalMarker intervalmarker = new IntervalMarker(4.5D, 7.5D);// ��������
	  intervalmarker.setLabel("Ŀ��ֵ");// Ŀ������
	  intervalmarker.setLabelFont(new Font("SansSerif", 2, 11));// ����
	  intervalmarker.setLabelAnchor(RectangleAnchor.LEFT);// ��ǩ��λ�ã������
	  // intervalmarker.setLabelAnchor(RectangleAnchor.BOTTOM_LEFT);//��ǩ��λ�ã������
	  intervalmarker.setLabelTextAnchor(TextAnchor.CENTER_LEFT);// ���������Ķ��뷽ʽ
	  // intervalmarker.setLabelTextAnchor(TextAnchor.BASELINE_LEFT);//���������Ķ��뷽ʽ
	  intervalmarker.setPaint(new Color(222, 222, 255, 128));// ��ɫ
	  categoryplot.addRangeMarker(intervalmarker, Layer.BACKGROUND);// ��Ϊ��ǰͼƬ�ı���
	  
	  // ���������������,��Ҫ������������
	  // �����Ա���
	  Font font1 = new Font("SansSerif", 10, 20); // �趨���塢���͡��ֺ�
	  // Font font1 = new Font("SimSun", 10, 20); //Ҳ����
	  jfreechart.getTitle().setFont(font1); // ����
	  // ������ͼ����ĺ����趨,Ҳ���ǣ�lot���趨
	  Font font2 = new Font("SansSerif", 10, 16); // �趨���塢���͡��ֺ�
	  categoryplot.getDomainAxis().setLabelFont(font2);// �൱�ں�������ΪX��
	  categoryplot.getRangeAxis().setLabelFont(font2);// �൱���������ΪY��
	  // 3������ķ��������� LegendTitle ����
	  Font font3 = new Font("SansSerif", 10, 12); // �趨���塢���͡��ֺ�
	  jfreechart.getLegend().setItemFont(font3);// ���·�*/
	  return jfreechart;
	 }


}
