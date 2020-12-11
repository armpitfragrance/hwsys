package com.service.impl;

import com.dao.NoticeDao;
import com.dao.impl.NoticeDaoImpl;
import com.entity.Notice;
import com.service.NoticeService;
import com.utils.Page;

import java.util.List;

/**
 * 作者：youjiahao
 * 日期: 2020/12/10 15:43
 * 描述:
 */
public class NoticeServiceImpl implements NoticeService {
    NoticeDao noticeDao = new NoticeDaoImpl();

    @Override
    public Integer insert(Notice notice) {
        return noticeDao.insert(notice);
    }

    @Override
    public Integer update(Notice notice) {
        return noticeDao.update(notice);
    }

    @Override
    public Integer delete(int id) {
        return noticeDao.delete(id);
    }

    @Override
    public Notice queryNoticeById(int id) {
        return noticeDao.queryNoticeById(id);
    }

    @Override
    public Page<Notice> queryByPage(int pageNo, int pageSize) {
        Page<Notice> page = new Page<>();
        //设置当前页码
        page.setPageNo(pageNo);
        //设置每页数据数量
        page.setPageSize(pageSize);
        //设置总数据数量
        int pageTotalCounts = noticeDao.queryPageTotalCounts();
        page.setPageTotalCount(Math.toIntExact(pageTotalCounts));
        //设置总页数
        int pageTotal = pageTotalCounts % pageSize > 0 ? (pageTotalCounts / pageSize + 1) : (pageTotalCounts / pageSize);
        page.setPageTotal(pageTotal);
        //设置当前页数据
        List<Notice> items = noticeDao.queryNoticeByPage(pageNo, pageSize);
        page.setItems(items);
        return page;
    }

    @Override
    public Page<Notice> queryByTitleAndTimeAndPage(String title, String time, int pageNo, int pageSize) {
        Page<Notice> page = new Page<>();
        //设置当前页码
        page.setPageNo(pageNo);
        //设置每页数据数量
        page.setPageSize(pageSize);
        //设置总数据数量
        int pageTotalCounts = noticeDao.queryPageTotalCountsByTitleAndNoticeTime(title,time);
        page.setPageTotalCount(Math.toIntExact(pageTotalCounts));
        //设置总页数
        int pageTotal = pageTotalCounts % pageSize > 0 ? (pageTotalCounts / pageSize + 1) : (pageTotalCounts / pageSize);
        page.setPageTotal(pageTotal);
        //设置当前页数据
        List<Notice> items = null;
        if (title == null && time == null) {
            items = noticeDao.queryNoticeByPage(pageNo, pageSize);
        } else if (title != null && time == null) {
            items = noticeDao.queryNoticeByTitle(title,pageNo, pageSize);
        } else if (title == null && time != null) {
            items = noticeDao.queryNoticeByNoticeTime(time,pageNo, pageSize);
        } else if (title != null && time != null) {
            items = noticeDao.queryNoticeByTitleAndNoticeTime(title, time,pageNo, pageSize);
        }
        page.setItems(items);
        return page;
    }
}
