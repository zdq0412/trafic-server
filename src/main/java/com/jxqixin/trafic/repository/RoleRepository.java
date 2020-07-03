package com.jxqixin.trafic.repository;
import com.jxqixin.trafic.model.Role;
import org.springframework.data.jpa.repository.Query;

import java.io.Serializable;
import java.util.List;

public interface RoleRepository<ID extends Serializable> extends CommonRepository<Role,ID> {
    /**
     * 根据角色名称查找角色
     * @param rolename
     * @return
     */
    @Query(value = "select r.* from Role r  where r.name=?1 and r.org_id is null",nativeQuery = true)
    Role findByName(String rolename);
    @Query(value = "select r from Role r where r.name=?1 and r.org.id=?2")
    Role findByNameAndOrgId(String name, String orgId);
    @Query(value = "select r from Role r where r.org.id=?2")
    List<Role> findAllByOrgId(String orgId);
}
