package com.service.impl;

import com.dao.TeacherDao;
import com.dao.impl.TeacherDaoImpl;
import com.entity.Teacher;
import com.service.TeacherService;
import com.utils.Page;

import java.util.List;

/**
 * 作者：Zhh
 * 日期: 2020/12/11 14:52
 * 描述:
 */
public class TeacherServiceImpl implements TeacherService {
    TeacherDao teacherDao = new TeacherDaoImpl();
    @Override
    public Page<Teacher> queryForPage(int pageNum, int pageSize) {
        Page<Teacher> page = new Page<>();
        //设置当前页码
        page.setPageNum(pageNum);
        //设置每页展示的数量
        page.setPageSize(pageSize);
        //求总记录数
        Integer pageTotalCount = teacherDao.queryPageTotalCounts();
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
        List<Teacher> items = teacherDao.queryTeacherByPage(begin, pageSize);
        //设置分页列表
        page.setItems(items);
        //返回page
        return page;
    }

    @Override
    public Integer deleteByUserId(int user_id) {
        return teacherDao.deleteByUserId(user_id);
    }

    @Override
    public Integer update(Teacher teacher) {
        return teacherDao.update(teacher);
    }

    @Override
    public Integer insert(Teacher teacher) {
        return teacherDao.insert(teacher);
    }
}
