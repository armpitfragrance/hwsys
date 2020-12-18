package com.dao.impl;

import com.dao.BaseDao;
import com.dao.SCCTStuDao;
import com.dao.TCDao;
import com.entity.SCCTStu;

import java.util.ArrayList;
import java.util.List;

/**
 * 作者：ysq
 * 日期: 2020/12/10 16:57
 * 描述:
 */
public class SCCTStuDaoImpl extends BaseDao implements SCCTStuDao {
    TCDao tcDao = new TCDaoImpl();
    @Override
    public Integer delete(Integer id) {
        String sql = "delete from `tc` where `id`=?";
        return update(sql, id);
    }

    @Override
    public SCCTStu querySCCTStuById(int sc_id) {
        return null;
    }

    @Override
    public Integer queryPageTotalCounts() {
        String sql = "select count(1) from tc";
        return Math.toIntExact((Long) queryForSingleValue(sql));
    }

    @Override
    public List<SCCTStu> querySCCTStuByPage(Integer pageNO, Integer pageSize) {
        String sql = "SELECT tc.id,c.`name`,u.realname,t.t_no,COUNT(sc.stu_id) count FROM `sc` sc,`student` s,`teacher` t,`course` c,`user` u,`tc` tc WHERE sc.c_id=tc.id and sc.stu_id=s.id and u.id=t.user_id and tc.c_id=c.id and tc.t_id=t.id GROUP BY sc.c_id LIMIT ?,?";

        return queryForList(SCCTStu.class, sql, pageNO, pageSize);
    }

    @Override
    public Integer queryPageTotalCountsByNameOrTid(String name, String t_id) {
        String sql = "SELECT count(1) FROM `teacher` t,`course` c,`tc` tc WHERE";
        if (!"".equals(name)) {
            sql += " c.`name`=? and";
        }
        if (!"".equals(t_id)) {
            sql += " tc.`t_id`=? and";
        }
        sql += " tc.c_id=c.id and tc.t_id=t.id";

        if (!"".equals(name) && !"".equals(t_id)) {
            return Math.toIntExact((Long) queryForSingleValue(sql,name,t_id));
        } else if (!"".equals(name) && "".equals(t_id)) {
            return Math.toIntExact((Long) queryForSingleValue(sql,name));
        } else if ("".equals(name) && !"".equals(t_id)) {
            return Math.toIntExact((Long) queryForSingleValue(sql,t_id));
        } else {
            return Math.toIntExact((Long) queryForSingleValue(sql));
        }
    }

    @Override
    public Integer queryPageTotalCountsByCourseName(String course_name, String stu_id) {
        String sql = "SELECT count(1) FROM `sc` sc,`course` c WHERE";
        if (!"".equals(course_name)) {
            sql += " c.`name`=? and";
        }
        sql += " sc.stu_id=? and c.id=sc.c_id";

        if (!"".equals(course_name)) {
            return Math.toIntExact((Long) queryForSingleValue(sql, course_name,stu_id));
        } else {
            return Math.toIntExact((Long) queryForSingleValue(sql, stu_id));
        }
    }

    @Override
    public List<SCCTStu> querySCCTStuByPageByNameorStuId(String name, String stu_id, Integer pageNO, Integer pageSize) {
        List<SCCTStu> list = new ArrayList<>();
        String sql = "SELECT tc.id,tc.c_id,c.`name`,u.realname,t.t_no,c.path,tc.create_time createtime FROM `sc` sc,`student` s,`teacher` t,`course` c,`user` u,`tc` tc WHERE";
        if (!"".equals(name)) {
            sql += " c.`name`=? and";
        }
        sql += " sc.`stu_id`=? and sc.c_id=tc.c_id and sc.stu_id=s.id and u.id=t.user_id and tc.c_id=c.id and tc.t_id=t.id GROUP BY sc.c_id LIMIT ?,?";

        if (!"".equals(name)) {
            list = queryForList(SCCTStu.class, sql, name, stu_id, pageNO, pageSize);
        } else {
            list = queryForList(SCCTStu.class, sql, stu_id, pageNO, pageSize);
        }
        String sql1 = "select count(1) count from course c,sc sc,student s where c.id=sc.c_id and sc.stu_id=s.id and sc.c_id=?";
        for (int i = 0; i < list.size(); i++) {

            Integer c_id = tcDao.queryTCById(list.get(i).getId()).getC_id();
            Integer count = Math.toIntExact((Long) queryForSingleValue(sql1, c_id));
            list.get(i).setCount(count);
        }
        return list;
    }

    @Override
    public List<SCCTStu> querySCCTStuByPageByNameorTid1(String name, String t_id, Integer pageNO, Integer pageSize) {
        List<SCCTStu> list = new ArrayList<>();
        String sql = "SELECT tc.id,tc.c_id,c.`name`,u.realname,t.t_no,c.path,tc.create_time createtime FROM `teacher` t,`course` c,`user` u,`tc` tc WHERE";
        if (!"".equals(name)) {
            sql += " c.`name`=? and";
        }
        if (!"".equals(t_id)) {
            sql += " t.`t_no`=? and";
        }
        sql += " u.id=t.user_id and tc.c_id=c.id and tc.t_id=t.id LIMIT ?,?";

        if (!"".equals(name) && !"".equals(t_id)) {
            list = queryForList(SCCTStu.class, sql, name, t_id, pageNO, pageSize);
        } else if (!"".equals(name) && "".equals(t_id)) {
            list = queryForList(SCCTStu.class, sql, name, pageNO, pageSize);
        } else if ("".equals(name) && !"".equals(t_id)) {
            list = queryForList(SCCTStu.class, sql, t_id, pageNO, pageSize);
        } else {
            list = queryForList(SCCTStu.class, sql, pageNO, pageSize);
        }
        String sql1 = "select count(1) count from course c,sc sc,student s where c.id=sc.c_id and sc.stu_id=s.id and sc.c_id=?";
        for (int i = 0; i < list.size(); i++) {

            Integer c_id = tcDao.queryTCById(list.get(i).getId()).getC_id();
            Integer count = Math.toIntExact((Long) queryForSingleValue(sql1, c_id));
            list.get(i).setCount(count);
        }
        return list;
    }
}
