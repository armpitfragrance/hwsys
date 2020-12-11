package com.service;

import com.entity.Student;
import com.utils.Page;

/**
 * 作者：Zhh
 * 日期: 2020/12/10 15:46
 * 描述:
 */
public interface StudentService {
    Page<Student> queryForPage(int pageNum, int pageSize);

    Integer deleteByUserId(int user_id);

    Integer update(Student student);

    Integer insert(Student student);
}
