package com.service.impl;

import com.dao.impl.TMaterialDaoImpl;
import com.entity.TMaterial;
import com.service.TMaterialService;
import com.utils.Page;

import java.util.List;

/**
 * 作者：ysq
 * 日期: 2020/12/16 15:40
 * 描述:
 */
public class TMaterialServiceImpl implements TMaterialService {
    TMaterialDaoImpl tMaterialDao = new TMaterialDaoImpl();
    @Override
    public int insert(TMaterial tMaterial) {
        return tMaterialDao.insert(tMaterial);
    }

    @Override
    public int delete(Integer id) {
        return tMaterialDao.delete(id);
    }

    @Override
    public int update(TMaterial tMaterial) {
        return tMaterialDao.update(tMaterial);
    }

    @Override
    public List<TMaterial> queryAll() {
        return tMaterialDao.queryAll();
    }

    @Override
    public TMaterial queryTMaterialById(Integer id) {
        return tMaterialDao.queryTMaterialById(id);
    }

    @Override
    public Page<TMaterial> queryTMaterialByPage(int pageNo, int pageSize) {
        Page<TMaterial> page = new Page<>();
        //设置当前页码
        page.setPageNum(pageNo);
        //设置每页数据数量
        page.setPageSize(pageSize);
        //设置总数据数量
        int pageTotalCounts = tMaterialDao.queryPageTotalCounts();
        page.setPageTotalCount(Math.toIntExact(pageTotalCounts));
        //设置总页数
        int pageTotal = pageTotalCounts % pageSize > 0 ? (pageTotalCounts / pageSize + 1) : (pageTotalCounts / pageSize);
        page.setPageTotal(pageTotal);
        //设置当前页数据
        List<TMaterial> items = tMaterialDao.queryTMaterialByPage(pageNo, pageSize);
        page.setItems(items);
        return page;
    }

    @Override
    public Page<TMaterial> queryTMaterialByPageByCid(int c_id,String name,String date, int pageNo, int pageSize) {
        Page<TMaterial> page = new Page<>();
        //设置当前页码
        page.setPageNum(pageNo);
        //设置每页数据数量
        page.setPageSize(pageSize);
        //设置总数据数量
        int pageTotalCounts = tMaterialDao.queryPageTotalCountsByCid(c_id);
        page.setPageTotalCount(Math.toIntExact(pageTotalCounts));
        //设置总页数
        int pageTotal = pageTotalCounts % pageSize > 0 ? ((pageTotalCounts / pageSize) + 1) : (pageTotalCounts / pageSize);
        page.setPageTotal(pageTotal);
        int begin = 0;
        if (page.getPageNum() == 0) {
            begin = 0;
        } else {
            begin = (page.getPageNum() - 1) * pageSize;
        }
        //设置当前页数据
        List<TMaterial> items = tMaterialDao.queryTMaterialByPageByCid(c_id, name, date, begin, pageSize);
//        if (title == null && time == null) {
//            items = noticeDao.queryNoticeByPage(begin, pageSize);
//        } else if (title != null && time == null) {
//            items = noticeDao.queryNoticeByTitle(title,begin, pageSize);
//        } else if (title == null && time != null) {
//            items = noticeDao.queryNoticeByNoticeTime(time,begin, pageSize);
//        } else if (title != null && time != null) {
//            items = noticeDao.queryNoticeByTitleAndNoticeTime(title, time,begin, pageSize);
//        }
        page.setItems(items);
        return page;
    }
}
