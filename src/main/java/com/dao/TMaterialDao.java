package com.dao;

import com.entity.TMaterial;

import java.util.List;

/**
 * 作者：youjiahao
 * 日期: 2020/12/9 18:28
 * 描述:
 */
public interface TMaterialDao {
    int insert(TMaterial tMaterial);

    int delete(Integer id);

    int update(TMaterial tMaterial);

    List<TMaterial> queryAll();

    TMaterial queryTMaterialById(Integer id);

    Integer queryPageTotalCounts();//查询当前表的总记录条数

    List<TMaterial> queryTMaterialByPage(int pageNo, int pageSize);

    Integer queryPageTotalCountsByCid(int c_id);

    List<TMaterial> queryTMaterialByPageByCid(int c_id, String name, String date, int pageNo, int pageSize);


}
