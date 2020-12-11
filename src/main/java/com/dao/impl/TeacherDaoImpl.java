package com.dao.impl;

import com.dao.BaseDao;
import com.dao.TeacherDao;
import com.entity.Teacher;

import java.util.List;

/**
 * 作者：youjiahao
 * 日期: 2020/12/9 18:31
 * 描述:
 */
public class TeacherDaoImpl extends BaseDao implements TeacherDao {
    public int insert(Teacher teacher) {
        String sql = "INSERT INTO `teacher`(`user_id`,`t_no`)VALUES(?,?)";
        return update(sql, teacher.getUser_id(), teacher.getT_no());
    }

    public int delete(Integer id) {
        String sql = "DELETE FROM `teacher` WHERE `id`=? ";
        return update(sql, id);
    }

    @Override
    public Integer deleteByUserId(int user_id) {
        String sql = "delete from `teacher` where `user_id`=?";
        return update(sql, user_id);
    }

    public int update(Teacher teacher) {
        String sql = "UPDATE `teacher` SET `user_id`=?,`t_no`=? WHERE `id`=? ";
        return update(sql, teacher.getUser_id(), teacher.getT_no(), teacher.getId());
    }

    public List<Teacher> queryAll() {
        String sql = "SELECT `id`,`user_id`,`t_no`,`create_time`,`update_time` FROM `teacher` ";
        return queryForList(Teacher.class, sql);
    }

    public Teacher queryTeacherById(Integer id) {
        String sql = "SELECT `id`,`user_id`,`t_no`,`create_time`,`update_time` FROM `teacher` WHERE `id`=? ";
        return queryForOne(Teacher.class, sql, id);
    }

    public Integer queryPageTotalCounts() {
        String sql = "SELECT COUNT(1) FROM `teacher` ";
        return Math.toIntExact((Long) queryForSingleValue(sql));
    }

    public List<Teacher> queryTeacherByPage(int pageNo, int pageSize) {
        String sql = "SELECT `id`,`user_id`,`t_no`,`create_time`,`update_time` FROM `teacher` LIMIT ?,? ";
        return queryForList(Teacher.class, sql, pageNo, pageSize);
    }
}
