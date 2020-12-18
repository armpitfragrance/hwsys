package com.dao.impl;

import com.dao.AdminDao;
import com.dao.BaseDao;
import com.entity.Admin;

import java.util.List;

/**
 * 作者：Zhh
 * 日期: 2020/12/9 18:30
 * 描述:
 */
public class AdminDaoImpl extends BaseDao implements AdminDao {
    @Override
    public int insert(Admin admin) {
        String sql="INSERT INTO `admin`(`username`,`psw`)VALUES(?,?)";
        return update(sql,admin.getUsername(),admin.getPsw());
    }

    @Override
    public int delete(Integer id) {
        String sql="DELETE FROM `admin` WHERE `id`=? ";
        return update(sql,id);
    }

    @Override
    public int update(Admin admin) {
        String sql="UPDATE `admin` SET `username`=?,`psw`=? WHERE `id`=? ";
        return update(sql,admin.getUsername(),admin.getPsw(),admin.getId());
    }

    @Override
    public List<Admin> queryAll() {
        String sql="SELECT * FROM `admin` ";
        return queryForList(Admin.class,sql);
    }

    @Override
    public Admin login(String user_no, String password) {
        String sql="SELECT * FROM `admin` WHERE `username`=? and `psw`=?";
        return queryForOne(Admin.class,sql,user_no,password);
    }

    @Override
    public Admin queryAdminById(Integer id) {
        String sql="SELECT * FROM `admin` WHERE `id`=? ";
        return queryForOne(Admin.class,sql,id);
    }

    @Override
    public Integer queryPageTotalCounts() {
        String sql="SELECT COUNT(1) FROM `admin` ";
        return Math.toIntExact((Long) queryForSingleValue(sql));
    }

    @Override
    public List<Admin> queryAdminByPage(int pageNo, int pageSize) {
        String sql="SELECT * FROM `admin` LIMIT ?,? ";
        return queryForList(Admin.class,sql,pageNo,pageSize);
    }
}
