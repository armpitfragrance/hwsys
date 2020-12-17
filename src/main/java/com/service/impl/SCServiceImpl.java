package com.service.impl;

import com.dao.impl.SCDaoImpl;
import com.entity.SC;
import com.service.SCService;
import com.utils.Page;

import java.util.List;

/**
 * 作者：ysq
 * 日期: 2020/12/10 15:47
 * 描述:
 */
public class SCServiceImpl implements SCService {
    SCDaoImpl scDao = new SCDaoImpl();

    @Override
    public Page<SC> queryByPage(int pageNo, int pageSize) {
        Page<SC> page = new Page<>();
        page.setPageNum(pageNo);
        page.setPageSize(pageSize);

        Integer pageTotalCount = scDao.queryPageTotalCounts();
        page.setPageTotalCount((pageTotalCount));

        Integer pageTotal = pageTotalCount / pageSize;
        if (pageTotalCount % pageSize > 0) {
            pageTotal += 1;
        }
        page.setPageTotal(pageTotal);
        int begin = (page.getPageNum() - 1) * pageSize;
        List<SC> items = scDao.querySCByPage(begin, pageSize);
        page.setItems(items);
        return page;
    }

    @Override
    public int insert(SC sc) {
        return scDao.insert(sc);
    }

    @Override
    public int delete(int scId) {
        return scDao.delete(scId);
    }

    @Override
    public int deleteByCId(int c_id) {
        return scDao.deleteByCId(c_id);
    }

    @Override
    public int update(SC sc) {
        return 0;
    }

    @Override
    public List<SC> queryAll() {
        return null;
    }

    @Override
    public SC queryByid(int scId) {
        return null;
    }

    @Override
    public SC queryByC_idAndStu_id(int c_id, int stu_id) {
        return scDao.queryByC_idAndStu_id(c_id,stu_id);
    }
}
