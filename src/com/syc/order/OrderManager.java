package com.syc.order;

import java.util.List;


public class OrderManager {
	OrderMysqlDAO dao = null;
	private static OrderManager om = null;
	
	
	public OrderMysqlDAO getDao() {
		return dao;
	}

	public void setDao(OrderMysqlDAO dao) {
		this.dao = dao;
	}

	static {
		if(om==null){
		om =new OrderManager();
		om.setDao(new OrderMysqlDAO());
		}
	}

	private OrderManager() {

	}

	public static OrderManager getInstance() {
		return om;
	}
	
	public void  saveorder(OrderSales order) {
		dao.savaorder(order);		
	}
	
	public int getorders(List<OrderSales> orders,int pageno,int pagesize){
		return dao.	getorders(orders,pageno,pagesize);	
	}
	
	public List<salesitem> loadbyid(int id) {
		return dao.loadbyid(id);
		
	}

}
