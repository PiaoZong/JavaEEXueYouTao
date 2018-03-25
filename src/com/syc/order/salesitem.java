package com.syc.order;

import com.syc.product.product;
import com.syc.product.productManager;

public class salesitem {
	private int id;
	private int productid;
	private double unitprice;
	private int count;
	private int orderid;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getProductid() {
		return productid;
	}
	public void setProductid(int productid) {
		this.productid = productid;
	}
	public double getUnitprice() {
		return unitprice;
	}
	public void setUnitprice(double unitprice) {
		this.unitprice = unitprice;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getOrderid() {
		return orderid;
	}
	public void setOrderid(int orderid) {
		this.orderid = orderid;
	}
	
	public product loadproductbyid(){
		return productManager.getInstance().loadbyid(productid);
	}
	
	public double totalprice(){
		return count*unitprice;
	}

}
