package com.dao.impl;

import com.dao.BaseDao;
import com.dao.HomeworkDao;
import com.entity.Homework;
import com.entity.HomeworkManageInfo;

import java.util.List;

/**
 * 作者：Zhh
 * 日期: 2020/12/9 18:36
 * 描述:
 */
public class HomeworkDaoImpl extends BaseDao implements HomeworkDao {
    @Override
    public int insert(Homework homework) {
        String sql="INSERT INTO `homework`(`name`,`docu_name`,`path`,`t_id`,`c_id`,`end_time`)VALUES(?,?,?,?,?,?)";
        return update(sql, homework.getName(), homework.getDocu_name(), homework.getPath(), homework.getT_id(), homework.getC_id(),homework.getEnd_time());
    }

    @Override
    public int delete(Integer id) {
        String sql="DELETE FROM `homework` WHERE `id`=? ";
        return update(sql,id);
    }

    @Override
    public int update(Homework homework) {
        String sql="UPDATE `homework` SET `name`=?,`docu_name`=?,`path`=?,`t_id`=?,`c_id`=?,`end_time`=? WHERE `id`=? ";
        return update(sql,homework.getName(), homework.getDocu_name(), homework.getPath(), homework.getT_id(), homework.getC_id(),homework.getEnd_time(),homework.getId());
    }

    @Override
    public List<Homework> queryAll() {
        String sql="SELECT * FROM `homework` ";
        return queryForList(Homework.class,sql);
    }

    @Override
    public List<HomeworkManageInfo> queryHomeworkByNameAndEndtime(int pageNo, int pageSize,Integer course_id, String name, String end_time) {

        String sql="SELECT hw.id,hw.name,hw.docu_name,u.realname as t_name,c.name as c_name,hw.end_time FROM homework hw,course c,teacher t ,user u WHERE hw.c_id=c.id and hw.t_id=t.id and t.user_id=u.id AND c.id=? ";
        if(!"".equals(name)){
            sql+=" AND hw.name like ?";
        }
        if(!"".equals(end_time)){
            sql+=" AND hw.end_time like ?";
        }
        sql+=" limit ?,?";

        if(!"".equals(name)&&!"".equals(end_time)){
            return queryForList(HomeworkManageInfo.class,sql,course_id,"%"+name+"%","%"+end_time+"%",pageNo,pageSize);
        }else if(!"".equals(name)&&"".equals(end_time)){
            return queryForList(HomeworkManageInfo.class,sql,course_id,"%"+name+"%",pageNo,pageSize);
        }else if(!"".equals(end_time)&&"".equals(name)){
            return queryForList(HomeworkManageInfo.class,sql,course_id,"%"+end_time+"%",pageNo,pageSize);
        }else if("".equals(name)&&"".equals(end_time)){
            return queryForList(HomeworkManageInfo.class,sql,course_id,pageNo,pageSize);
        }else{
            return null;
        }
    }

    @Override
    public Homework queryHomeworkById(Integer id) {
        String sql="SELECT * FROM `homework` WHERE `id`=? ";
        return queryForOne(Homework.class,sql,id);
    }

    @Override
    public Integer queryPageTotalCounts() {
        String sql="SELECT COUNT(1) FROM `homework` ";
        return Math.toIntExact((Long) queryForSingleValue(sql));
    }

    @Override
    public Integer queryPageTotalCountsByNameAndEndtime(Integer course_id,String name, String end_time) {
        String sql="SELECT count(1) FROM homework hw,course c,teacher t ,user u WHERE hw.c_id=c.id and hw.t_id=t.id and t.user_id=u.id AND c.id= "+course_id;
        if(!"".equals(name)){
            sql+=" AND hw.name= '"+name+"'";
        }
        if(!"".equals(end_time)){
            sql+=" AND hw.end_time like '%"+end_time+"%'";
        }
        return Math.toIntExact((Long) queryForSingleValue(sql));
    }

    @Override
    public List<Homework> queryHomeworkByPage(int pageNo, int pageSize) {
        String sql="SELECT * FROM `homework` LIMIT ?,? ";
        return queryForList(Homework.class,sql,pageNo,pageSize);
    }
}
