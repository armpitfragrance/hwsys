package com.service.impl;

import com.dao.UserTeacherDao;
import com.dao.impl.UserTeacherDaoImpl;
import com.entity.UserTeacher;
import com.service.UserTeacherService;
import com.utils.Page;

import java.util.List;

/**
 * 作者：Zhh
 * 日期: 2020/12/11 14:46
 * 描述:
 */
public class UserTeacherServiceImpl implements UserTeacherService {
    UserTeacherDao userTeacherDao = new UserTeacherDaoImpl();

    @Override
    public UserTeacher teacherLogin(String user_no, String password) {
        return userTeacherDao.teacherLogin(user_no, password);
    }

    @Override
    public Page<UserTeacher> queryForPage(int pageNum, int pageSize) {
        Page<UserTeacher> page = new Page<>();
        //设置当前页码
        page.setPageNum(pageNum);
        //设置每页展示的数量
        page.setPageSize(pageSize);
        //求总记录数
        Integer pageTotalCount = userTeacherDao.queryPageTotalCounts();
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
        List<UserTeacher> items = userTeacherDao.queryUserStudentByPage(begin, pageSize);
        //设置分页列表
        page.setItems(items);
        //返回page
        return page;
    }

    @Override
    public UserTeacher queryByTId(int t_id) {
        return userTeacherDao.queryByTId(t_id);
    }

    @Override
    public Page<UserTeacher> queryUserStudentByPageByRealNameOrStuNo(int pageNo, int pageSize, String realname, String stu_no) {
        Page<UserTeacher> page = new Page<>();
        //设置当前页码
        page.setPageNum(pageNo);
        //设置每页展示的数量
        page.setPageSize(pageSize);
        //求总记录数
        Integer pageTotalCount = userTeacherDao.queryPageTotalCountsByPageByRealNameOrStuNo(realname,stu_no);
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
        List<UserTeacher> items = userTeacherDao.queryUserStudentByPageByRealNameOrStuNo(begin,pageSize, realname, stu_no);
        //设置分页列表
        page.setItems(items);
        //返回page
        return page;
    }
}
