package com.jxqixin.trafic.service.impl;
import com.jxqixin.trafic.dto.NameDto;
import com.jxqixin.trafic.model.*;
import com.jxqixin.trafic.repository.CommonRepository;
import com.jxqixin.trafic.repository.MeetingRepository;
import com.jxqixin.trafic.repository.MeetingTemplateRepository;
import com.jxqixin.trafic.service.IMeetingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;
import java.util.Date;

@Service
@Transactional
public class MeetingServiceImpl extends CommonServiceImpl<Meeting> implements IMeetingService {
	@Autowired
	private MeetingRepository meetingRepository;
	@Autowired
	private MeetingTemplateRepository meetingTemplateRepository;
	@Override
	public CommonRepository getCommonRepository() {
		return meetingRepository;
	}
	@Override
	public Page findMeetings(NameDto nameDto,String type) {
		Pageable pageable = PageRequest.of(nameDto.getPage(),nameDto.getLimit(), Sort.Direction.DESC,"createDate");
		return meetingRepository.findAll(pageable);
	}

	@Override
	public void deleteById(String id) {
		meetingRepository.deleteById(id);
	}

	@Override
	public void importTemplate(String templateId, Org org,String username) {
		MeetingTemplate template = (MeetingTemplate) meetingTemplateRepository.findById(templateId).get();
		Meeting meeting = new Meeting();
		if(org!=null){
			meeting.setOrg(org);
		}
		meeting.setAttendants(template.getAttendants());
		meeting.setContent(template.getContent());
		meeting.setMeetingName(template.getMeetingName());
		meeting.setMeetingPlace(template.getMeetingPlace());
		meeting.setRecorder(template.getRecorder());
		meeting.setPresident(template.getPresident());
		meeting.setName(template.getName());
		meeting.setFinalDecision(template.getFinalDecision());
		meeting.setCreateDate(new Date());
		meeting.setCreator(username);
		meetingRepository.save(meeting);
	}
}