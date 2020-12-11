package com.dao;

import com.entity.UserStudent;

import java.util.List;

/**
 * 作者：Zhh
 * 日期: 2020/12/10 16:50
 * 描述:
 */
public interface UserStudentDao {
    Integer queryPageTotalCounts();//查询当前表的总记录条数
    Integer queryPageTotalCountsByPageByRealNameOrStuNo(String realname,String stu_no);//查询符合条件当前表的总记录条数
    List<UserStudent> queryUserStudentByPage(int pageNo, int pageSize);
    List<UserStudent> queryUserStudentByPageByRealNameOrStuNo(int pageNo, int pageSize,String realname,String stu_no);
}
