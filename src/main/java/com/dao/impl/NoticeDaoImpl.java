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
        String sql="insert into `notice` (`title`,`content`) values(?,?)";
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
    public Notice queryNoticeById(int id) {
        String sql = "select * from `notice` where `id`=?";
        return queryForOne(Notice.class, sql, id);
    }

    @Override
    public Integer queryPageTotalCounts() {
        String sql = "select count(1) from notice";
        return Math.toIntExact((Long)queryForSingleValue(sql));
    }

    @Override
    public List<Notice> queryNoticeByPage(Integer pageNO, Integer pageSize) {
        String sql = "select * from notice LIMIT ?,?";
        return queryForList(Notice.class,sql,pageNO, pageSize);
    }
}
