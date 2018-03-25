package com.syc.category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import com.syc.java.DB;

public class CategoryDAO {
	public static void save(Category c){
	Connection conn=null;
	PreparedStatement pstate=null;
	try {
		conn=DB.getConnection();
		String sql="insert into category value (null,?,?,?,?,?)";
		pstate=DB.getPreparedStatement(conn, sql);
		pstate.setString(1, c.getName());
		pstate.setString(2, c.getDescription());
		pstate.setInt(3, c.getPid());
		pstate.setInt(4, c.isLeaf()?0:1);
		pstate.setInt(5, c.getGrade());
		pstate.executeUpdate();
	} catch (SQLException e) {
		e.printStackTrace();
	}finally{
		DB.closeStatement(pstate);
		DB.closeConnection(conn);
	}
	}
	
	
	public static void getCategories(List<Category> categories,int id){
		Connection conn=null;
		try {
			conn=DB.getConnection();
			getCategories(conn,categories,id);
		}finally{
			DB.closeConnection(conn);
		}
		
		
	}
	public static void getCategories(Connection conn,List<Category> categories,int id){
		Statement state=null;
		ResultSet reSet=null;
		try {
			String sql="select * from category where pid="+id;
			state=DB.getStatement(conn);
			reSet=DB.executeQuery(state, sql);
			while(reSet.next()){
				Category c=new Category();
				c.setId(reSet.getInt("id"));
				c.setDescription(reSet.getString("description"));
				c.setGrade(reSet.getInt("grade"));
				c.setLeaf(reSet.getInt("isleaf")==0?true:false);
				c.setPid(reSet.getInt("pid"));
				c.setName(reSet.getString("name"));
				categories.add(c);
				if(!c.isLeaf()){
					getCategories(conn,categories,reSet.getInt("id"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.closeResultSet(reSet);
			DB.closeStatement(state);
		}
	}
	
	public static void savechild(int pid,String name,String description){
			Connection conn=null;
			Statement state=null;
			PreparedStatement pstate=null;
			ResultSet reSet=null;
			try {
				conn=DB.getConnection();
				conn.setAutoCommit(false);
				state=DB.getStatement(conn);
				reSet=DB.executeQuery(state, "select * from category where id="+pid);
				reSet.next();
				String sql="insert into category value (null,?,?,?,?,?)";
				pstate=DB.getPreparedStatement(conn, sql);
				pstate.setString(1, name);
				pstate.setString(2, description);
				pstate.setInt(3, pid);
				pstate.setInt(4, 0);
				pstate.setInt(5, reSet.getInt("grade")+1);
				state.executeUpdate("update category set isleaf=1 where id="+pid);
				pstate.executeUpdate();
				conn.commit();
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				try {
					conn.rollback();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
				e.printStackTrace();
			}finally{
				DB.closeResultSet(reSet);
				DB.closeStatement(state);
				DB.closeStatement(pstate);
				DB.closeConnection(conn);
			}
		
	}

	public static void deleteCategory(int id, int pid) {
		Connection conn=null;
		Statement state=null;
		ResultSet reSet=null;
		try {
			conn=DB.getConnection();
			conn.setAutoCommit(false);
			
			state=DB.getStatement(conn);
			delete(conn,id);
			reSet=DB.executeQuery(state, "select count(*) from category where pid="+pid);
			reSet.next();
			int count=reSet.getInt(1);
			if(count<=0){
				state.executeUpdate("update category set isleaf=0 where id="+pid);
			}
			
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}finally{
			DB.closeResultSet(reSet);
			DB.closeStatement(state);
			DB.closeConnection(conn);
		}		
	}
	
	public static void delete(Connection conn,int id) {
		Statement state1=null;
		Statement state2=null;
		ResultSet reSet=null;
		try {
			conn=DB.getConnection();
			state1=DB.getStatement(conn);
			state2=DB.getStatement(conn);
			reSet=DB.executeQuery(state2, "select * from category where pid="+id);
			state1.executeUpdate("delete from category where id="+id);
			while(reSet.next()){
				delete(conn, reSet.getInt("id"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.closeResultSet(reSet);
			DB.closeStatement(state1);
			DB.closeStatement(state2);
		}		
	}

}
