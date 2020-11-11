package com.jxqixin.trafic.service;

import com.jxqixin.trafic.dto.NameDto;
import com.jxqixin.trafic.dto.PositionDto;
import com.jxqixin.trafic.model.Org;
import com.jxqixin.trafic.model.Position;
import org.springframework.data.domain.Page;

import java.util.List;

public interface IPositionService extends ICommonService<Position> {
    /**分页查找职位信息
     * @param positionDto
     * @return
     */
    Page findPositions(PositionDto positionDto);

    /**
     * 根据id删除职位
     * @param id
     */
    void deleteById(String id);

    /**
     * 根据部门ID查找职位
     * @param departmentId
     * @return
     */
    List<Position> findByDepartmentId(String departmentId);
    /**
     * 为人员分配职位
     * @param positionIdArray
     * @param employeeId
     */
    void assign2Employee(String[] positionIdArray, String employeeId);

    /**
     * 查询本机构下的所有职位
     * @param org
     * @return
     */
    List<Position> findAllByOrg(Org org);
}
