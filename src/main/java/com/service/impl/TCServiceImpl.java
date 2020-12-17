package com.service.impl;

import com.dao.TCDao;
import com.dao.impl.TCDaoImpl;
import com.entity.TC;
import com.service.TCService;

/**
 * 作者：Zhh
 * 日期: 2020/12/14 9:53
 * 描述:
 */
public class TCServiceImpl implements TCService {
    TCDao tcDao = new TCDaoImpl();
    @Override
    public TC queryTCById(Integer id) {
        return tcDao.queryTCById(id);
    }

    @Override
    public Integer deleteByTCId(int tc_id) {
        return tcDao.delete(tc_id);
    }

    @Override
    public Integer update(TC tc) {
        return tcDao.update(tc);
    }

    @Override
    public Integer insert(TC tc) {
        return tcDao.insert(tc);
    }

}
