package com.jxqixin.trafic.service.impl;

import com.jxqixin.trafic.dto.NameDto;
import com.jxqixin.trafic.dto.StandardizationTemplateDto;
import com.jxqixin.trafic.model.Category;
import com.jxqixin.trafic.model.StandardizationTemplate;
import com.jxqixin.trafic.model.Org;
import com.jxqixin.trafic.model.OrgCategory;
import com.jxqixin.trafic.repository.CommonRepository;
import com.jxqixin.trafic.repository.StandardizationTemplateRepository;
import com.jxqixin.trafic.service.IStandardizationTemplateService;
import com.jxqixin.trafic.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.thymeleaf.util.StringUtils;

import javax.persistence.criteria.*;
import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class StandardizationTemplateServiceImpl extends CommonServiceImpl<StandardizationTemplate> implements IStandardizationTemplateService {
	@Autowired
	private StandardizationTemplateRepository templateRepository;
	@Override
	public CommonRepository getCommonRepository() {
		return templateRepository;
	}
	@Override
	public Page findStandardizationTemplates(StandardizationTemplateDto standardizationTemplateDto, Org org) {
		Pageable pageable = PageRequest.of(standardizationTemplateDto.getPage(),standardizationTemplateDto.getLimit(), Sort.Direction.DESC,"createDate");
		if (org == null) {
			return templateRepository.findAll(new Specification() {
				@Override
				public Predicate toPredicate(Root root, CriteriaQuery criteriaQuery, CriteriaBuilder criteriaBuilder) {
					List<Predicate> list = new ArrayList<>();
					if (!StringUtils.isEmpty(standardizationTemplateDto.getName())) {
						list.add(criteriaBuilder.like(root.get("name"), "%" + standardizationTemplateDto.getName() + "%"));
					}
					list.add(criteriaBuilder.isNull(root.get("org")));
					Predicate[] predicates = new Predicate[list.size()];
					return criteriaBuilder.and(list.toArray(predicates));
				}
			}, pageable);
		} else {
			return templateRepository.findAll(new Specification() {
				@Override
				public Predicate toPredicate(Root root, CriteriaQuery criteriaQuery, CriteriaBuilder criteriaBuilder) {

					List<Predicate> list = new ArrayList<>();
					//企业字段不为空的
					if (!StringUtils.isEmpty(standardizationTemplateDto.getName())) {
						list.add(criteriaBuilder.like(root.get("name"), "%" + standardizationTemplateDto.getName() + "%"));
					}
					Join<StandardizationTemplate, Org> orgJoin = root.join("org", JoinType.LEFT);
					list.add(criteriaBuilder.or(criteriaBuilder.equal(orgJoin.get("id"), org.getId()), criteriaBuilder.isNull(root.get("org"))));
					//企业类别
					if (org.getOrgCategory() != null) {
						Join<StandardizationTemplate, OrgCategory> orgCategoryJoin = root.join("orgCategory", JoinType.LEFT);
						list.add(criteriaBuilder.or(criteriaBuilder.isNull(root.get("orgCategory")), criteriaBuilder.equal(orgCategoryJoin.get("id"), org.getOrgCategory().getId())));
					}
					//省市区
					if (org.getProvince() != null) {
						Join<StandardizationTemplate, Category> provinceJoin = root.join("province", JoinType.LEFT);
						list.add(criteriaBuilder.or(criteriaBuilder.isNull(root.get("province")), criteriaBuilder.equal(provinceJoin.get("id"), org.getProvince().getId())));
					}
					if (org.getCity() != null) {
						Join<StandardizationTemplate, Category> cityJoin = root.join("city", JoinType.LEFT);
						list.add(criteriaBuilder.or(criteriaBuilder.isNull(root.get("city")), criteriaBuilder.equal(cityJoin.get("id"), org.getCity().getId())));
					}
					if (org.getRegion() != null) {
						Join<StandardizationTemplate, Category> regionJoin = root.join("region", JoinType.LEFT);
						list.add(criteriaBuilder.or(criteriaBuilder.isNull(root.get("region")), criteriaBuilder.equal(regionJoin.get("id"), org.getRegion().getId())));
					}
					Predicate[] predicates = new Predicate[list.size()];
					return criteriaBuilder.and(list.toArray(predicates));
				}
			}, pageable);
		}
	}

	@Override
	public void deleteById(String id) {
		StandardizationTemplate standardizationTemplate = (StandardizationTemplate) templateRepository.findById(id).get();
		if(!StringUtils.isEmpty(standardizationTemplate.getRealPath())){
			FileUtil.deleteFile(standardizationTemplate.getRealPath());
		}
		templateRepository.deleteById(id);
	}
}