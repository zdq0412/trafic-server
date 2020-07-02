package com.jxqixin.trafic.service.impl;
import com.jxqixin.trafic.dto.NameDto;
import com.jxqixin.trafic.model.OrgCategory;
import com.jxqixin.trafic.repository.CommonRepository;
import com.jxqixin.trafic.repository.OrgCategoryFunctionsRepository;
import com.jxqixin.trafic.repository.OrgCategoryRepository;
import com.jxqixin.trafic.repository.OrgRepository;
import com.jxqixin.trafic.service.IOrgCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.thymeleaf.util.StringUtils;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class OrgCategoryServiceImpl extends CommonServiceImpl<OrgCategory> implements IOrgCategoryService {
	@Autowired
	private OrgCategoryRepository orgCategoryRepository;
	@Autowired
	private OrgRepository orgRepository;
	@Autowired
	private OrgCategoryFunctionsRepository orgCategoryFunctionsRepository;
	@Override
	public CommonRepository getCommonRepository() {
		return orgCategoryRepository;
	}

	@Override
	public OrgCategory findByName(String name) {
		return orgCategoryRepository.findByName(name);
	}

	@Override
	public void deleteById(String id) {
		//根据企业类别ID查找企业数量
		Long count = orgRepository.findCountByOrgCategoryId(id);
		if(count!=null && count>0){
			throw new RuntimeException("该类别下存在企业，删除失败!");
		}
		orgCategoryFunctionsRepository.deleteByOrgCategoryId(id);
		orgCategoryRepository.deleteById(id);
	}

	@Override
	public Page findOrgCategorys(NameDto nameDto) {
		Pageable pageable = PageRequest.of(nameDto.getPage(),nameDto.getLimit());
		return orgCategoryRepository.findAll(new Specification() {
			@Override
			public Predicate toPredicate(Root root, CriteriaQuery criteriaQuery, CriteriaBuilder criteriaBuilder) {
				List<Predicate> list = new ArrayList<>();

				if(!StringUtils.isEmpty(nameDto.getName())){
					list.add(criteriaBuilder.like(root.get("name"),"%"+nameDto.getName()+"%"));
				}

				Predicate[] predicates = new Predicate[list.size()];
				return criteriaBuilder.and(list.toArray(predicates));
			}
		}, pageable);
	}
}
