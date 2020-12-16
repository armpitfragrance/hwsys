package com.dao;

import com.entity.Course;

import java.util.List;

/**
 * 作者：Zhh
 * 日期: 2020/12/9 18:32
 * 描述:
 */
public interface CourseDao {
    //插入一条课程信息
    int insert(Course course);

    //删除一条课程信息
    int delete(Integer id);

    //更新一条课程信息
    int update(Course course);

    //查询所有课程信息
    List<Course> queryAll();

    //根据id查询课程信息
    Course queryCourseById(Integer id);

    //查询总条数
    Integer queryPageTotalCounts();

    //分页查询
    List<Course> queryCourseByPage(int pageNo, int pageSize);

    Integer getMaxId();
}
