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

    Integer deleteByUserId(int user_id);

    int update(Teacher teacher);

    List<Teacher> queryAll();

    Teacher queryTeacherById(Integer id);

    Integer queryPageTotalCounts();//查询当前表的总记录条数

    Integer queryTnoCounts(int t_no);//根据工号查询

    List<Teacher> queryTeacherByPage(int pageNo, int pageSize);
}
