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

    Integer deleteByCId(int c_id);

    List<SC> queryAll();

    SC querySCById(int id);

    SC queryByC_idAndStu_id(int c_id,int stu_id);

    Integer queryPageTotalCounts();

    List<SC> querySCByPage(Integer pageNO, Integer pageSize);
}
