package com.syc.order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.syc.cart.cartitem;
import com.syc.java.DB;
import com.syc.shopping.user;

public class OrderMysqlDAO {

	public void savaorder(OrderSales order) {
		Connection conn=null;
		PreparedStatement pstate=null;
		PreparedStatement pstateitem=null;
		ResultSet reSet=null;
		try {
			conn=DB.getConnection();
			conn.setAutoCommit(false);
			String sql="insert into salesorder value (null,?,?,?,?,?,?)";
			pstate=DB.getPreparedStatement(conn, sql,true);
			pstate.setInt(1, order.getU().getId());
			pstate.setString(2, order.getAdress());
			pstate.setTimestamp(3, order.getOdate());
			pstate.setDouble(4, order.getStatus());
			pstate.setString(5, order.getPhone());
			pstate.setString(6, order.getName());
			pstate.executeUpdate();
			reSet=pstate.getGeneratedKeys();
			reSet.next();
			int key=reSet.getInt(1);
			
			String salitem="insert into salesitem value (null,?,?,?,?)";
			pstateitem=DB.getPreparedStatement(conn, salitem);
			List<cartitem> cartitems=order.getC().getCartitems();
			for(int i=0;i<cartitems.size();i++){
				cartitem p=cartitems.get(i);
				pstateitem.setInt(1, p.getProductid());
				pstateitem.setDouble(2, p.getPrice());
				pstateitem.setInt(3, p.getCount());
				pstateitem.setInt(4, key);
				pstateitem.executeUpdate();
			}
			conn.commit();
			conn.setAutoCommit(true);
			
		} catch (SQLException e) {
			try {
				conn.setAutoCommit(true);
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}finally{
			DB.closeResultSet(reSet);
			DB.closeStatement(pstateitem);
			DB.closeStatement(pstate);
			DB.closeConnection(conn);
		}
		
	}

	public int getorders(List<OrderSales> orders, int pageno, int pagesize) {
		Connection connection=null;
		Statement state=null;
		ResultSet reset=null;
		ResultSet rSetcount=null;
		int pagecount=0;
		try {
			connection=DB.getConnection();
			state=DB.getStatement(connection);
			rSetcount=DB.executeQuery(state, "select count(*) from salesorder");
			rSetcount.next();
			int count=rSetcount.getInt(1);
			pagecount=count%pagesize==0?count/pagesize:count/pagesize+1;
			if(pageno>pagecount && pagecount!=0){
				pageno=pagecount;
			}
			String sql="select s.id, s.userid, s.address, s.odate, s.status, s.phone, s.name, "
					+"r.id rid, r.username, r.password, r.email, r.rdate"
					+" from salesorder s join ruser r on s.userid=r.id order by odate desc limit "
			+(pageno-1)*pagesize+","+pagesize;
			reset=DB.executeQuery(state, sql);
			while(reset.next()){
				OrderSales order=new OrderSales();
				user u=new user();
				u.setUsername(reset.getString("username"));
				order.setId(reset.getInt("id"));
				order.setOdate(reset.getTimestamp("odate"));
				order.setAdress(reset.getString("address"));
				order.setPhone(reset.getString("phone"));
				order.setStatus(reset.getInt("status"));
				order.setName(reset.getString("name"));
				order.setU(u);
				orders.add(order);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.closeResultSet(reset);
			DB.closeStatement(state);
			DB.closeConnection(connection);
		}
		return pagecount;
	}

	public List<salesitem> loadbyid(int id) {
		List<salesitem> salesitems=new ArrayList<salesitem>();
		Connection connection=null;
		Statement state=null;
		ResultSet reset=null;
		try {
			connection=DB.getConnection();
			state=DB.getStatement(connection);
			reset=DB.executeQuery(state, "select * from salesitem where orderid="+id);
			while(reset.next()){
				salesitem item=new salesitem();
				item.setCount(reset.getInt("count"));
				item.setId(reset.getInt("id"));
				item.setUnitprice(reset.getDouble("unitprice"));
				item.setOrderid(id);
				item.setProductid(reset.getInt("productid"));
				salesitems.add(item);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.closeResultSet(reset);
			DB.closeStatement(state);
			DB.closeConnection(connection);
		}
		return salesitems;
		
	}

}
