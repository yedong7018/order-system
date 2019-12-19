package com.order.dao;

import java.sql.SQLException;
import java.util.List;

import com.order.model.Evaluation;

import cn.hutool.db.Db;

public class EvaluationDao {

	private Db db = Db.use();
	
	/**
	 * 批处理插入多个评价
	 * @param list 评价列表
	 */
	public void insert(List<Evaluation> list) {
		String sql = "insert into evaluation (oid,fid,rating) values (?,?,?)";
		Object[][] params = new Object[list.size()][];
		for (int i = 0; i < params.length; i++) {
			Evaluation e = list.get(i);
			params[i] = new Object[] { e.getOid(), e.getFid(), e.getRating() };
		}
		try {
			db.executeBatch(sql, params);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
