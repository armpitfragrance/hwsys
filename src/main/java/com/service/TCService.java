package com.service;

import com.entity.TC;

/**
 * 作者：Zhh
 * 日期: 2020/12/14 9:51
 * 描述:
 */
public interface TCService {
    TC queryTCById(Integer id);

    Integer deleteByTCId(int tc_id);

    Integer update(TC tc);

    Integer insert(TC tc);
}
