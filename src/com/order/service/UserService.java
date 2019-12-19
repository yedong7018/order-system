package com.order.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.order.dao.CollectionDao;
import com.order.dao.FoodDao;
import com.order.dao.UserDao;
import com.order.exception.UserException;
import com.order.model.Collection;
import com.order.model.Food;
import com.order.model.User;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.extra.mail.MailUtil;
import cn.hutool.setting.dialect.Props;

public class UserService {
	private UserDao userDao = new UserDao();
	private CollectionDao collDao = new CollectionDao();
	private FoodDao foodDao = new FoodDao();

	/**
	 * 注册
	 * @param form
	 */
	public void regist(User form) {
		userDao.insert(form);
	}

	/**
	 * 登录
	 * @param form
	 * @return
	 * @throws UserException
	 */
	public User login(User form) throws UserException {
		User user = userDao.getByUsername(form.getUsername());
		if (user != null && form.getPassword().equals(user.getPassword())) {
			return user;
		} else {
			throw new UserException("用户名或密码错误");
		}
	}

	/**
	 * 找回密码
	 * @param user
	 */
	public void findPwd(User user) {
		// 生成验证码
		user.setCode(IdUtil.fastSimpleUUID());
		// 更新用户的验证码
		userDao.updateCode(user.getId(), user.getCode());
		// 发邮件
		sendResetPwdEmail(user);
	}

	/**
	 * 重置密码
	 * @param user
	 */
	public void resetPwd(User user) {
		userDao.updatePassword(user.getId(), user.getPassword());
		userDao.updateCode(user.getId(), null); // 重置用户的验证码
	}

	/**
	 * 更新密码
	 * @param id
	 * @param password
	 */
	public void updatePwd(int id, String password) {
		userDao.updatePassword(id, password);
	}

	/**
	 * 更新资料
	 * @param user
	 */
	public void updateInfo(User user) {
		userDao.update(user);
	}

	/**
	 * 发送找回密码邮件
	 * @param user
	 */
	public void sendResetPwdEmail(User user) {
		Props props = new Props("mail.setting", "UTF-8");
		String subject = props.getStr("subject");
		String content = props.getStr("content");
		content = StrUtil.format(content, user.getCode());
		MailUtil.send(user.getEmail(), subject, content, true);
	}

	/**
	 * 根据字段和值加载用户
	 * @param field
	 * @param value
	 * @return
	 */
	public User load(String field, Object value) {
		return userDao.getByField(field, value);
	}

	/**
	 * 收藏菜品
	 * @param uid
	 * @param fid
	 */
	public void collect(int uid, int fid) {
		Collection coll = new Collection();
		coll.setUid(uid);
		coll.setFid(fid);
		coll.setAddTime(DateUtil.date());
		collDao.insert(coll);
	}

	/**
	 * 取消收藏菜品
	 * @param uid
	 * @param fid
	 */
	public void discollect(int uid, int fid) {
		collDao.delete(uid, fid);
	}

	/**
	 * 是否收藏某菜品
	 * @param uid
	 * @param fid
	 * @return
	 */
	public boolean isCollected(int uid, int fid) {
		Collection coll = collDao.getByUidAndFid(uid, fid);
		if (coll == null) {
			return false;
		} else {
			return true;
		}
	}

	/**
	 * 加载用户收藏菜品列表
	 * @param uid
	 * @return
	 * @throws SQLException
	 */
	public List<Food> listCollection(int uid) {
		List<Collection> collList = collDao.listByUid(uid);
		
		List<Food> foodList = new ArrayList<>();
		for (Collection coll : collList) {
			Food food = foodDao.getById(coll.getFid());
			foodList.add(food);
		}
		return foodList;
	}

}
