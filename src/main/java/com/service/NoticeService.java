package com.service;

import com.entity.Notice;
import com.utils.Page;

/**
 * 作者：youjiahao
 * 日期: 2020/12/10 15:43
 * 描述:
 */
public interface NoticeService {

    Integer insert(Notice notice);//发布公告

    Integer update(Notice notice);//编辑公告

    Integer delete(int id);//删除公告

    Notice queryNoticeById(int id);//根据id查询公告

    Page<Notice> queryByPage(int pageNo, int pageSize);

    Page<Notice> queryByTitleAndTimeAndPage(String title,String time,int pageNo, int pageSize);
}
