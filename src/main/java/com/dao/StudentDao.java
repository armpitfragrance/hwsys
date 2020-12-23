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

    Integer deleteByUserId(int user_id);

    List<Student> queryAll();

    Student queryStudentById(int id);

    Student queryStudentByStu_no(int stu_no);//根据学号查询学生信息

    Integer queryPageTotalCounts();

    Integer querySnoCounts(int stu_no);//根据学号查询

    List<Student> queryStudentByPage(Integer pageNO, Integer pageSize);
}
