package com.dao.impl;

import com.dao.BaseDao;
import com.dao.NoticeDao;
import com.entity.Notice;

import java.util.List;

/**
 * 作者：ysq
 * 日期: 2020/12/9 18:31
 * 描述:
 */
public class NoticeDaoImpl extends BaseDao implements NoticeDao {
    @Override
    public Integer insert(Notice notice) {
        String sql = "insert into `notice` (`title`,`content`) values(?,?)";
        return update(sql, notice.getTitle(), notice.getContent());
    }

    @Override
    public Integer update(Notice notice) {
        String sql = "update `notice` set `title`=?,`content`=? where `id`=?";
        return update(sql, notice.getTitle(), notice.getContent(), notice.getId());
    }

    @Override
    public Integer delete(int id) {
        String sql = "delete from `notice` where `id`=?";
        return update(sql, id);
    }

    @Override
    public List<Notice> queryAll() {
        String sql = "select * from `notice`";
        return queryForList(Notice.class, sql);
    }

    @Override
    public List<Notice> queryNoticeByTitle(String title,Integer pageNO, Integer pageSize) {
        String sql = "select * from `notice` where `title` like ? LIMIT ?,?";
        return queryForList(Notice.class, sql, "%"+title+"%", (pageNO-1)*pageSize, pageSize);
    }

    @Override
    public List<Notice> queryNoticeByNoticeTime(String noticeTime,Integer pageNO, Integer pageSize) {
        String sql = "select * from `notice` where `notice_time` like ? LIMIT ?,?";
        return queryForList(Notice.class, sql,"%"+noticeTime+"%", (pageNO-1)*pageSize, pageSize);
    }

    @Override
    public List<Notice> queryNoticeByTitleAndNoticeTime(String title, String noticeTime,Integer pageNO, Integer pageSize) {
        String sql = "select * from `notice` where `title` like ? and `notice_time` like ? LIMIT ?,?";
        return queryForList(Notice.class, sql,"%"+title+"%","%"+noticeTime+"%", (pageNO-1)*pageSize, pageSize);
    }

    @Override
    public Notice queryNoticeById(int id) {
        String sql = "select * from `notice` where `id`=?";
        return queryForOne(Notice.class, sql, id);
    }

    @Override
    public Integer queryPageTotalCounts() {
        String sql = "select count(1) from notice";
        return Math.toIntExact((Long) queryForSingleValue(sql));
    }

    @Override
    public Integer queryPageTotalCountsByTitleAndNoticeTime(String title, String noticeTime) {
        String sql = "select count(1) from notice where 1=1 ";
        if (!"".equals(title)) {
            sql += " and title like '%"+title+"%'";
        }
        if (!"".equals(noticeTime)) {
            sql += " and notice_time like '%"+noticeTime+"%'";
        }

        return Math.toIntExact((Long) queryForSingleValue(sql));
    }

    @Override
    public List<Notice> queryNoticeByPage(Integer pageNO, Integer pageSize) {
        String sql = "select * from notice LIMIT ?,?";
        return queryForList(Notice.class, sql, (pageNO-1)*pageSize, pageSize);
    }
}
