package com.dao.impl;

import com.dao.BaseDao;
import com.dao.CourseDao;
import com.entity.Course;

import java.util.List;

/**
 * 作者：Zhh
 * 日期: 2020/12/9 18:33
 * 描述:
 */
public class CourseDaoImpl extends BaseDao implements CourseDao {
    @Override
    public int insert(Course course) {
        String sql="INSERT INTO `course`(`name`)VALUES(?)";
        return update(sql,course.getName());
    }

    @Override
    public int delete(Integer id) {
        String sql="DELETE FROM `course` WHERE `id`=? ";
        return update(sql,id);
    }

    @Override
    public int update(Course course) {
        String sql="UPDATE `course` SET `name`=? WHERE `id`=? ";
        return update(sql,course.getName(),course.getId());
    }

    @Override
    public List<Course> queryAll() {
        String sql="SELECT * FROM `course` ";
        return queryForList(Course.class,sql);
    }

    @Override
    public Course queryCourseById(Integer id) {
        String sql="SELECT * FROM `course` WHERE `id`=? ";
        return queryForOne(Course.class,sql,id);
    }

    @Override
    public Integer queryPageTotalCounts() {
        String sql="SELECT COUNT(1) FROM `course` ";
        return Math.toIntExact((Long) queryForSingleValue(sql));
    }

    @Override
    public List<Course> queryCourseByPage(int pageNo, int pageSize) {
        String sql="SELECT * FROM `course` LIMIT ?,? ";
        return queryForList(Course.class,sql,pageNo,pageSize);
    }
}
