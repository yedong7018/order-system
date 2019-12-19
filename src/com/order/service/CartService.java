package com.order.service;

import java.util.List;

import com.order.dao.CartDao;
import com.order.model.CartItem;

public class CartService {

	private CartDao cartdao = new CartDao();

	public void addCartItem(CartItem item) {
		cartdao.insertCartItem(item);
	}

	public void updateCartItem(CartItem item) {
		cartdao.updateCartItem(item);
	}

	public void deleteCartItem(int uid, int fid) {
		cartdao.deleteCartItem(uid, fid);
	}

	public List<CartItem> getCartItems(int uid) {
		return cartdao.listCartItemByUid(uid);
	}

	public void clear(int uid) {
		cartdao.deleteAllByUid(uid);
	}
}
