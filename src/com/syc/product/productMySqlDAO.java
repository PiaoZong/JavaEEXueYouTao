package com.syc.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.syc.java.DB;

public class productMySqlDAO implements productDAO{
	public List<product> getProducts(){
		List<product> products=new ArrayList<product>();
		Connection connection=null;
		Statement state=null;
		ResultSet reset=null;
		try {
			connection=DB.getConnection();
			state=DB.getStatement(connection);
			reset=DB.executeQuery(state, "select * from product order by id desc");
			while(reset.next()){
				product p=new product();
				p.setId(reset.getInt("id"));
				p.setName(reset.getString("name"));
				p.setDescription(reset.getString("description"));
				p.setNormalprice(reset.getDouble("normalprice"));
				p.setMemberprice(reset.getDouble("memberprice"));
				p.setPdate(reset.getTimestamp("pdate"));
				p.setCategoryid(reset.getInt("categoryid"));
				products.add(p);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.closeResultSet(reset);
			DB.closeStatement(state);
			DB.closeConnection(connection);
		}
		return products;
	}
	
	public List<product> getProducts(int pageNo,int pageSize){
		List<product> products=new ArrayList<product>();
		Connection connection=null;
		Statement state=null;
		ResultSet reset=null;
		try {
			connection=DB.getConnection();
			state=DB.getStatement(connection);
			reset=DB.executeQuery(state, "select * from product order by id desc limit "+ (pageNo-1)*pageSize+","+pageSize);
			while(reset.next()){
				product p=new product();
				p.setId(reset.getInt("id"));
				p.setName(reset.getString("name"));
				p.setDescription(reset.getString("description"));
				p.setNormalprice(reset.getDouble("normalprice"));
				p.setMemberprice(reset.getDouble("memberprice"));
				p.setPdate(reset.getTimestamp("pdate"));
				p.setCategoryid(reset.getInt("categoryid"));
				products.add(p);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.closeStatement(state);
			DB.closeConnection(connection);
			DB.closeResultSet(reset);
		}
		return products;
	}
	
	public int findproducts(List<product> products ,int[] categoryid, String name,
			int normalhighprice, int normallowprice, int memberhighprice,
			int memberlowprice, Timestamp ts,int pageNo,int pagesize) {
		int pagecount=0;
		Connection connection=null;
		Statement state1=null;
		Statement state2=null;
		ResultSet reset=null;
		ResultSet recount=null;
		try {
			connection=DB.getConnection();
			state1=DB.getStatement(connection);
			state2=DB.getStatement(connection);
			String sql="select * from product where 1=1";
			if(categoryid[0]!=0)
				sql+=" and categoryid="+categoryid[0];
			if(name!=null && !name.trim().equals("")){
				sql+=" and name like '%"+name+"%' or description like '%"+name+"%'";
			}
			if(normalhighprice<0){
				sql+=" and normalprice>"+normallowprice;
			}else if(normallowprice>=0){
				sql+=" and normalprice between "+normallowprice+" and "+normalhighprice;
			}
			if(memberhighprice<0){
				sql+=" and memberprice>"+memberlowprice;
			}else if(memberlowprice>=0){
				sql+=" and memberprice between "+memberlowprice+" and "+memberhighprice;
			}
			if(ts!=null){
				sql+=" and pdate like '%"+new SimpleDateFormat("yyyy-MM-dd").format(ts)+"%'";
			}
			String sqlcount=sql.replaceFirst("select \\*", "select count(*)");
			recount=DB.executeQuery(state2, sqlcount);
			recount.next();
			pagecount=(recount.getInt(1)+pagesize-1)/pagesize;
			if(pageNo>pagecount && pagecount!=0){
				pageNo=pagecount;
			}
			sql+=" limit "+(pageNo-1)*pagesize+","+pagesize;
			reset=DB.executeQuery(state1, sql);
			while(reset.next()){
				product p=new product();
				p.setId(reset.getInt("id"));
				p.setName(reset.getString("name"));
				p.setDescription(reset.getString("description"));
				p.setNormalprice(reset.getDouble("normalprice"));
				p.setMemberprice(reset.getDouble("memberprice"));
				p.setPdate(reset.getTimestamp("pdate"));
				p.setCategoryid(reset.getInt("categoryid"));
				products.add(p);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.closeResultSet(recount);
			DB.closeResultSet(reset);
			DB.closeStatement(state1);
			DB.closeStatement(state2);
			DB.closeConnection(connection);
		}
		return pagecount;
	}
	
	public List<product> findProducts(String name){
		return null;
	}
	
	public boolean deleteproductbycategoryid(int categoryid){
		return false;
	}
	
	public boolean deleteproductbyid(int id){
		Connection connection=null;
		Statement state=null;
		try {
			connection=DB.getConnection();
			state=DB.getStatement(connection);
			state.executeUpdate("delete from product where id="+id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.closeStatement(state);
			DB.closeConnection(connection);
		}
		return true;
	}
	
	public boolean updateproduct(product p){
		return false;
	}
	
	public boolean addproduct(product p) {
		Connection conn=null;
		PreparedStatement pstate=null;
		try {
			conn=DB.getConnection();
			String sql="insert into product value (null,?,?,?,?,?,?,?)";
			pstate=DB.getPreparedStatement(conn, sql);
			pstate.setString(1, p.getName());
			pstate.setString(2, p.getDescription());
			pstate.setDouble(3, p.getNormalprice());
			pstate.setDouble(4, p.getMemberprice());
			pstate.setTimestamp(5, p.getPdate());
			pstate.setInt(6, p.getCategoryid());
			pstate.setString(7, "");
			pstate.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}finally{
			DB.closeStatement(pstate);
			DB.closeConnection(conn);
		}
		return true;
	}

	public List<product> getrecentproducts(int count) {
		List<product> products=new ArrayList<product>();
		Connection connection=null;
		Statement state=null;
		ResultSet reset=null;
		try {
			connection=DB.getConnection();
			state=DB.getStatement(connection);
			reset=DB.executeQuery(state, "select * from product order by pdate desc limit 0,"+count);
			while(reset.next()){
				product p=new product();
				p.setId(reset.getInt("id"));
				p.setName(reset.getString("name"));
				p.setDescription(reset.getString("description"));
				p.setNormalprice(reset.getDouble("normalprice"));
				p.setMemberprice(reset.getDouble("memberprice"));
				p.setPdate(reset.getTimestamp("pdate"));
				p.setImadress(reset.getString("imadress"));
				p.setCategoryid(reset.getInt("categoryid"));
				products.add(p);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.closeResultSet(reset);
			DB.closeStatement(state);
			DB.closeConnection(connection);
		}
		return products;
	}

	public product loadbyid(int id) {
		product p=new product();
		Connection connection=null;
		Statement state=null;
		ResultSet reset=null;
		try {
			connection=DB.getConnection();
			state=DB.getStatement(connection);
			reset=DB.executeQuery(state, "select * from product where id="+id);
			while(reset.next()){
				p.setId(reset.getInt("id"));
				p.setName(reset.getString("name"));
				p.setDescription(reset.getString("description"));
				p.setNormalprice(reset.getDouble("normalprice"));
				p.setMemberprice(reset.getDouble("memberprice"));
				p.setPdate(reset.getTimestamp("pdate"));
				p.setCategoryid(reset.getInt("categoryid"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.closeResultSet(reset);
			DB.closeStatement(state);
			DB.closeConnection(connection);
		}
		return p;
	}
	
	public void receiveimage(int id,String url){
		Connection connection=null;
		Statement state=null;
		ResultSet reset=null;
		try {
			connection=DB.getConnection();
			state=DB.getStatement(connection);
			state.executeUpdate("update product set imadress="+"'"+url+"'"+" where id="+id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.closeResultSet(reset);
			DB.closeStatement(state);
			DB.closeConnection(connection);
		}
	}
}
