package com.dao.impl;

import com.dao.BaseDao;
import com.dao.SCCTStuDao;
import com.entity.SCCTStu;

import java.util.List;

/**
 * 作者：ysq
 * 日期: 2020/12/10 16:57
 * 描述:
 */
public class SCCTStuDaoImpl extends BaseDao implements SCCTStuDao {
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
    public List<SCCTStu> querySCCTStuByPageByNameorTid(String name, String t_id, Integer pageNO, Integer pageSize) {
        String sql = "SELECT tc.id,c.`name`,u.realname,t.t_no,COUNT(sc.stu_id) count FROM `sc` sc,`student` s,`teacher` t,`course` c,`user` u,`tc` tc WHERE";
        if (!"".equals(name)) {
            sql += " c.`name`=? and";
        }
        if (!"".equals(t_id)) {
            sql += " tc.`t_id`=? and";
        }
        sql += " sc.c_id=tc.id and sc.stu_id=s.id and u.id=t.user_id and tc.c_id=c.id and tc.t_id=t.id GROUP BY sc.c_id LIMIT ?,?";

        if (!"".equals(name) && !"".equals(t_id)) {
            return queryForList(SCCTStu.class, sql, name, t_id, pageNO, pageSize);
        } else if (!"".equals(name) && "".equals(t_id)) {
            return queryForList(SCCTStu.class, sql, name, pageNO, pageSize);
        } else if ("".equals(name) && !"".equals(t_id)) {
            return queryForList(SCCTStu.class, sql, t_id, pageNO, pageSize);
        } else {
            return queryForList(SCCTStu.class, sql, pageNO, pageSize);
        }
    }
}
