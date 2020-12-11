package com.dao.impl;

import com.dao.BaseDao;
import com.dao.UserDao;
import com.entity.User;

import java.util.List;

/**
 * 作者：youjiahao
 * 日期: 2020/12/9 18:23
 * 描述:
 */
public class UserDaoImpl extends BaseDao implements UserDao {
    public int insert(User user) {
        String sql = "INSERT INTO `user`(`type`,`psw`,`realname`,`sex`,`age`)VALUES(?,?,?,?,?)";
        return update(sql, user.getType(), user.getPsw(), user.getRealname(), user.getSex(), user.getAge());
    }

    public int delete(Integer id) {
        String sql = "DELETE FROM `user` WHERE `id`=? ";
        return update(sql, id);
    }

    public int update(User user) {
        String sql = "UPDATE `user` SET `type`=?,`psw`=?,`realname`=?,`sex`=?,`age`=? WHERE `id`=? ";
        return update(sql, user.getType(), user.getPsw(), user.getRealname(), user.getSex(), user.getAge(), user.getId());
    }

    public List<User> queryAll() {
        String sql = "SELECT `id`,`type`,`psw`,`realname`,`sex`,`age`,`create_time`,`update_time` FROM `user` ";
        return queryForList(User.class, sql);
    }

    public User queryUserById(Integer id) {
        String sql = "SELECT `id`,`type`,`psw`,`realname`,`sex`,`age`,`create_time`,`update_time` FROM `user` WHERE `id`=? ";
        return queryForOne(User.class, sql, id);
    }

    public Integer queryPageTotalCounts() {
        String sql = "SELECT COUNT(1) FROM `user` ";
        return Math.toIntExact((Long) queryForSingleValue(sql));
    }

    public List<User> queryUserByPage(int pageNo, int pageSize) {
        String sql = "SELECT `id`,`type`,`psw`,`realname`,`sex`,`age`,`create_time`,`update_time` FROM `user` LIMIT ?,? ";
        return queryForList(User.class, sql, pageNo, pageSize);
    }

    @Override
    public Integer getMaxId() {
        String sql = "SELECT MAX(id) id FROM `user` WHERE 1=1";
        return queryForOne(User.class, sql).getId();
    }
}
