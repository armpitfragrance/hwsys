package com.service;

import com.entity.TMaterial;
import com.utils.Page;

import java.util.List;

/**
 * 作者：ysq
 * 日期: 2020/12/16 15:39
 * 描述:
 */
public interface TMaterialService {
    int insert(TMaterial tMaterial);

    int delete(Integer id);

    int update(TMaterial tMaterial);

    List<TMaterial> queryAll();

    TMaterial queryTMaterialById(Integer id);

    Page<TMaterial> queryTMaterialByPage(int pageNo, int pageSize);

    Page<TMaterial> queryTMaterialByPageByCid(int c_id,String name,String date,int pageNo, int pageSize);

}
