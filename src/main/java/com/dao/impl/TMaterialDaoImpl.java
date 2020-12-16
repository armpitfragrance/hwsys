package com.dao.impl;

import com.dao.BaseDao;
import com.dao.TMaterialDao;
import com.entity.TMaterial;

import java.util.List;

/**
 * 作者：youjiahao
 * 日期: 2020/12/9 18:32
 * 描述:
 */
public class TMaterialDaoImpl extends BaseDao implements TMaterialDao {
    public int insert(TMaterial tMaterial) {
        String sql = "INSERT INTO `t_material`(`name`,`path`,`c_id`)VALUES(?,?,?)";
        return update(sql, tMaterial.getName(), tMaterial.getPath(), tMaterial.getC_id());
    }

    public int delete(Integer id) {
        String sql = "DELETE FROM `t_material` WHERE `id`=? ";
        return update(sql, id);
    }

    public int update(TMaterial tMaterial) {
        String sql = "UPDATE `t_material` SET `name`=?,`path`=?,`c_id`=? WHERE `id`=? ";
        return update(sql, tMaterial.getName(), tMaterial.getPath(), tMaterial.getC_id(), tMaterial.getId());
    }

    public List<TMaterial> queryAll() {
        String sql = "SELECT `id`,`name`,`path`,`handup_time`,`c_id`,`create_time`,`update_time` FROM `t_material` ";
        return queryForList(TMaterial.class, sql);
    }

    public TMaterial queryTMaterialById(Integer id) {
        String sql = "SELECT `id`,`name`,`path`,`handup_time`,`c_id`,`create_time`,`update_time` FROM `t_material` WHERE `id`=? ";
        return queryForOne(TMaterial.class, sql, id);
    }

    public Integer queryPageTotalCounts() {
        String sql = "SELECT COUNT(1) FROM `t_material` ";
        return Math.toIntExact((Long) queryForSingleValue(sql));
    }

    public List<TMaterial> queryTMaterialByPage(int pageNo, int pageSize) {
        String sql = "SELECT `id`,`name`,`path`,`handup_time`,`c_id`,`create_time`,`update_time` FROM `t_material` LIMIT ?,? ";
        return queryForList(TMaterial.class, sql, pageNo, pageSize);
    }

    @Override
    public Integer queryPageTotalCountsByCid(int c_id) {
        String sql = "SELECT COUNT(1) FROM `t_material` where c_id=?";
        return Math.toIntExact((Long) queryForSingleValue(sql, c_id));
    }

    @Override
    public List<TMaterial> queryTMaterialByPageByCid(int c_id, String name, String date, int pageNo, int pageSize) {
        String sql = "SELECT `id`,`name`,`path`,`handup_time`,`c_id`,`create_time`,`update_time` FROM `t_material` where c_id=?";
        if (!"".equals(name) && !"".equals(date)) {
            sql += " and name like '%" + name + "%'";
            sql += " and handup_time like '%" + date + "%'";
        } else if (!"".equals(name) && "".equals(date)) {
            sql += " and name like '%" + name + "%'";
        } else if ("".equals(name) && !"".equals(date)) {
            sql += " and handup_time like '%" + date + "%'";
        }
        sql += " LIMIT ?,?";
        return queryForList(TMaterial.class, sql, c_id, pageNo, pageSize);
    }
}
