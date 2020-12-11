package com.service;

import com.entity.Teacher;
import com.utils.Page;

/**
 * 作者：Zhh
 * 日期: 2020/12/11 14:51
 * 描述:
 */
public interface TeacherService {
    Page<Teacher> queryForPage(int pageNum, int pageSize);

    Integer deleteByUserId(int user_id);

    Integer update(Teacher teacher);

    Integer insert(Teacher teacher);
}
