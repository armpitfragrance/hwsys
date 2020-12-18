package com.service;

import com.entity.SCCTStu;
import com.utils.Page;

/**
 * 作者：ysq
 * 日期: 2020/12/10 18:40
 * 描述:
 */
public interface SCCTStuService {
    Page<SCCTStu> queryByPage(int pageNo, int pageSize);

    Integer delete(Integer id);

    Page<SCCTStu> queryByPageByNameorTid(String name, String t_id, int pageNo, int pageSize);

    Page<SCCTStu> queryByPageByNameorStuId(String name, String stu_id, int pageNo, int pageSize);

}
