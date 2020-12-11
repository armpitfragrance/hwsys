package com.dao.impl;

import com.dao.BaseDao;
import com.dao.UserStudentDao;
import com.entity.UserStudent;

import java.util.List;

/**
 * 作者：Zhh
 * 日期: 2020/12/10 16:52
 * 描述:
 */
public class UserStudentDaoImpl extends BaseDao implements UserStudentDao {
    @Override
    public Integer queryPageTotalCounts() {
        String sql = "SELECT COUNT(1) FROM `user` WHERE type='学生'";
        return Math.toIntExact((Long) queryForSingleValue(sql));
    }

    @Override
    public Integer queryPageTotalCountsByPageByRealNameOrStuNo(String realname, String stu_no) {
        String sql = "select count(1) from student s,user u where";
        if (!"".equals(realname)) {
            sql += " u.realname like '"+realname+"' and";
        }
        if (!"".equals(stu_no)) {
            sql+=" s.stu_no="+stu_no+" and";
        }
        sql += " s.user_id=u.id and u.type='学生'";
        return Math.toIntExact((Long) queryForSingleValue(sql));
    }

    @Override
    public List<UserStudent> queryUserStudentByPage(int pageNo, int pageSize) {
        String sql = "select s.id,s.user_id,s.stu_no,u.psw,u.realname,s.classname,u.sex,u.age from student s,user u  where s.user_id=u.id and u.type='学生' limit ?,?";
        return queryForList(UserStudent.class, sql, pageNo, pageSize);
    }

    @Override
    public List<UserStudent> queryUserStudentByPageByRealNameOrStuNo(int pageNo, int pageSize, String realname, String stu_no) {
        String sql = "select s.id,s.user_id,s.stu_no,u.psw,u.realname,s.classname,u.sex,u.age from student s,user u  where";
        if (!"".equals(realname)) {
            sql += " u.realname=? and";
        }
        if (!"".equals(stu_no)) {
            sql+=" s.stu_no=? and";
        }
        sql += " s.user_id=u.id and u.type='学生' limit ?,?";
        if (!"".equals(realname) && !"".equals(stu_no)) {
            return queryForList(UserStudent.class, sql, realname, stu_no, pageNo, pageSize);
        } else if (!"".equals(realname) && "".equals(stu_no)) {
            return queryForList(UserStudent.class, sql, realname, pageNo, pageSize);
        } else if ("".equals(realname) && !"".equals(stu_no)) {
            return queryForList(UserStudent.class, sql, stu_no, pageNo, pageSize);
        } else {
            return queryForList(UserStudent.class, sql, pageNo, pageSize);
        }
    }
}
