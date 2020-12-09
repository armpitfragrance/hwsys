package com.dao.impl;

import com.dao.BaseDao;
import com.dao.TCDao;
import com.entity.TC;

import java.util.List;

/**
 * 作者：youjiahao
 * 日期: 2020/12/9 18:31
 * 描述:
 */
public class TCDaoImpl extends BaseDao implements TCDao {
    public int insert(TC tc) {
        String sql = "INSERT INTO `tc`(`t_id`,`c_id`)VALUES(?,?)";
        return update(sql, tc.getT_id(), tc.getC_id());
    }

    public int delete(Integer id) {
        String sql = "DELETE FROM `tc` WHERE `id`=? ";
        return update(sql, id);
    }

    public int update(TC tc) {
        String sql = "UPDATE `tc` SET `t_id`=?,`c_id`=? WHERE `id`=? ";
        return update(sql, tc.getT_id(), tc.getC_id(), tc.getId());
    }

    public List<TC> queryAll() {
        String sql = "SELECT `id`,`t_id`,`c_id`,`create_time`,`update_time` FROM `tc` ";
        return queryForList(TC.class, sql);
    }

    public TC queryTCById(Integer id) {
        String sql = "SELECT `id`,`t_id`,`c_id`,`create_time`,`update_time` FROM `tc` WHERE `id`=? ";
        return queryForOne(TC.class, sql, id);
    }

    public Integer queryPageTotalCounts() {
        String sql = "SELECT COUNT(1) FROM `tc` ";
        return Math.toIntExact((Long) queryForSingleValue(sql));
    }

    public List<TC> queryTCByPage(int pageNo, int pageSize) {
        String sql = "SELECT `id`,`t_id`,`c_id`,`create_time`,`update_time` FROM `tc` LIMIT ?,? ";
        return queryForList(TC.class, sql, pageNo, pageSize);
    }
}
