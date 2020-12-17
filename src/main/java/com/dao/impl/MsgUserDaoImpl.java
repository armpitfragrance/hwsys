package com.dao.impl;

import com.dao.BaseDao;
import com.dao.MsgUserDao;
import com.entity.Message;
import com.entity.MsgUser;
import com.entity.User;
import com.utils.Page;

import java.util.List;

/**
 * 作者：ysq
 * 日期: 2020/12/14 9:30
 * 描述:
 */
public class MsgUserDaoImpl extends BaseDao implements MsgUserDao {

    @Override
    public Integer insert(MsgUser msgUser) {
        String sql="insert into `message` (`title`,`content`,`send_id`,`receive_id`,`readFlag`) values(?,?,?,?,?)";
        return update(sql, msgUser.getTitle(), msgUser.getContent(), msgUser.getSend_id(), msgUser.getReceive_id(),msgUser.getReadFlag());
    }

    @Override
    public Integer delete(int id) {
        String sql = "delete from `message` where `id`=?";
        return update(sql, id);
    }

    @Override
    public Integer isRead(MsgUser msgUser) {
        String sql = "update `message` set `readFlag`=? where `id`=?";
        return update(sql, msgUser.getReadFlag(), msgUser.getId());
    }


    @Override
    public MsgUser queryMessageById(int id) {
        String sql = "select m.id,m.title,m.content,m.message_time,m.send_id,m.receive_id,u.realname send_name,u.realname receive_name,m.readFlag from `message` m,`user` u where m.id=? and u.id=m.send_id";
        return queryForOne(MsgUser.class, sql, id);
    }

    @Override
    public List<MsgUser> queryByRcvid(int receive_id) {
        String sql = "select m.id,m.title,m.content,m.message_time,m.send_id,m.receive_id,u.realname send_name,u.realname receive_name,m.readFlag from `message` m,`user` u where m.receive_id=? and u.id=m.send_id";
        return queryForList(MsgUser.class, sql, receive_id);
    }

    @Override
    public Integer queryPageTotalCountsByRcvid(int receive_id) {
        String sql = "select count(1) from message where `receive_id`=?" ;
        return Math.toIntExact((Long) queryForSingleValue(sql, receive_id));
    }

    @Override
    public List<MsgUser> queryMessageByPageandRcvid(int receive_id, Integer pageNO, Integer pageSize) {
        String sql = "select m.id,m.title,m.content,m.message_time,m.send_id,m.receive_id,u.`realname` send_name,u.realname receive_name,m.readFlag from `message` m,`user` u where m.receive_id=? and u.id=m.send_id LIMIT ?,?";
        return queryForList(MsgUser.class, sql, receive_id, pageNO, pageSize);
    }

    @Override
    public List<MsgUser> queryByRcvidandReadFlag(int receive_id, String readFlag) {
        String sql = "select m.id,m.title,m.content,m.message_time,m.send_id,m.receive_id,u.realname send_name,u.realname receive_name,m.readFlag from `message` m,`user` u where m.receive_id=? and u.id=m.send_id and m.readFlag=?";
        return queryForList(MsgUser.class, sql, receive_id, readFlag);
    }

    @Override
    public Integer queryPageTotalCountsByRcvidandReadFlag(int receive_id, String readFlag) {
        String sql = "select count(1) from message where `receive_id`=? and `readFlag`=?" ;
        return Math.toIntExact((Long) queryForSingleValue(sql, receive_id, readFlag));
    }

    @Override
    public List<MsgUser> queryMessageByPageandRcvidandReadFlag(int receive_id, String readFlag,Integer pageNO, Integer pageSize) {
        String sql = "select m.id,m.title,m.content,m.message_time,m.send_id,m.receive_id,u.`realname` send_name,u.realname receive_name,m.readFlag from `message` m,`user` u where m.receive_id=? and u.id=m.send_id and m.readFlag=? LIMIT ?,?";
        return queryForList(MsgUser.class, sql, receive_id,readFlag, pageNO, pageSize);
    }


    @Override
    public Integer delete(int[] ids) {
        int i = 0;
        for (int id : ids) {
            String sql = "delete from `message` where `id`=?";
            if (update(sql, id) > 0) {
                i++;
            }
        }
        return i;
    }

    @Override
    public User queryTeacher(String t_no) {
        String sql = "select u.* from user u,teacher t where t.t_no=? AND u.id=t.user_id";
        return queryForOne(User.class, sql, t_no);
    }

    @Override
    public User queryStudent(String stu_no) {
        String sql = "select u.* from user u,student s where s.stu_no=? AND u.id=s.user_id";
        return queryForOne(User.class, sql, stu_no);
    }

    @Override
    public String queryUserNo(String userid, String username) {
        String sql1 = "select u.type from user u where u.id=? and u.realname=?";
        String type = queryForOne(String.class, sql1, userid, username);
        if (type.equals("老师")) {
            String sql2 = "select t.t_no from teacher t,user u where u.id=? and u.realname=? and t.user_id=u.id";
            String No = queryForOne(String.class, sql2, userid, username);
        } else if (type.equals("学生")) {
            String sql2 = "select s.stu_no from student s,user u where u.id=? and u.realname=? and s.user_id=u.id";
            String No = queryForOne(String.class, sql2, userid, username);
        }
        return null;
    }

