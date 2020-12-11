package com.service;

import com.entity.SC;
import com.utils.Page;

import java.util.List;

/**
 * 作者：ysq
 * 日期: 2020/12/10 15:45
 * 描述:
 */
public interface SCService {
    Page<SC> queryByPage(int pageNo, int pageSize);

    int insert(SC sc);

    int delete(int scId);

    int update(SC sc);

    List<SC> queryAll();

    SC queryByid(int scId);
}
