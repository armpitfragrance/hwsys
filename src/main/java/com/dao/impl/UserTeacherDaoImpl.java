package com.dao.impl;

import com.dao.BaseDao;
import com.dao.UserTeacherDao;
import com.entity.UserTeacher;

import java.util.List;

/**
 * 作者：Zhh
 * 日期: 2020/12/11 14:37
 * 描述:
 */
public class UserTeacherDaoImpl extends BaseDao implements UserTeacherDao {
    @Override
    public UserTeacher teacherLogin(String user_no, String password) {
        String sql = "select t.id,t.user_id,t.t_no,u.psw,u.realname,u.sex,u.age from teacher t,user u  where t.user_id=u.id and u.type='老师' and t.t_no=? and u.psw=?";
        return queryForOne(UserTeacher.class, sql, user_no, password);
    }

    @Override
    public Integer queryPageTotalCounts() {
        String sql = "SELECT COUNT(1) FROM `user` WHERE type='老师'";
        return Math.toIntExact((Long) queryForSingleValue(sql));
    }

    @Override
    public Integer queryPageTotalCountsByPageByRealNameOrStuNo(String realname, String t_no) {
        String sql = "select count(1) from teacher t,user u where";
        if (!"".equals(realname)) {
            sql += " u.realname like '"+realname+"' and";
        }
        if (!"".equals(t_no)) {
            sql+=" t.t_no="+t_no+" and";
        }
        sql += " t.user_id=u.id and u.type='老师'";
        return Math.toIntExact((Long) queryForSingleValue(sql));
    }

    @Override
    public List<UserTeacher> queryUserStudentByPage(int pageNo, int pageSize) {
        String sql = "select t.id,t.user_id,t.t_no,u.psw,u.realname,u.sex,u.age from teacher t,user u  where t.user_id=u.id and u.type='老师' limit ?,?";
        return queryForList(UserTeacher.class, sql, pageNo, pageSize);
    }

    @Override
    public List<UserTeacher> queryUserStudentByPageByRealNameOrStuNo(int pageNo, int pageSize, String realname, String t_no) {
        String sql = "select t.id,t.user_id,t.t_no,u.psw,u.realname,u.sex,u.age from teacher t,user u  where";
        if (!"".equals(realname)) {
            sql += " u.realname=? and";
        }
        if (!"".equals(t_no)) {
            sql+=" t.t_no=? and";
        }
        sql += " t.user_id=u.id and u.type='老师' limit ?,?";
        if (!"".equals(realname) && !"".equals(t_no)) {
            return queryForList(UserTeacher.class, sql, realname, t_no, pageNo, pageSize);
        } else if (!"".equals(realname) && "".equals(t_no)) {
            return queryForList(UserTeacher.class, sql, realname, pageNo, pageSize);
        } else if ("".equals(realname) && !"".equals(t_no)) {
            return queryForList(UserTeacher.class, sql, t_no, pageNo, pageSize);
        } else {
            return queryForList(UserTeacher.class, sql, pageNo, pageSize);
        }
    }

    @Override
    public UserTeacher queryByTId(int t_id) {
        String sql = "select t.id,t.user_id,t.t_no,u.psw,u.realname,u.sex,u.age from teacher t,user u  where t.user_id=u.id and t.id=?";
        return queryForOne(UserTeacher.class, sql, t_id);
    }
}
