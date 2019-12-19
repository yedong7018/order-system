package com.order.service;

import java.util.ArrayList;
import java.util.List;

import com.order.dao.AddressDao;
import com.order.model.Address;

public class AddressService {
	
	private AddressDao addressDao = new AddressDao();
	
	public long add(Address address) {
		return addressDao.insert(address);
	}
	
	public void delete(int id) {
		addressDao.delete(id);
	}
	
	public void update(int id, Address address) {
		addressDao.update(id, address);
	}

	public List<Address> listUserAddr(int uid) {
		List<Address> addrList = addressDao.listByUid(uid);
		return addrList == null ? new ArrayList<>() : addrList;
	}

}
