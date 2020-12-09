package com.dao;

import com.entity.Teacher;

import java.util.List;

/**
 * 作者：youjiahao
 * 日期: 2020/12/9 18:27
 * 描述:
 */
public interface TeacherDao {
    int insert(Teacher teacher);

    int delete(Integer id);

    int update(Teacher teacher);

    List<Teacher> queryAll();

    Teacher queryTeacherById(Integer id);

    Integer queryPageTotalCounts();//查询当前表的总记录条数

    List<Teacher> queryTeacherByPage(int pageNo, int pageSize);
}
