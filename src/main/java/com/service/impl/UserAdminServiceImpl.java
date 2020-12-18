package com.service.impl;

import com.dao.AdminDao;
import com.dao.impl.AdminDaoImpl;
import com.entity.Admin;
import com.service.UserAdminService;

/**
 * 作者：ysq
 * 日期: 2020/12/17 16:55
 * 描述:
 */
public class UserAdminServiceImpl implements UserAdminService {
    AdminDaoImpl adminDao = new AdminDaoImpl();
    @Override
    public Admin Login(String user_no, String password) {
        return adminDao.login(user_no, password);
    }
}
