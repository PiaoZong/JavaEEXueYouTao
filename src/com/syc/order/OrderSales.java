package com.syc.order;

import java.sql.Timestamp;

import com.syc.cart.cart;
import com.syc.shopping.user;

public class OrderSales {
	private int id;
	private user u;
	private Timestamp odate;
	private String name;
	public void setName(String name) {
		this.name = name;
	}
	public Timestamp getOdate() {
		return odate;
	}
	public void setOdate(Timestamp odate) {
		this.odate = odate;
	}
	private String phone;
	private String adress;
	private int status;
	private cart c;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public user getU() {
		return u;
	}
	public void setU(user u) {
		this.u = u;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAdress() {
		return adress;
	}
	public void setAdress(String adress) {
		this.adress = adress;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public cart getC() {
		return c;
	}
	public void setC(cart c) {
		this.c = c;
	}
	public String getName() {
		return name;
	}

}
