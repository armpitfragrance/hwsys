package com.service;

import com.entity.UserStudent;
import com.utils.Page;

/**
 * 作者：Zhh
 * 日期: 2020/12/10 17:01
 * 描述:
 */
public interface UserStudentService {
    Page<UserStudent> queryForPage(int pageNum, int pageSize);

    Page<UserStudent> queryUserStudentByPageByRealNameOrStuNo(int pageNo, int pageSize, String realname, String stu_no);
}
