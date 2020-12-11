package com.service;

import com.entity.User;

/**
 * 作者：Zhh
 * 日期: 2020/12/10 18:30
 * 描述:
 */
public interface UserService {
    Integer delete(int id);

    Integer insert(User user);

    Integer update(User user);

    Integer getMaxId();
}
