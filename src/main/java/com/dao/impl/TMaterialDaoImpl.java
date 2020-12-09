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
        String sql = "INSERT INTO `t_material`(`title`,`content`,`path`,`name`,`c_id`)VALUES(?,?,?,?,?)";
        return update(sql, tMaterial.getTitle(), tMaterial.getContent(), tMaterial.getPath(), tMaterial.getName(), tMaterial.getC_id());
    }

    public int delete(Integer id) {
        String sql = "DELETE FROM `t_material` WHERE `id`=? ";
        return update(sql, id);
    }

    public int update(TMaterial tMaterial) {
        String sql = "UPDATE `t_material` SET `title`=?,`content`=?,`path`=?,`name`=?,`c_id`=? WHERE `id`=? ";
        return update(sql, tMaterial.getTitle(), tMaterial.getContent(), tMaterial.getPath(), tMaterial.getName(), tMaterial.getC_id(), tMaterial.getId());
    }

    public List<TMaterial> queryAll() {
        String sql = "SELECT `id`,`title`,`content`,`path`,`name`,`handup_time`,`c_id`,`create_time`,`update_time` FROM `t_material` ";
        return queryForList(TMaterial.class, sql);
    }

    public TMaterial queryTMaterialById(Integer id) {
        String sql = "SELECT `id`,`title`,`content`,`path`,`name`,`handup_time`,`c_id`,`create_time`,`update_time` FROM `t_material` WHERE `id`=? ";
        return queryForOne(TMaterial.class, sql, id);
    }

    public Integer queryPageTotalCounts() {
        String sql = "SELECT COUNT(1) FROM `t_material` ";
        return Math.toIntExact((Long) queryForSingleValue(sql));
    }

    public List<TMaterial> queryTMaterialByPage(int pageNo, int pageSize) {
        String sql = "SELECT `id`,`title`,`content`,`path`,`name`,`handup_time`,`c_id`,`create_time`,`update_time` FROM `t_material` LIMIT ?,? ";
        return queryForList(TMaterial.class, sql, pageNo, pageSize);
    }
}
