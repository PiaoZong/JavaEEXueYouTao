package com.syc.category;

import java.util.ArrayList;
import java.util.List;


public class Category {
	int id;
	boolean leaf;
	String name;
	String description;
	int pid;
	int grade;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public boolean isLeaf() {
		return leaf;
	}
	public void setLeaf(boolean leaf) {
		this.leaf = leaf;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	
	public static void addCategory(Category c){
		CategoryDAO.save(c);
	}
	
	public static void addtopCategory(String name,String description){
		Category c=new Category();
		c.setDescription(description);
		c.setPid(0);
		c.setName(name);
		c.setLeaf(true);
		c.setGrade(1);
		addCategory(c);	
	}
	
	public static void addchildCategory(int pid,String name,String description){
		CategoryDAO.savechild(pid, name, description);
	}
	
	public static List<Category> getCategories(){
		List<Category> categories=new ArrayList<Category>();
		CategoryDAO.getCategories(categories, 0);
		return categories;
	}
	
	public static void deleteCategory(int id,int pid){
		CategoryDAO.deleteCategory(id,pid);
	}

}
