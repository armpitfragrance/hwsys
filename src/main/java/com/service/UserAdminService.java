package com.service;

import com.entity.Admin;

/**
 * 作者：ysq
 * 日期: 2020/12/17 16:41
 * 描述:
 */
public interface UserAdminService {
    Admin Login(String user_no, String password);
}
