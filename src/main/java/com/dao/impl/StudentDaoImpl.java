package com.dao.impl;

import com.dao.BaseDao;
import com.dao.StudentDao;
import com.entity.Student;

import java.util.List;

/**
 * 作者：ysq
 * 日期: 2020/12/9 18:48
 * 描述:
 */
public class StudentDaoImpl extends BaseDao implements StudentDao {
    @Override
    public Integer insert(Student student) {
        String sql="insert into `student` (`user_id`,`stu_no`,`classname`) values(?,?,?)";
        return update(sql, student.getUser_id(), student.getStu_no(), student.getClassname());
    }

    @Override
    public Integer update(Student student) {
        String sql = "update `student` set `user_id`=?,`stu_no`=?,`classname`=? where `id`=?";
        return update(sql, student.getUser_id(), student.getStu_no(), student.getClassname(), student.getId());
    }

    @Override
    public Integer delete(int id) {
        String sql = "delete from `student` where `id`=?";
        return update(sql, id);
    }

    @Override
    public Integer deleteByUserId(int user_id) {
        String sql = "delete from `student` where `user_id`=?";
        return update(sql, user_id);
    }

    @Override
    public List<Student> queryAll() {
        String sql = "select * from `student`";
        return queryForList(Student.class, sql);
    }

    @Override
    public Student queryStudentById(int id) {
        String sql = "select * from `student` where `id`=?";
        return queryForOne(Student.class, sql, id);
    }

    @Override
    public Integer queryPageTotalCounts() {
        String sql = "select count(1) from student";
        return Math.toIntExact((Long)queryForSingleValue(sql));
    }

    @Override
    public List<Student> queryStudentByPage(Integer pageNO, Integer pageSize) {
            String sql = "select * from student LIMIT ?,?";
            return queryForList(Student.class, sql, pageNO, pageSize);
    }
}
