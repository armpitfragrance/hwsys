package com.service.impl;

import com.dao.UserStudentDao;
import com.dao.impl.UserStudentDaoImpl;
import com.entity.UserStudent;
import com.service.UserStudentService;
import com.utils.Page;

import java.util.List;

/**
 * 作者：Zhh
 * 日期: 2020/12/10 17:02
 * 描述:
 */
public class UserStudentServiceImpl implements UserStudentService {
    UserStudentDao userStudentDao = new UserStudentDaoImpl();
    @Override
    public Page<UserStudent> queryForPage(int pageNum, int pageSize) {
        Page<UserStudent> page = new Page<>();
        //设置当前页码
        page.setPageNum(pageNum);
        //设置每页展示的数量
        page.setPageSize(pageSize);
        //求总记录数
        Integer pageTotalCount = userStudentDao.queryPageTotalCounts();
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
        List<UserStudent> items = userStudentDao.queryUserStudentByPage(begin, pageSize);
        //设置分页列表
        page.setItems(items);
        //返回page
        return page;
    }

    @Override
    public Page<UserStudent> queryUserStudentByPageByRealNameOrStuNo(int pageNo, int pageSize, String realname, String stu_no) {
        Page<UserStudent> page = new Page<>();
        //设置当前页码
        page.setPageNum(pageNo);
        //设置每页展示的数量
        page.setPageSize(pageSize);
        //求总记录数
        Integer pageTotalCount = userStudentDao.queryPageTotalCountsByPageByRealNameOrStuNo(realname,stu_no);
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
        int begin = (page.getPageNum() - 1) * pageSize;
        //获取分页显示的列表
        List<UserStudent> items = userStudentDao.queryUserStudentByPageByRealNameOrStuNo(begin,pageSize, realname, stu_no);
        //设置分页列表
        page.setItems(items);
        //返回page
        return page;
    }

    @Override
    public Page<UserStudent> queryUserStudentByCourseIdAndSno(int pageNo, int pageSize, Integer course_id, Integer stu_no) {
        Page<UserStudent> page = new Page<>();
        //设置当前页码
        page.setPageNum(pageNo);
        //设置每页展示的数量
        page.setPageSize(pageSize);
        //求总记录数
        Integer pageTotalCount = userStudentDao.queryPageTotalCountsByCourseIdAndSno(course_id,stu_no);
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
        List<UserStudent> items = userStudentDao.queryUserStudentByCourseIdAndSno(begin,pageSize,course_id,stu_no);
        //设置分页列表
        page.setItems(items);
        //返回page
        return page;
    }
}
