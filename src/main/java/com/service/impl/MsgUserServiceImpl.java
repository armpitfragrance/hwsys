package com.service.impl;

import com.dao.BaseDao;
import com.dao.MsgUserDao;
import com.dao.impl.MsgUserDaoImpl;
import com.entity.MsgUser;
import com.entity.User;
import com.service.MsgUserService;
import com.utils.Page;

import java.util.List;

/**
 * 作者：ysq
 * 日期: 2020/12/14 10:16
 * 描述:
 */
public class MsgUserServiceImpl implements MsgUserService {
    MsgUserDaoImpl msgUserDao = new MsgUserDaoImpl();
    @Override
    public Integer insert(MsgUser msgUser) {
        return msgUserDao.insert(msgUser);
    }

    @Override
    public Integer delete(int id) {
        return msgUserDao.delete(id);
    }

    @Override
    public Integer isRead(MsgUser msgUser) {
        return msgUserDao.isRead(msgUser);
    }

    @Override
    public MsgUser queryMessageById(int id) {
        return msgUserDao.queryMessageById(id);
    }

    @Override
    public List<MsgUser> queryByRcvid(int receive_id) {
        return msgUserDao.queryByRcvid(receive_id);
    }

    @Override
    public Integer queryPageTotalCountsByRcvid(int receive_id) {
        return msgUserDao.queryPageTotalCountsByRcvid(receive_id);
    }

    @Override
    public Page<MsgUser> queryMessageByPageandRcvid(int receive_id, Integer pageNO, Integer pageSize) {
        Page<MsgUser> page = new Page<>();
        //设置当前页码
        page.setPageNum(pageNO);
        //设置每页展示的数量
        page.setPageSize(pageSize);
        //求总记录数
        Integer pageTotalCount = msgUserDao.queryPageTotalCountsByRcvid(receive_id);
        //设置总记录数
        page.setPageTotalCount(pageTotalCount);
        //求总页码
        Integer pageTotal = pageTotalCount / pageSize;
        //如果总记录数除以每页显示的记录数有余数，则总页码+1
        if (pageTotalCount % pageSize > 0) {
            pageTotal += 1;
        }
        //设置总页码
        page.setPageTotal(pageTotal);
        //设置起始页
        int begin = 0;
        if (page.getPageNum() == 0) {
            begin = 0;
        } else {
            begin = (page.getPageNum() - 1) * pageSize;
        }

        //获取分页显示的列表
        List<MsgUser> items = msgUserDao.queryMessageByPageandRcvid(receive_id, begin, pageSize);
        //设置分页列表
        page.setItems(items);
        //返回page
        return page;
    }

    @Override
    public List<MsgUser> queryByRcvidandReadFlag(int receive_id, String readFlag) {
        return msgUserDao.queryByRcvidandReadFlag(receive_id, readFlag);
    }

    @Override
    public Integer queryPageTotalCountsByRcvidandReadFlag(int receive_id, String readFlag) {
        return msgUserDao.queryPageTotalCountsByRcvidandReadFlag(receive_id, readFlag);
    }

    @Override
    public Page<MsgUser> queryMessageByPageandRcvidandReadFlag(int receive_id, String readFlag, Integer pageNO, Integer pageSize) {
        Page<MsgUser> page = new Page<>();
        //设置当前页码
        page.setPageNum(pageNO);
        //设置每页展示的数量
        page.setPageSize(pageSize);
        //求总记录数
        Integer pageTotalCount = msgUserDao.queryPageTotalCountsByRcvidandReadFlag(receive_id, readFlag);
        //设置总记录数
        page.setPageTotalCount(pageTotalCount);
        //求总页码
        Integer pageTotal = pageTotalCount / pageSize;
        //如果总记录数除以每页显示的记录数有余数，则总页码+1
        if (pageTotalCount % pageSize > 0) {
            pageTotal += 1;
        }
        //设置总页码
        page.setPageTotal(pageTotal);
        //设置起始页
        int begin = 0;
        if (page.getPageNum() == 0) {
            begin = 0;
        } else {
            begin = (page.getPageNum() - 1) * pageSize;
        }

        //获取分页显示的列表
        List<MsgUser> items = msgUserDao.queryMessageByPageandRcvidandReadFlag(receive_id, readFlag, begin, pageSize);
        //设置分页列表
        page.setItems(items);
        //返回page
        return page;
    }

    @Override
    public Integer delete(int[] ids) {
        return msgUserDao.delete(ids);
    }

    @Override
    public User queryTeacher(String t_no) {
        return msgUserDao.queryTeacher(t_no);
    }

    @Override
    public User queryStudent(String stu_no) {
        return msgUserDao.queryStudent(stu_no);
    }

    @Override
    public String queryUserNo(String userid, String username) {
        return msgUserDao.queryUserNo(userid, username);
    }

    @Override
    public Integer conditionQueryCount(int receive_id, String send_name, String date) {
        return null;
    }

    @Override
    public Integer conditionQueryCount(int receive_id, String readFlag, String send_name, String date) {
        return null;
    }

    @Override
    public Page<MsgUser> conditionQueryMessage(int receive_id, String send_name, String date, Integer pageNO, Integer pageSize) {
        Page<MsgUser> page = new Page<>();
        //设置当前页码
        page.setPageNum(pageNO);
        //设置每页展示的数量
        page.setPageSize(pageSize);
        //求总记录数
        Integer pageTotalCount = msgUserDao.conditionQueryCount(receive_id, send_name, date);
        //设置总记录数
        page.setPageTotalCount(pageTotalCount);
        //求总页码
        Integer pageTotal = pageTotalCount / pageSize;
        //如果总记录数除以每页显示的记录数有余数，则总页码+1
        if (pageTotalCount % pageSize > 0) {
            pageTotal += 1;
        }
        //设置总页码
        page.setPageTotal(pageTotal);
        //设置起始页
        int begin = 0;
        if (page.getPageNum() == 0) {
            begin = 0;
        } else {
            begin = (page.getPageNum() - 1) * pageSize;
        }

        //获取分页显示的列表
        List<MsgUser> items = msgUserDao.conditionQueryMessage(receive_id, send_name, date, begin, pageSize);
        //设置分页列表
        page.setItems(items);
        //返回page
        return page;
    }

    @Override
    public Page<MsgUser> conditionQueryMessage(int receive_id, String readFlag, String send_name, String date, Integer pageNO, Integer pageSize) {
        Page<MsgUser> page = new Page<>();
        //设置当前页码
        page.setPageNum(pageNO);
        //设置每页展示的数量
        page.setPageSize(pageSize);
        //求总记录数
        Integer pageTotalCount = msgUserDao.conditionQueryCount(receive_id, readFlag, send_name, date);
        //设置总记录数
        page.setPageTotalCount(pageTotalCount);
        //求总页码
        Integer pageTotal = pageTotalCount / pageSize;
        //如果总记录数除以每页显示的记录数有余数，则总页码+1
        if (pageTotalCount % pageSize > 0) {
            pageTotal += 1;
        }
        //设置总页码
        page.setPageTotal(pageTotal);
        //设置起始页
        int begin = 0;
        if (page.getPageNum() == 0) {
            begin = 0;
        } else {
            begin = (page.getPageNum() - 1) * pageSize;
        }

        //获取分页显示的列表
        List<MsgUser> items = msgUserDao.conditionQueryMessage(receive_id, readFlag, send_name, date, begin, pageSize);
        //设置分页列表
        page.setItems(items);
        //返回page
        return page;
    }

}
