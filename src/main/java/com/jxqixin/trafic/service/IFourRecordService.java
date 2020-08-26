package com.jxqixin.trafic.service;
import com.jxqixin.trafic.dto.FourRecordDto;
import com.jxqixin.trafic.model.FourRecord;
import com.jxqixin.trafic.model.Org;
import org.springframework.data.domain.Page;

public interface IFourRecordService extends ICommonService<FourRecord> {
    /**
     * 分页查询信息
     * @param fourRecordDto
     * @return
     */
    Page findFourRecords(FourRecordDto fourRecordDto, Org org);
    /**
     * 根据ID删除
     * @param id
     */
    void deleteById(String id);
}
