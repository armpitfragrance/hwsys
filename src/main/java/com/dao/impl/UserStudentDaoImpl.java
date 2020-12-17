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
    public Integer queryPageTotalCountsByCourseIdAndSno(Integer course_id, Integer stu_no) {
        String sql="SELECT count(1) FROM course c,sc sc,student s,user u WHERE c.id=sc.c_id and sc.stu_id=s.id and s.user_id=u.id and c.id= "+course_id;
        if(stu_no!=null){
            sql+=" and s.stu_no= "+stu_no;
        }
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

    //根据课程id和学号查看选修这门课的学生信息
    @Override
    public List<UserStudent> queryUserStudentByCourseIdAndSno(int pageNo, int pageSize, Integer course_id, Integer stu_no) {
        String sql="SELECT s.id,s.stu_no,u.realname,u.sex,u.age,s.classname FROM course c,sc sc,student s,user u WHERE c.id=sc.c_id and sc.stu_id=s.id and s.user_id=u.id and c.id=?";
        if(stu_no!=null){
            sql+=" and s.stu_no like ? ";
        }
        sql+=" limit ?,? ";
        if(stu_no!=null){
            return queryForList(UserStudent.class,sql,course_id,stu_no,pageNo,pageSize);
        }else{
            return queryForList(UserStudent.class,sql,course_id,pageNo,pageSize);
        }
    }
}
