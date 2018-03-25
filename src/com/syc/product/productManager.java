package com.syc.product;

import java.sql.Timestamp;
import java.util.Iterator;
import java.util.List;

public class productManager {

	/*
	 * 单例模式
	 */
	productDAO dao = null;
	private static productManager pm = null;

	static {
		pm = new productManager();
		pm.setDao(new productMySqlDAO());
	}

	private productManager() {

	}

	public static productManager getInstance() {
		return pm;
	}

	public productDAO getDao() {
		return dao;
	}

	public void setDao(productDAO dao) {
		this.dao = dao;
	}

	public List<product> getProducts() {
		return dao.getProducts();
	}

	public List<product> getProducts(int pageNo, int pageSize) {
		return dao.getProducts(pageNo, pageSize);
	}

	public int findproducts(List<product> products,int[] categoryid, String name,
			int normalhighprice, int normallowprice, int memberhighprice,
			int memberlowprice, Timestamp ts, int pageNo, int pagesize) {
		return dao.findproducts(products,categoryid, name, normalhighprice, normallowprice, memberhighprice, memberlowprice, ts,pageNo,pagesize);
	}

	public List<product> findProducts(String name) {
		return null;
	}

	public boolean deleteproductbycategoryid(int categoryid) {
		return false;
	}

	public boolean deleteproductbyid(int id) {
		return dao.deleteproductbyid(id);
	}

	public boolean updateproduct(product p) {
		return false;
	}

	public boolean addproduct(product p) {
		return dao.addproduct(p);
	}

	public int checkpageno(String pageno, int pagesize) {
		int pagenumber;
		int totalpages = totalpages(pagesize);
		try {
			pagenumber = Integer.parseInt(pageno);
			if (pagenumber > totalpages)
				pagenumber = totalpages;
			if (pagenumber < 1)
				pagenumber = 1;
		} catch (NumberFormatException e) {
			pagenumber = 1;
		}
		return pagenumber;
	}

	public int allproductscount(List<product> products) {
		int count = 0;
		for (Iterator<product> iterator = products.iterator(); iterator
				.hasNext();) {
			count = count + 1;
			iterator.next();
		}
		return count;
	}

	/**
	 * @param pagesize
	 *            每页长度
	 * @return 总页数
	 */
	public int totalpages(int pagesize) {
		int count;
		int totalpages;
		count = allproductscount(dao.getProducts());
		totalpages = count % pagesize == 0 ? count / pagesize : count
				/ pagesize + 1;
		return totalpages;
	}

	public int convert(List<product> products,int categoryid, int normalprice, int memberprice,
			String keywords, Timestamp ts, int pageNo, int pagesize) {
		int[] arrayid = new int[1];
		arrayid[0] = categoryid;
		int normalhighprice=0;
		int normallowprice = 0;
		int memberhighprice=0;
		int memberlowprice=0;
		switch (normalprice) {
		case 0:
			normallowprice = -1;
			break;
		case 1:
			normallowprice = 0;
			normalhighprice = 500;
			break;
		case 2:
			normallowprice = 500;
			normalhighprice = 1000;
			break;
		case 3:
			normallowprice = 1000;
			normalhighprice = 1500;
			break;
		case 4:
			normallowprice = 1500;
			normalhighprice = 2000;
			break;
		case 5:
			normallowprice = 2000;
			normalhighprice = 2500;
			break;
		case 6:
			normallowprice = 2500;
			normalhighprice = 3000;
			break;
		case 7:
			normallowprice = 3000;
			normalhighprice = -1;
			break;
		default:
			break;
		}
		switch (memberprice) {
		case 0:
			memberlowprice = -1;
			break;
		case 1:
			memberlowprice = 0;
			memberhighprice = 500;
			break;
		case 2:
			memberlowprice = 500;
			memberhighprice = 1000;
			break;
		case 3:
			memberlowprice = 1000;
			memberhighprice = 1500;
			break;
		case 4:
			memberlowprice = 1500;
			memberhighprice = 2000;
			break;
		case 5:
			memberlowprice = 2000;
			memberhighprice = 2500;
			break;
		case 6:
			memberlowprice = 2500;
			memberhighprice = 3000;
			break;
		case 7:
			memberlowprice = 3000;
			memberhighprice = -1;
			break;
		default:
			break;
		}
		return findproducts(products,arrayid, keywords, normalhighprice, normallowprice, memberhighprice, memberlowprice, ts, pageNo, pagesize);
	}
	
	public List<product> getrecentproducts(int count){
		return dao.getrecentproducts(count);
	}
	
	public product loadbyid(int id){
		return dao.loadbyid(id);		
	}
	
	public void receiveimage(int id,String url){
		dao.receiveimage(id, url);
	}

}
