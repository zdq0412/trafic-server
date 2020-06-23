package com.jxqixin.trafic.repository;
import com.jxqixin.trafic.model.Functions;
import org.springframework.data.jpa.repository.Query;
import java.io.Serializable;
import java.util.List;
public interface FunctionsRepository<ID extends Serializable> extends CommonRepository<Functions,ID> {
    @Query("select p from Functions p where p.parent is null")
    List<Functions> queryTopFunctions();
    @Query("select p from Functions p where p.parent.id=?1")
    List<Functions> findByParentId(String id);
    @Query("select rp.functions from RoleFunctions rp where rp.role.name=?1")
    List<Functions> queryByRoleName(String roleName);

    /**
     * 根据目录ID和当前用户名查找菜单
     * @param id 目录ID，Directory的ID
     * @param username 当前登录的用户名
     * @return
     */
    @Query(nativeQuery = true,value="select f0.* from functions f0 " +
            " inner join role_functions rf on f0.id=rf.function_id " +
            " inner join Role r on rf.role_id = r.id " +
            " inner join T_USER u on r.id=u.role_id  where u.username=?2 and f0.id in (" +
            "select f.id from functions f " +
            " inner join directory_functions df on df.function_id=f.id " +
            " inner join directory d on df.directory_id=d.id where d.id=?1 and f.type='1')")
    List<Functions> findByDirIdAndUsername(String id, String username);

    /**
     * 查找菜单：具有企业类别
     * @param id
     * @param username
     * @return
     */
    @Query(nativeQuery = true,value="select f0.* from functions f0 " +
            " inner join role_functions rf on f0.id=rf.function_id " +
            " inner join Role r on rf.role_id = r.id " +
            " inner join T_USER u on r.id=u.role_id  where u.username=?2 and f0.id in (" +

            "select f.id from functions f " +
            " inner join directory_functions df on df.function_id=f.id " +
            " inner join directory d on df.directory_id=d.id where d.id=?1 and f.type='1') " +
            " and f0.id in (" +
            "select f1.id from functions f1 inner join org_category_functions ocf on f1.id=ocf.function_id " +
            " inner join org_category oc on oc.id=ocf.org_category_id " +
            " where oc.id=?3)")
    List<Functions> findFunctions(String id, String username ,String orgCategoryId);
}
