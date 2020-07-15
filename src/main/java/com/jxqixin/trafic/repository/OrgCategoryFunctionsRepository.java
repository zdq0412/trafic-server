package com.jxqixin.trafic.repository;
import com.jxqixin.trafic.model.OrgCategoryFunctions;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.io.Serializable;
import java.util.List;

public interface OrgCategoryFunctionsRepository<ID extends Serializable> extends CommonRepository<OrgCategoryFunctions,ID> {
    /**
     * 根据企业类别ID删除
     * @param id 企业类别ID
     */
    @Modifying
    @Query(nativeQuery = true,value = "delete from org_category_functions " +
            " where org_category_id=?1")
    void deleteByOrgCategoryId(String id);
    @Query(nativeQuery = true,value="select ocf.function_id from org_category_functions ocf where ocf.org_category_id=?1")
    List<String> findFunctionIdsByOrgCategoryId(String orgCategoryId);
}