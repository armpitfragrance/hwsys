package com.service;

import com.entity.UserTeacher;
import com.utils.Page;

/**
 * 作者：Zhh
 * 日期: 2020/12/11 14:46
 * 描述:
 */
public interface UserTeacherService {
    Page<UserTeacher> queryForPage(int pageNum, int pageSize);

    Page<UserTeacher> queryUserStudentByPageByRealNameOrStuNo(int pageNo, int pageSize, String realname, String stu_no);
}
