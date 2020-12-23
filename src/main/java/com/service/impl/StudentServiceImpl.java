package com.service.impl;

import com.dao.StudentDao;
import com.dao.impl.StudentDaoImpl;
import com.entity.Student;
import com.service.StudentService;
import com.utils.Page;

import java.util.List;

/**
 * 作者：Zhh
 * 日期: 2020/12/10 15:46
 * 描述:
 */
public class StudentServiceImpl implements StudentService {
    StudentDao studentDao = new StudentDaoImpl();
    @Override
    public Page<Student> queryForPage(int pageNum, int pageSize) {
        Page<Student> page = new Page<>();
        //设置当前页码
        page.setPageNum(pageNum);
        //设置每页展示的数量
        page.setPageSize(pageSize);
        //求总记录数
        Integer pageTotalCount = studentDao.queryPageTotalCounts();
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
        List<Student> items = studentDao.queryStudentByPage(begin, pageSize);
        //设置分页列表
        page.setItems(items);
        //返回page
        return page;
    }

    @Override
    public Integer deleteByUserId(int user_id) {
        return studentDao.deleteByUserId(user_id);
    }

    @Override
    public Integer update(Student student) {
        return studentDao.update(student);
    }

    @Override
    public Integer insert(Student student) {
        return studentDao.insert(student);
    }

    @Override
    public Student queryStudentByStu_no(int stu_no) {
        return studentDao.queryStudentByStu_no(stu_no);
    }

    @Override
    public Integer unique(int stu_no) {
        return studentDao.querySnoCounts(stu_no);
    }

}
