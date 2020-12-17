package com.service.impl;

import com.dao.HomeworkStuDao;
import com.dao.impl.HomeworkStuDaoImpl;
import com.entity.HomeworkStu;
import com.entity.HomeworkStuManageInfo;
import com.service.HomeworkStuService;
import com.utils.Page;

import java.util.List;

/**
 * 作者：youjiahao
 * 日期: 2020/12/16 10:14
 * 描述:
 */
public class HomeworkStuServiceImpl implements HomeworkStuService {
    HomeworkStuDao homeworkStuDao = new HomeworkStuDaoImpl();

    @Override
    public HomeworkStu queryHomeworkStuById(int id) {
        return homeworkStuDao.queryHomeworkStuById(id);
    }

    @Override
    public int update(HomeworkStu homeworkStu) {
        return homeworkStuDao.update(homeworkStu);
    }

    @Override
    public Page<HomeworkStuManageInfo> queryHomeworkStuByHwNameAndEndtimeAndStatus(int pageNo, int pageSize, int course_id, String hw_name, String end_time, String correct_status) {
        Page<HomeworkStuManageInfo> page = new Page<>();
        //设置当前页码
        page.setPageNum(pageNo);
        //设置每页展示的数量
        page.setPageSize(pageSize);
        //求总记录数
        Integer pageTotalCount = homeworkStuDao.queryPageTotalCountsByHwNameAndEndtimeAndStatus(course_id, hw_name, end_time, correct_status);
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
        List<HomeworkStuManageInfo> items = homeworkStuDao.queryHomeworkStuByHwNameAndEndtimeAndStatus(begin, pageSize, course_id, hw_name, end_time, correct_status);
        //设置分页列表
        page.setItems(items);
        //返回page
        return page;
    }
}
