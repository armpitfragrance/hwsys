package com.service.impl;

import com.dao.CourseDao;
import com.dao.impl.CourseDaoImpl;
import com.entity.Course;
import com.service.CourseService;

/**
 * 作者：Zhh
 * 日期: 2020/12/14 10:03
 * 描述:
 */
public class CourseServiceImpl implements CourseService {
    CourseDao courseDao = new CourseDaoImpl();

    @Override
    public Integer deleteById(int id) {
        return courseDao.delete(id);
    }

    @Override
    public Integer getMaxId() {
        return courseDao.getMaxId();
    }

    @Override
    public Integer insert(Course course) {
        return courseDao.insert(course);
    }

    @Override
    public Integer update(Course course) {
        return courseDao.update(course);
    }

    @Override
    public Course queryById(Integer id) {
        return courseDao.queryCourseById(id);
    }

}
