package com.dao.impl;

import com.dao.BaseDao;
import com.dao.MessageDao;
import com.entity.Message;

import java.util.List;

/**
 * 作者：ysq
 * 日期: 2020/12/9 18:22
 * 描述:
 */
public class MessageDaoImpl extends BaseDao implements MessageDao {
    @Override
    public Integer insert(Message message) {
        String sql="insert into `message` (`title`,`content`,`send_id`,`receive_id`,`readFlag`) values(?,?,?,?,?)";
        return update(sql, message.getTitle(), message.getContent(), message.getSend_id(), message.getReceive_id(),message.getReadFlag());
    }

    @Override
    public Integer update(Message message) {
        String sql = "update `message` set `title`=?,`content`=?,`send_id`=?,`receive_id`=?,`readFlag`=? where `id`=?";
        return update(sql, message.getTitle(), message.getContent(), message.getSend_id(), message.getReceive_id(),message.getReadFlag(), message.getId());
    }

    @Override
    public Integer delete(int id) {
        String sql = "delete from `message` where `id`=?";
        return update(sql, id);
    }

    @Override
    public List<Message> queryAll() {
        String sql = "select * from `message`";
        return queryForList(Message.class, sql);
    }

    @Override
    public Message queryMessageById(int id) {
        String sql = "select * from `message` where `id`=?";
        return queryForOne(Message.class, sql, id);
    }

    @Override
    public Integer queryPageTotalCounts() {
        String sql = "select count(1) from message";
        return Math.toIntExact((Long)queryForSingleValue(sql));
    }

    @Override
    public List<Message> queryMessageByPage(Integer pageNO, Integer pageSize) {
        String sql = "select * from message LIMIT ?,?";
        return queryForList(Message.class,sql,pageNO, pageSize);
    }
}
