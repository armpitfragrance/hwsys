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

    List<Notice> queryNoticeByTitle(String title,Integer pageNO, Integer pageSize);//按标题查询公告

    List<Notice> queryNoticeByNoticeTime(String noticeTime,Integer pageNO, Integer pageSize);//按发布时间查询公告

    List<Notice> queryNoticeByTitleAndNoticeTime(String title,String noticeTime,Integer pageNO, Integer pageSize);//按标题和发布时间查询公告

    Notice queryNoticeById(int id);

    Integer queryPageTotalCounts();

    Integer queryPageTotalCountsByTitleAndNoticeTime(String title,String noticeTime);

    List<Notice> queryNoticeByPage(Integer pageNO, Integer pageSize);
}
