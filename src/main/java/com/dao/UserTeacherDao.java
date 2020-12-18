package com.dao;

import com.entity.UserTeacher;

import java.util.List;

/**
 * 作者：Zhh
 * 日期: 2020/12/11 14:36
 * 描述:
 */
public interface UserTeacherDao {
    UserTeacher teacherLogin(String user_no, String password);

    Integer queryPageTotalCounts();//查询当前表的总记录条数
    Integer queryPageTotalCountsByPageByRealNameOrStuNo(String realname,String t_no);//查询符合条件当前表的总记录条数
    List<UserTeacher> queryUserStudentByPage(int pageNo, int pageSize);
    List<UserTeacher> queryUserStudentByPageByRealNameOrStuNo(int pageNo, int pageSize,String realname,String t_no);

    UserTeacher queryByTId(int t_id);
}
