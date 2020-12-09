package com.dao;

import com.entity.Message;

import java.util.List;

/**
 * 作者：ysq
 * 日期: 2020/12/9 18:04
 * 描述:
 */
public interface MessageDao {
    Integer insert(Message message);

    Integer update(Message message);

    Integer delete(int id);

    List<Message> queryAll();

    Message queryMessageById(int id);

    Integer queryPageTotalCounts();

    List<Message> queryMessageByPage(Integer pageNO, Integer pageSize);
}
