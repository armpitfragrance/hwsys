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

    //将选中某门课的信息都删除
    int deleteByCId(int c_id);
    //删除某个学生选择某门课的信息
    int deleteByCIdAndStuId(int c_id,int stu_id);

    int update(SC sc);

    List<SC> queryAll();

    SC queryByid(int scId);

    SC queryByC_idAndStu_id(int c_id,int stu_id);
}
