package com.syc.product;

import java.sql.Timestamp;
import java.util.List;

public interface productDAO {
	public List<product> getProducts();
	
	public List<product> getProducts(int pageNo,int pageSize);
	
	public int findproducts(List<product> products,int[] categoryid, String name,
			int normalhighprice, int normallowprice, int memberhighprice,
			int memberlowprice, Timestamp ts,int pageNo,int pagesize);
	
	public List<product> findProducts(String name);
	
	public boolean deleteproductbycategoryid(int categoryid);
	
	public boolean deleteproductbyid(int id);
	
	public boolean updateproduct(product p);

	public boolean addproduct(product p);

	public List<product> getrecentproducts(int count);

	public product loadbyid(int id);
	
	public void receiveimage(int id,String url);
}