    @Override
    public Integer conditionQueryCount(int receive_id, String send_name, String date) {
        String sql = "";
        if (!"".equals(send_name) && "".equals(date)) {
            sql += "select count(1) from message m,user u where `receive_id`=? and m.send_id=u.id and u.realname like '%" + send_name + "%'";
        } else if (!"".equals(date) && "".equals(send_name)) {
            sql += "select count(1) from message m where `receive_id`=? and message_time LIKE '" + date + "%'";
        } else if ("".equals(date) && "".equals(send_name)) {
            sql += "select  count(1) from message m where `receive_id`=?";
        } else {
            sql += "select count(1) from message m,user u where `receive_id`=? and m.send_id=u.id and u.realname like '%" + send_name + "%' and message_time LIKE '" + date + "%' ";
        }
        return Math.toIntExact((Long) queryForSingleValue(sql, receive_id));
    }

    @Override
    public Integer conditionQueryCount(int receive_id, String readFlag, String send_name, String date) {
        String sql = "";
        if (!"".equals(send_name) && "".equals(date)) {
            sql += "select count(1) from message m,user u where `receive_id`=? and `readFlag`=? m.send_id=u.id and u.realname like '%" + send_name + "%'";
        } else if (!"".equals(date) && "".equals(send_name)) {
            sql += "select count(1) from message m where `receive_id`=? and `readFlag`=? and message_time LIKE '" + date + "%'";
        } else if ("".equals(date) && "".equals(send_name)) {
            sql += "select  count(1) from message m where `receive_id`=? and `readFlag`=?";
        } else {
            sql += "select count(1) from message m,user u where `receive_id`=? and `readFlag`=? and m.send_id=u.id and u.realname like '%" + send_name + "%' and message_time LIKE '" + date + "%' ";
        }
        return Math.toIntExact((Long) queryForSingleValue(sql, receive_id,readFlag));
    }

    @Override
    public List<MsgUser> conditionQueryMessage(int receive_id, String send_name, String date, Integer pageNO, Integer pageSize) {
        String sql = "";
        if (!"".equals(send_name) && "".equals(date)) {
            sql += "select m.id,m.title,m.content,m.message_time,m.send_id,m.receive_id,u.`realname` send_name,u.realname receive_name,m.readFlag from message m,user u where `receive_id`=? and m.send_id=u.id and u.realname like '%" + send_name + "%'";
        } else if (!"".equals(date) && "".equals(send_name)) {
            sql += "select m.id,m.title,m.content,m.message_time,m.send_id,m.receive_id,u.`realname` send_name,u.realname receive_name,m.readFlag from message m,user u where `receive_id`=? and and m.send_id=u.id message_time LIKE '" + date + "%'";
        } else if ("".equals(date) && "".equals(send_name)) {
            sql += "select m.id,m.title,m.content,m.message_time,m.send_id,m.receive_id,u.`realname` send_name,u.realname receive_name,m.readFlag from message m,user u where `receive_id`=? and m.send_id=u.id";
        } else {
            sql += "select m.id,m.title,m.content,m.message_time,m.send_id,m.receive_id,u.`realname` send_name,u.realname receive_name,m.readFlag from message m,user u where `receive_id`=? and m.send_id=u.id and u.realname like '%" + send_name + "%' and message_time LIKE '" + date + "%' ";
        }
        sql += " LIMIT ?,? ";
        return queryForList(MsgUser.class, sql, receive_id, pageNO, pageSize);
    }

    @Override
    public List<MsgUser> conditionQueryMessage(int receive_id, String readFlag, String send_name, String date, Integer pageNO, Integer pageSize) {
        String sql = "";
        if (!"".equals(send_name) && "".equals(date)) {
            sql += "select m.id,m.title,m.content,m.message_time,m.send_id,m.receive_id,u.`realname` send_name,u.realname receive_name,m.readFlag from message m,user u where `receive_id`=? and `readFlag`=? m.send_id=u.id and u.realname like '%" + send_name + "%'";
        } else if (!"".equals(date) && "".equals(send_name)) {
            sql += "select m.id,m.title,m.content,m.message_time,m.send_id,m.receive_id,u.`realname` send_name,u.realname receive_name,m.readFlag from message m,user u where `receive_id`=? and `readFlag`=? and m.send_id=u.id and message_time LIKE '" + date + "%'";
        } else if ("".equals(date) && "".equals(send_name)) {
            sql += "select m.id,m.title,m.content,m.message_time,m.send_id,m.receive_id,u.`realname` send_name,u.realname receive_name,m.readFlag from message m,user u where `receive_id`=? and `readFlag`=? and m.send_id=u.id";
        } else {
            sql += "select m.id,m.title,m.content,m.message_time,m.send_id,m.receive_id,u.`realname` send_name,u.realname receive_name,m.readFlag from message m,user u where `receive_id`=? and `readFlag`=? and m.send_id=u.id and u.realname like '%" + send_name + "%' and message_time LIKE '" + date + "%' ";
        }
        sql += " LIMIT ?,? ";
        return queryForList(MsgUser.class, sql, receive_id,readFlag, pageNO, pageSize);
    }
}
