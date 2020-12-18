package com.dao;

import com.entity.Admin;

import java.util.List;

/**
 * 作者：Zhh
 * 日期: 2020/12/9 18:22
 * 描述:
 */
public interface AdminDao {
    //插入一条管理员信息
    int insert(Admin admin);

    //删除一条管理员信息
    int delete(Integer id);

    //更新一条管理员信息
    int update(Admin admin);

    //查询所有管理员信息
    List<Admin> queryAll();

    Admin login(String user_no, String password);

    //根据id查询管理员信息
    Admin queryAdminById(Integer id);

    //查询总条数
    Integer queryPageTotalCounts();

    //分页查询
    List<Admin> queryAdminByPage(int pageNo, int pageSize);
}
