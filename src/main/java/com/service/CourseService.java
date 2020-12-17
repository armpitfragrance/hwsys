package com.service;

import com.entity.Course;

/**
 * 作者：Zhh
 * 日期: 2020/12/14 10:02
 * 描述:
 */
public interface CourseService {
    Integer deleteById(int id);

    Integer getMaxId();

    Integer insert(Course course);

    Integer update(Course course);

    Course queryById(Integer id);
}
