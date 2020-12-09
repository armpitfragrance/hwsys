package com.dao.impl;

import com.dao.BaseDao;
import com.dao.HomeworkStuDao;
import com.entity.HomeworkStu;

import java.util.List;

/**
 * 作者：Zhh
 * 日期: 2020/12/9 18:39
 * 描述:
 */
public class HomeworkStuDaoImpl extends BaseDao implements HomeworkStuDao {
    @Override
    public int insert(HomeworkStu homeworkStu) {
        String sql="INSERT INTO `homework_stu`(`hw_id`,`stu_id`,`handup_time`,`end_time`,`correct`,`t_id`,`correct_time`,`correct_status`)VALUES(?,?,?,?,?,?,?,?)";
        return update(sql,homeworkStu.getHw_id(),homeworkStu.getStu_id(),homeworkStu.getHandup_time(),homeworkStu.getEnd_time(),homeworkStu.getCorrect(),homeworkStu.getT_id(),homeworkStu.getCorrect_time(),homeworkStu.getCorrect_status());
    }

    @Override
    public int delete(Integer id) {
        String sql="DELETE FROM `homework_stu` WHERE `id`=? ";
        return update(sql,id);
    }

    @Override
    public int update(HomeworkStu homeworkStu) {
        String sql="UPDATE `homework_stu` SET `hw_id`=?,`stu_id`=?,`handup_time`=?,`end_time`=?,`correct`=?,`t_id`=?,`correct_time`=?,`correct_status`=? WHERE `id`=? ";
        return update(sql,homeworkStu.getHw_id(),homeworkStu.getStu_id(),homeworkStu.getHandup_time(),homeworkStu.getEnd_time(),homeworkStu.getCorrect(),homeworkStu.getT_id(),homeworkStu.getCorrect_time(),homeworkStu.getCorrect_status(),homeworkStu.getId());
    }

    @Override
    public List<HomeworkStu> queryAll() {
        String sql="SELECT * FROM `homework_stu` ";
        return queryForList(HomeworkStu.class,sql);
    }

    @Override
    public HomeworkStu queryHomeworkStuById(Integer id) {
        String sql="SELECT * FROM `homework_stu` WHERE `id`=? ";
        return queryForOne(HomeworkStu.class,sql,id);
    }

    @Override
    public Integer queryPageTotalCounts() {
        String sql="SELECT COUNT(1) FROM `homework_stu` ";
        return Math.toIntExact((Long) queryForSingleValue(sql));
    }

    @Override
    public List<HomeworkStu> queryHomeworkStuByPage(int pageNo, int pageSize) {
        String sql="SELECT * FROM `homework_stu` LIMIT ?,? ";
        return queryForList(HomeworkStu.class,sql,pageNo,pageSize);
    }

}
