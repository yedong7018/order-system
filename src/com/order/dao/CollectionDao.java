package com.order.dao;

import java.sql.SQLException;
import java.util.List;

import com.order.model.Collection;

import cn.hutool.db.Db;
import cn.hutool.db.handler.BeanHandler;

public class CollectionDao {
	
	private Db db = Db.use();
	
	/**
	 * 插入单个收藏
	 * @param coll 收藏对象
	 */
	public int insert(Collection coll) {
		String sql = "insert into collection(uid,fid,addtime) values(?,?,?)";
		Object[] params = { coll.getUid(), coll.getFid(), coll.getAddTime() };
		try {
			return db.execute(sql, params);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 根据用户id和菜品id删除单个收藏
	 * @param uid 用户id
	 * @param fid 菜品id
	 */
	public int delete(int uid, int fid) {
		String sql = "delete from collection where uid=? and fid=?";
		try {
			return db.execute(sql, uid, fid);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 根据用户id查询用户所有收藏
	 * @param uid 用户id
	 * @return 收藏列表
	 */
	public List<Collection> listByUid(int uid) {
		String sql = "select * from collection where uid = ? order by addtime"; // 根据收藏时间升序排序
		try {
			return db.query(sql, Collection.class, uid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 根据用户id和菜品id查询单个收藏
	 * @param uid
	 * @param fid
	 * @return 单个收藏
	 */
	public Collection getByUidAndFid(int uid, int fid) {
		String sql = "select * from collection where uid=? and fid=?";
		try {
			return db.query(sql, new BeanHandler<Collection>(Collection.class), uid, fid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
