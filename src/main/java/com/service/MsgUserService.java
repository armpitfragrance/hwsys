package com.service;

import com.entity.MsgUser;
import com.entity.User;
import com.utils.Page;

import java.util.List;

/**
 * 作者：ysq
 * 日期: 2020/12/14 10:16
 * 描述:
 */
public interface MsgUserService {
    Integer insert(MsgUser msgUser);

    Integer delete(int id);

    Integer isRead(MsgUser msgUser);

    MsgUser queryMessageById(int id);

    List<MsgUser> queryByRcvid(int receive_id);

    public Integer queryPageTotalCountsByRcvid(int receive_id);

    public Page<MsgUser> queryMessageByPageandRcvid(int receive_id, Integer pageNO, Integer pageSize);



    List<MsgUser> queryByRcvidandReadFlag(int receive_id, String readFlag);

    public Integer queryPageTotalCountsByRcvidandReadFlag(int receive_id, String readFlag);

    public Page<MsgUser> queryMessageByPageandRcvidandReadFlag(int receive_id, String readFlag, Integer pageNO, Integer pageSize);

    Integer delete(int[] ids);

    public User queryTeacher(String t_no);

    public User queryStudent(String stu_no);

    public String queryUserNo(String userid, String username);

    public Integer conditionQueryCount(int receive_id, String send_name, String date);

    public Integer conditionQueryCount(int receive_id, String readFlag, String send_name, String date);

    public Page<MsgUser> conditionQueryMessage(int receive_id, String send_name, String date, Integer pageNO, Integer pageSize);

    public Page<MsgUser> conditionQueryMessage(int receive_id, String readFlag, String send_name, String date, Integer pageNO, Integer pageSize);

}
