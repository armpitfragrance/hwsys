package com.dao;

import com.entity.SCCTStu;

import java.util.List;

/**
 * 作者：ysq
 * 日期: 2020/12/10 16:54
 * 描述:
 */
public interface SCCTStuDao {
    Integer delete(Integer id);

    SCCTStu querySCCTStuById(int sc_id);

    Integer queryPageTotalCounts();

    List<SCCTStu> querySCCTStuByPage(Integer pageNO, Integer pageSize);

    Integer queryPageTotalCountsByNameOrTid(String name, String t_id);

    List<SCCTStu> querySCCTStuByPageByNameorTid(String name, String t_id, Integer pageNO, Integer pageSize);
    List<SCCTStu> querySCCTStuByPageByNameorTid1(String name, String t_id, Integer pageNO, Integer pageSize);
}
