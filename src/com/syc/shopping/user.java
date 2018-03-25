package com.syc.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.syc.java.*;

public class user {
	private int id;
	private String username;
	private String password;
	private String mail;
	private Timestamp rdata;
	
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Timestamp getRdata() {
		return rdata;
	}
	public void setRdata(Timestamp rdata) {
		this.rdata = rdata;
	}
	
	public void save(){
		Connection conn=null;
		PreparedStatement pstate=null;
		try {
			conn=DB.getConnection();
			String sql="insert into ruser value (null,?,?,?,?)";
			pstate=DB.getPreparedStatement(conn, sql);
			pstate.setString(1, username);
			pstate.setString(2, password);
			pstate.setString(3, mail);
			pstate.setTimestamp(4, rdata);
			pstate.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.closeStatement(pstate);
			DB.closeConnection(conn);
		}
		}
	
	public static List<user> getUsers(){
		List<user> users=new ArrayList<user>();
		Connection connection=null;
		Statement state=null;
		ResultSet reset=null;
		try {
			connection=DB.getConnection();
			state=DB.getStatement(connection);
			reset=DB.executeQuery(state, "select * from ruser order by id desc");
			while(reset.next()){
				user u=new user();
				u.setId(reset.getInt("id"));
				u.setUsername(reset.getString("username"));
				u.setPassword(reset.getString("password"));
				u.setMail(reset.getString("email"));
				u.setRdata(reset.getTimestamp("rdate"));
				users.add(u);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.closeStatement(state);
			DB.closeConnection(connection);
			DB.closeResultSet(reset);
		}
		return users;
	}
	
	public static void deleteUser(int id){
		Connection connection=null;
		Statement state=null;
		try {
			connection=DB.getConnection();
			state=DB.getStatement(connection);
			state.executeUpdate("delete from ruser where id="+id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.closeStatement(state);
			DB.closeConnection(connection);
		}	
	}

	public static user userExist(String username,String password) throws UserNotFountException, PassNotRightException{
		user u=null;
		Connection conn=null;
		Statement state=null;
		ResultSet rSet=null;
		try{
			String sql="select * from ruser where username='"+username+"'";
			conn=DB.getConnection();
			state=DB.getStatement(conn);
			rSet=DB.executeQuery(state, sql);
			if(!rSet.next()){
				throw new UserNotFountException();
			}else if(!rSet.getString("password").equals(password)){
				throw new PassNotRightException();		
			}else{
				u=new user();
				u.setId(rSet.getInt("id"));
				u.setUsername(rSet.getString("username"));
				u.setPassword(rSet.getString("password"));
				u.setMail(rSet.getString("email"));
				u.setRdata(rSet.getTimestamp("rdate"));		
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.closeResultSet(rSet);
			DB.closeStatement(state);
			DB.closeConnection(conn);
		}
		return u;
	}
	
	public void userUpdate(){
		Connection conn=null;
		PreparedStatement pstate=null;
		try {
			conn=DB.getConnection();
			String sql="update ruser set password = ?, phone = ? where id = ?";
			pstate=DB.getPreparedStatement(conn, sql);
			pstate.setString(1, this.password);
			pstate.setString(2, this.mail);
			pstate.setInt(3, this.id);
			pstate.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.closeStatement(pstate);
			DB.closeConnection(conn);
		}		
	}
	
	public static boolean usernameExist(String username){
		Connection conn=null;
		Statement state=null;
		ResultSet rSet=null;
		try{
			String sql="select * from ruser where username='"+username+"'";
			conn=DB.getConnection();
			state=DB.getStatement(conn);
			rSet=DB.executeQuery(state, sql);
			if(!rSet.next()){
				return false;
			}else{
				return true;
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.closeResultSet(rSet);
			DB.closeStatement(state);
			DB.closeConnection(conn);
		}
		return true;
	}
	
}
