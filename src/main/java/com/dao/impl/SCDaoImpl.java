package com.dao.impl;

import com.dao.BaseDao;
import com.dao.SCDao;
import com.entity.SC;

import java.util.List;

/**
 * 作者：ysq
 * 日期: 2020/12/9 18:38
 * 描述:
 */
public class SCDaoImpl extends BaseDao implements SCDao {
    @Override
    public Integer insert(SC sc) {
        String sql="insert into `SC` (`c_id`,`stu_id`) values(?,?)";
        return update(sql, sc.getC_id(), sc.getStu_id());    }

    @Override
    public Integer update(SC sc) {
        String sql = "update `SC` set `c_id`=?,`stu_id`=? where `id`=?";
        return update(sql, sc.getC_id(), sc.getStu_id(), sc.getId());
    }

    @Override
    public Integer delete(int id) {
        String sql = "delete from `SC` where `id`=?";
        return update(sql, id);
    }

    @Override
    public Integer deleteByCId(int c_id) {
        String sql = "delete from `sc` where `c_id`=?";
        return update(sql, c_id);
    }

    @Override
    public Integer deleteByCIdAndStuId(int c_id, int stu_id) {
        String sql = "delete from `sc` where `c_id`=? and stu_id=?";
        return update(sql, c_id, stu_id);
    }

    @Override
    public List<SC> queryAll() {
        String sql = "select * from `sc`";
        return queryForList(SC.class, sql);
    }

    @Override
    public SC querySCById(int id) {
        String sql = "select * from `sc` where `id`=?";
        return queryForOne(SC.class, sql, id);
    }

    @Override
    public SC queryByC_idAndStu_id(int c_id, int stu_id) {
        String sql = "select * from `sc` where `c_id`=? and `stu_id`=? ";
        return queryForOne(SC.class,sql,c_id,stu_id);
    }

    @Override
    public Integer queryPageTotalCounts() {
        String sql = "select count(1) from sc";
        return Math.toIntExact((Long)queryForSingleValue(sql));
    }

    @Override
    public List<SC> querySCByPage(Integer pageNO, Integer pageSize) {
        String sql = "select * from sc LIMIT ?,?";
        return queryForList(SC.class,sql,pageNO, pageSize);
    }
}
