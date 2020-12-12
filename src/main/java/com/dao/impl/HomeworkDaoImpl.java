package com.dao.impl;

import com.dao.BaseDao;
import com.dao.HomeworkDao;
import com.entity.Homework;

import java.util.List;

/**
 * 作者：Zhh
 * 日期: 2020/12/9 18:36
 * 描述:
 */
public class HomeworkDaoImpl extends BaseDao implements HomeworkDao {
    @Override
    public int insert(Homework homework) {
        String sql="INSERT INTO `homework`(`name`,`docu_name`,`path`,`t_id`,`c_id`,`end_time`)VALUES(?,?,?,?,?,?)";
        return update(sql, homework.getName(), homework.getDocu_name(), homework.getPath(), homework.getT_id(), homework.getC_id(),homework.getEnd_time());
    }

    @Override
    public int delete(Integer id) {
        String sql="DELETE FROM `homework` WHERE `id`=? ";
        return update(sql,id);
    }

    @Override
    public int update(Homework homework) {
        String sql="UPDATE `homework` SET `name`=?,`docu_name`=?,`path`=?,`t_id`=?,`c_id`=?,`end_time`=? WHERE `id`=? ";
        return update(sql,homework.getName(), homework.getDocu_name(), homework.getPath(), homework.getT_id(), homework.getC_id(),homework.getEnd_time(),homework.getId());
    }

    @Override
    public List<Homework> queryAll() {
        String sql="SELECT * FROM `homework` ";
        return queryForList(Homework.class,sql);
    }

    @Override
    public Homework queryHomeworkById(Integer id) {
        String sql="SELECT * FROM `homework` WHERE `id`=? ";
        return queryForOne(Homework.class,sql,id);
    }

    @Override
    public Integer queryPageTotalCounts() {
        String sql="SELECT COUNT(1) FROM `homework` ";
        return Math.toIntExact((Long) queryForSingleValue(sql));
    }

    @Override
    public List<Homework> queryHomeworkByPage(int pageNo, int pageSize) {
        String sql="SELECT * FROM `homework` LIMIT ?,? ";
        return queryForList(Homework.class,sql,pageNo,pageSize);
    }
}
