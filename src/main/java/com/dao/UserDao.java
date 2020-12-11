package com.dao;

import com.entity.User;

import java.util.List;

/**
 * 作者：youjiahao
 * 日期: 2020/12/9 18:23
 * 描述:
 */
public interface UserDao {

    int insert(User user);

    int delete(Integer id);

    int update(User user);

    List<User> queryAll();

    User queryUserById(Integer id);

    Integer queryPageTotalCounts();//查询当前表的总记录条数

    List<User> queryUserByPage(int pageNo, int pageSize);

    Integer getMaxId();
}
