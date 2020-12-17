package com.dao;

import com.entity.Homework;
import com.entity.HomeworkManageInfo;

import java.util.List;

/**
 * 作者：Zhh
 * 日期: 2020/12/9 18:33
 * 描述:
 */
public interface HomeworkDao {
    //插入一条作业信息
    int insert(Homework homework);

    //删除一条作业信息
    int delete(Integer id);

    //更新一条作业信息
    int update(Homework homework);

    //查询所有作业信息
    List<Homework> queryAll();

    //按作业名、截止日期分页查询作业信息
    List<HomeworkManageInfo> queryHomeworkByNameAndEndtime(int pageNo, int pageSize, Integer course_id, String name, String end_time);

    //根据id查询作业信息
    Homework queryHomeworkById(Integer id);

    //查询总条数
    Integer queryPageTotalCounts();

    //按作业名、截止日期分页查询总条数
    Integer queryPageTotalCountsByNameAndEndtime(Integer course_id, String name, String end_time);

    //分页查询
    List<Homework> queryHomeworkByPage(int pageNo, int pageSize);
}
