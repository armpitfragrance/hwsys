package com.dao;

import com.entity.SC;

import java.util.List;

/**
 * 作者：ysq
 * 日期: 2020/12/9 18:16
 * 描述:
 */
public interface SCDao {
    Integer insert(SC sc);

    Integer update(SC sc);

    Integer delete(int id);

    List<SC> queryAll();

    SC querySCById(int id);

    Integer queryPageTotalCounts();

    List<SC> querySCByPage(Integer pageNO, Integer pageSize);
}