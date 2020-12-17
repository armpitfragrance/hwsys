package com.service;

import com.entity.HomeworkStu;
import com.entity.HomeworkStuManageInfo;
import com.utils.Page;

/**
 * 作者：youjiahao
 * 日期: 2020/12/16 10:14
 * 描述:
 */
public interface HomeworkStuService {

    HomeworkStu queryHomeworkStuById(int id);

    int update(HomeworkStu homeworkStu);

    /**
     * 查询:
     * 1.初始化页面(无条件)
     * 2.按条件查询(if:作业名称、截止日期、评阅状态)
     */
    Page<HomeworkStuManageInfo> queryHomeworkStuByHwNameAndEndtimeAndStatus(int pageNo, int pageSize, int course_id, String hw_name, String end_time, String correct_status);
}
