package com.jxqixin.trafic.service;
import com.jxqixin.trafic.dto.AccidentRecordDto;
import com.jxqixin.trafic.model.AccidentRecord;
import com.jxqixin.trafic.model.Org;
import org.springframework.data.domain.Page;

public interface IAccidentRecordService extends ICommonService<AccidentRecord> {
    /**
     * 分页查询信息
     * @param accidentRecordDto
     * @return
     */
    Page findAccidentRecords(AccidentRecordDto accidentRecordDto, Org org);
    /**
     * 根据ID删除
     * @param id
     */
    void deleteById(String id);
}
