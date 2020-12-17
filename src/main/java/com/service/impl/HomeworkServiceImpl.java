package com.service.impl;

import com.dao.HomeworkDao;
import com.dao.impl.HomeworkDaoImpl;
import com.entity.Homework;
import com.entity.HomeworkManageInfo;
import com.service.HomeworkService;
import com.utils.Page;

import java.util.List;

/**
 * 作者：youjiahao
 * 日期: 2020/12/14 19:41
 * 描述:
 */
public class HomeworkServiceImpl implements HomeworkService {
    HomeworkDao homeworkDao = new HomeworkDaoImpl();

    @Override
    public Page<HomeworkManageInfo> queryHomeworkByNameAndEndtime(int pageNo, int pageSize, Integer course_id, String name, String end_time) {
        Page<HomeworkManageInfo> page = new Page<>();
        //设置当前页码
        page.setPageNum(pageNo);
        //设置每页展示的数量
        page.setPageSize(pageSize);
        //求总记录数
        Integer pageTotalCount = homeworkDao.queryPageTotalCountsByNameAndEndtime(course_id, name, end_time);
        //设置总记录数
        page.setPageTotalCount(pageTotalCount);
        //求总页码
        Integer pageTotal = pageTotalCount / pageSize;
        //如果总记录数除以每页显示的记录数有余数，则总页码+1
        if (pageTotalCount % pageSize > 0) {
            pageTotal += 1;
        }
        //设置总页码
        page.setPageTotal(pageTotal);
        //设置起始页
        int begin = 0;
        if (page.getPageNum() == 0) {
            begin = 0;
        } else {
            begin = (page.getPageNum() - 1) * pageSize;
        }
        //获取分页显示的列表
        List<HomeworkManageInfo> items = homeworkDao.queryHomeworkByNameAndEndtime(begin, pageSize, course_id, name, end_time);
        //设置分页列表
        page.setItems(items);
        //返回page
        return page;
    }

    @Override
    public Homework queryHomeworkById(int id) {
        return homeworkDao.queryHomeworkById(id);
    }

    @Override
    public int delete(int id) {
        return homeworkDao.delete(id);
    }

    @Override
    public int insert(Homework homework) {
        return homeworkDao.insert(homework);
    }

    @Override
    public int update(Homework homework) {
        return homeworkDao.update(homework);
    }
}
