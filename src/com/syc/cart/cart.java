package com.syc.cart;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.syc.product.product;
import com.syc.product.productManager;

public class cart {
	private List<cartitem> cartitems=new ArrayList<cartitem>();

	public List<cartitem> getCartitems() {
		return cartitems;
	}
	
	public void addcartitem(int id,int count){
		cartitem item=null;
		for(Iterator<cartitem> iterator=cartitems.iterator();iterator.hasNext();){
			item=iterator.next();
			if(item.getProductid()==id){
				item.setCount(item.getCount()+count);
				return;
			}
		}
		product p=productManager.getInstance().loadbyid(id);
		if(p.getId()!=0){
		item=new cartitem();
		item.setCount(count);
		item.setName(p.getName());
		item.setPrice(p.getMemberprice());
		item.setProductid(p.getId());
		cartitems.add(item);
		}
	}
	
	public double gettotalprice() {
		double price=0;
		cartitem item=null;
		for(Iterator<cartitem> iterator=cartitems.iterator();iterator.hasNext();){
			item=iterator.next();
			price+=item.totalprice();
		}
		return price;		
	}
	
	public int productcount() {
		int i=0;
		for(Iterator<cartitem> iterator=cartitems.iterator();iterator.hasNext();){
			iterator.next();
			i++;
		}
		return i;		
	}
	
	public void deleteproduct(int id){
		for(int i=0;i<cartitems.size();i++){
			if(cartitems.get(i).getProductid()==id){
				cartitems.remove(i);
			}
		}
	}
	
	public void deleteallproducts(){
		cartitems.clear();
		
	}
	
	public void deleteproduct(){
		for(int i=0;i<cartitems.size();i++){
			if(cartitems.get(i).getCount()<1){
				cartitems.remove(i);
			}
		}
	}

}
