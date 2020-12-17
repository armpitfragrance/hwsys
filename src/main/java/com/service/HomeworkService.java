package com.service;

import com.entity.Homework;
import com.entity.HomeworkManageInfo;
import com.utils.Page;

/**
 * 作者：youjiahao
 * 日期: 2020/12/14 19:41
 * 描述:
 */
public interface HomeworkService {
    //分页查询(if:课程id,作业名,截至提交时间)
    Page<HomeworkManageInfo> queryHomeworkByNameAndEndtime(int pageNo, int pageSize, Integer course_id, String name, String end_time);

    //根据id查询布置作业信息
    Homework queryHomeworkById(int id);

    //根据id删除作业
    int delete(int id);

    //布置作业
    int insert(Homework homework);

    //编辑作业
    int update(Homework homework);
}
