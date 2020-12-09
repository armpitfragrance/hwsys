package com.dao;

import com.entity.Notice;
import com.entity.Notice;

import java.util.List;

/**
 * 作者：ysq
 * 日期: 2020/12/9 18:13
 * 描述:
 */
public interface NoticeDao {
    Integer insert(Notice notice);

    Integer update(Notice notice);

    Integer delete(int id);

    List<Notice> queryAll();

    Notice queryNoticeById(int id);

    Integer queryPageTotalCounts();

    List<Notice> queryNoticeByPage(Integer pageNO, Integer pageSize);
}
