package com.service.impl;

import com.dao.impl.SCCTStuDaoImpl;
import com.entity.SC;
import com.entity.SCCTStu;
import com.service.SCCTStuService;
import com.utils.Page;

import java.util.List;

/**
 * 作者：ysq
 * 日期: 2020/12/10 18:40
 * 描述:
 */
public class SCCTStuServiceImpl implements SCCTStuService {
    SCCTStuDaoImpl scctStuDao = new SCCTStuDaoImpl();
    @Override
    public Page<SCCTStu> queryByPage(int pageNo, int pageSize) {
        Page<SCCTStu> page = new Page<>();
        page.setPageNum(pageNo);
        page.setPageSize(pageSize);

        Integer pageTotalCount = scctStuDao.queryPageTotalCounts();
        page.setPageTotalCount((pageTotalCount));

        Integer pageTotal = pageTotalCount / pageSize;
        if (pageTotalCount % pageSize > 0) {
            pageTotal += 1;
        }
        page.setPageTotal(pageTotal);
        int begin = (page.getPageNum() - 1) * pageSize;
        List<SCCTStu> items = scctStuDao.querySCCTStuByPage(begin, pageSize);
        page.setItems(items);
        return page;
    }

    @Override
    public Integer delete(Integer id) {
        return scctStuDao.delete(id);
    }

    @Override
    public Page<SCCTStu> queryByPageByNameorTid(String name, String t_id, int pageNo, int pageSize) {
        Page<SCCTStu> page = new Page<>();
        page.setPageNum(pageNo);
        page.setPageSize(pageSize);

        Integer pageTotalCount = scctStuDao.queryPageTotalCountsByNameOrTid(name, t_id);
        System.out.println(pageTotalCount);
        page.setPageTotalCount((pageTotalCount));

        Integer pageTotal = pageTotalCount / pageSize;
        if (pageTotalCount % pageSize > 0) {
            pageTotal += 1;
        }
        page.setPageTotal(pageTotal);
        int begin = (page.getPageNum() - 1) * pageSize;
        List<SCCTStu> items = scctStuDao.querySCCTStuByPageByNameorTid1(name, t_id, begin, pageSize);
        page.setItems(items);
        return page;
    }
}
