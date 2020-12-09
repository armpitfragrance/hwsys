package com.dao;

import com.entity.HomeworkStu;

import java.util.List;

/**
 * 作者：Zhh
 * 日期: 2020/12/9 18:36
 * 描述:
 */
public interface HomeworkStuDao {
    //插入一条学生作业信息
    int insert(HomeworkStu homeworkStu);

    //删除一条学生作业信息
    int delete(Integer id);

    //更新一条学生作业信息
    int update(HomeworkStu homeworkStu);

    //查询所有学生作业信息
    List<HomeworkStu> queryAll();

    //根据id查询学生作业信息
    HomeworkStu queryHomeworkStuById(Integer id);

    //查询总条数
    Integer queryPageTotalCounts();

    //分页查询
    List<HomeworkStu> queryHomeworkStuByPage(int pageNo, int pageSize);
}
