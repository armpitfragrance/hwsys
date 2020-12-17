package com.dao.impl;

import com.dao.BaseDao;
import com.dao.HomeworkStuDao;
import com.entity.HomeworkStu;
import com.entity.HomeworkStuManageInfo;

import java.util.List;

/**
 * 作者：Zhh
 * 日期: 2020/12/9 18:39
 * 描述:
 */
public class HomeworkStuDaoImpl extends BaseDao implements HomeworkStuDao {
    @Override
    public int insert(HomeworkStu homeworkStu) {
        String sql = "INSERT INTO `homework_stu`(`hw_id`,`stu_id`,`docu_name`,`path`,`handup_time`,`correct`,`t_id`,`score`,`correct_time`,`correct_status`)VALUES(?,?,?,?,?,?,?,?)";
        return update(sql, homeworkStu.getHw_id(), homeworkStu.getStu_id(), homeworkStu.getDocu_name(), homeworkStu.getPath(), homeworkStu.getHandup_time(), homeworkStu.getCorrect(), homeworkStu.getT_id(), homeworkStu.getScore(), homeworkStu.getCorrect_time(), homeworkStu.getCorrect_status());
    }

    @Override
    public int delete(Integer id) {
        String sql = "DELETE FROM `homework_stu` WHERE `id`=? ";
        return update(sql, id);
    }

    @Override
    public int update(HomeworkStu homeworkStu) {
        String sql = "UPDATE `homework_stu` SET `hw_id`=?,`stu_id`=?,`docu_name`=?,`path`=?,`handup_time`=?,`correct`=?,`t_id`=?,`score`=?,`correct_time`=?,`correct_status`=? WHERE `id`=? ";
        return update(sql, homeworkStu.getHw_id(), homeworkStu.getStu_id(), homeworkStu.getDocu_name(), homeworkStu.getPath(), homeworkStu.getHandup_time(), homeworkStu.getCorrect(), homeworkStu.getT_id(), homeworkStu.getScore(), homeworkStu.getCorrect_time(), homeworkStu.getCorrect_status(), homeworkStu.getId());
    }

    @Override
    public List<HomeworkStu> queryAll() {
        String sql = "SELECT * FROM `homework_stu` ";
        return queryForList(HomeworkStu.class, sql);
    }

    @Override
    public HomeworkStu queryHomeworkStuById(Integer id) {
        String sql = "SELECT * FROM `homework_stu` WHERE `id`=? ";
        return queryForOne(HomeworkStu.class, sql, id);
    }

    @Override
    public Integer queryPageTotalCounts() {
        String sql = "SELECT COUNT(1) FROM `homework_stu` ";
        return Math.toIntExact((Long) queryForSingleValue(sql));
    }

    @Override
    public Integer queryPageTotalCountsByHwNameAndEndtimeAndStatus(String hw_name, String end_time, String correct_status) {
        String sql = "SELECT count(1) FROM homework_stu hws,homework hw,student s,user su,teacher t,user tu WHERE hws.hw_id=hw.id AND hws.stu_id=s.id AND hws.t_id=t.id AND s.user_id=su.id AND t.user_id=tu.id ";
        if (!"".equals(hw_name)) {
            sql += " AND hw.name= '" + hw_name + "'";
        }
        if (!"".equals(end_time)) {
            sql += " AND hw.end_time like '%" + end_time + "%'";
        }
        if (!"".equals(correct_status)) {
            sql += " AND hws.correct_status = '" + correct_status + "'";
        }
        return Math.toIntExact((Long) queryForSingleValue(sql));
    }

    @Override
    public List<HomeworkStu> queryHomeworkStuByPage(int pageNo, int pageSize) {
        String sql = "SELECT * FROM `homework_stu` LIMIT ?,? ";
        return queryForList(HomeworkStu.class, sql, pageNo, pageSize);
    }

    @Override
    public List<HomeworkStuManageInfo> queryHomeworkStuByHwNameAndEndtimeAndStatus(int pageNo, int pageSize, String hw_name, String end_time, String correct_status) {
        String sql = "SELECT hws.id,hw.name as hw_name,s.stu_no,su.realname as stu_name,hws.docu_name,hw.end_time,hws.handup_time,tu.realname as t_name,hws.correct,hws.score,hws.correct_status as status,hws.correct_time FROM homework_stu hws,homework hw,student s,user su,teacher t,user tu WHERE hws.hw_id=hw.id AND hws.stu_id=s.id AND hws.t_id=t.id AND s.user_id=su.id AND t.user_id=tu.id ";
        if (!"".equals(hw_name)) {
            sql += " AND hw.name=? ";
        }
        if (!"".equals(end_time)) {
            sql += " AND hw.end_time like ?";
        }
        if (!"".equals(correct_status)) {
            sql += " AND hws.correct_status =?";
        }
        sql += " limit ?,?";
        if (!"".equals(hw_name) && !"".equals(end_time) && !"".equals(correct_status)) {
            return queryForList(HomeworkStuManageInfo.class, sql, hw_name, "%" + end_time + "%", correct_status, pageNo, pageSize);
        } else if ("".equals(hw_name) && !"".equals(end_time) && !"".equals(correct_status)) {
            return queryForList(HomeworkStuManageInfo.class, sql, "%" + end_time + "%", correct_status, pageNo, pageSize);
        } else if (!"".equals(hw_name) && "".equals(end_time) && !"".equals(correct_status)) {
            return queryForList(HomeworkStuManageInfo.class, sql, hw_name, correct_status, pageNo, pageSize);
        } else if (!"".equals(hw_name) && !"".equals(end_time) && "".equals(correct_status)) {
            return queryForList(HomeworkStuManageInfo.class, sql, hw_name, "%" + end_time + "%", pageNo, pageSize);
        } else if ("".equals(hw_name) && "".equals(end_time) && !"".equals(correct_status)) {
            ;
            return queryForList(HomeworkStuManageInfo.class, sql, correct_status, pageNo, pageSize);
        } else if ("".equals(hw_name) && !"".equals(end_time) && "".equals(correct_status)) {
            ;
            return queryForList(HomeworkStuManageInfo.class, sql, "%" + end_time + "%", pageNo, pageSize);
        } else if (!"".equals(hw_name) && "".equals(end_time) && "".equals(correct_status)) {
            ;
            return queryForList(HomeworkStuManageInfo.class, sql, hw_name, pageNo, pageSize);
        } else if ("".equals(hw_name) && "".equals(end_time) && "".equals(correct_status)) {
            ;
            return queryForList(HomeworkStuManageInfo.class, sql, pageNo, pageSize);
        } else {
            ;
            return null;
        }
    }
}
