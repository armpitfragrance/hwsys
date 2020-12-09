package com.dao;

import com.entity.Student;

import java.util.List;

/**
 * 作者：ysq
 * 日期: 2020/12/9 18:20
 * 描述:
 */
public interface StudentDao {
    Integer insert(Student sc);

    Integer update(Student sc);

    Integer delete(int id);

    List<Student> queryAll();

    Student queryStudentById(int id);

    Integer queryPageTotalCounts();

    List<Student> queryStudentByPage(Integer pageNO, Integer pageSize);
}
