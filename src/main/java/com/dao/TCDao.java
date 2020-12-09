package com.dao;

import com.entity.TC;

import java.util.List;

/**
 * 作者：youjiahao
 * 日期: 2020/12/9 18:27
 * 描述:
 */
public interface TCDao {
    int insert(TC tc);

    int delete(Integer id);

    int update(TC tc);

    List<TC> queryAll();

    TC queryTCById(Integer id);

    Integer queryPageTotalCounts();//查询当前表的总记录条数

    List<TC> queryTCByPage(int pageNo, int pageSize);
}
