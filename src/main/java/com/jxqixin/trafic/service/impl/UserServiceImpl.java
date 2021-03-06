package com.jxqixin.trafic.service.impl;

import com.twostep.resume.dto.UserDto;
import com.twostep.resume.model.Power;
import com.twostep.resume.model.User;
import com.twostep.resume.repository.CommonRepository;
import com.twostep.resume.repository.UserRepository;
import com.twostep.resume.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.thymeleaf.util.StringUtils;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Service("userService")
@Transactional
public class UserServiceImpl extends CommonServiceImpl<User> implements IUserService {
	@Autowired
	private UserRepository userRepository;
	@Override
	public CommonRepository getCommonRepository() {
		return userRepository;
	}
	@Override
	public User login(String username, String password) {
		return userRepository.findByUsernameAndPassword(username,password);
	}
	@Override
	public User queryUserByUsername(String username) {
		return userRepository.findByUsername(username);
	}

	@Override
	public List<Object[]> queryPowersByUsername(String username) {
		return userRepository.queryPowersByUsername(username);
	}

	/**
	 * 分页查询用户信息
	 * @param userDto
	 * @return
	 */
	@Override
	public Page<User> findByPage(UserDto userDto) {
		Pageable pageable = PageRequest.of(userDto.getPage(),userDto.getLimit(), Sort.Direction.DESC,"createDate");
		return userRepository.findAll(new Specification() {
			@Override
			public Predicate toPredicate(Root root, CriteriaQuery criteriaQuery, CriteriaBuilder criteriaBuilder) {
				String username = userDto.getUsername();
				String realName = userDto.getRealName();
				String tel = userDto.getTel();
				List<Predicate> list = new ArrayList<>();
				if(!StringUtils.isEmpty(username)){
					list.add(criteriaBuilder.like(root.get("username"),"%" + username + "%"));
				}
				if(!StringUtils.isEmpty(realName)){
					list.add(criteriaBuilder.like(root.get("realName"),"%" + realName + "%"));
				}
				if(!StringUtils.isEmpty(tel)){
					list.add(criteriaBuilder.like(root.get("tel"),"%" + tel + "%"));
				}

				Predicate[] predicates = new Predicate[list.size()];
				return criteriaBuilder.and(list.toArray(predicates));
			}
		},pageable);
	}

	/**
	 * 批量删除用户
	 * @param ids
	 */
	@Override
	public void deleteBatch(String[] ids) {
		if(ids==null || ids.length<=0){
			throw new RuntimeException("没有要删除的用户!");
		}

		for (int i = 0;i<ids.length;i++){
			User user = (User) userRepository.findById(ids[i]).get();
			if(!user.getAllowDelete()){
				throw new RuntimeException("含有不允许删除的用户:" + user.getUsername());
			}

			userRepository.deleteById(ids[i]);
		}
	}

	/**
	 * 根据id删除
	 * @param id
	 */
	@Override
	public void deleteById(String id) {
		User user = (User) userRepository.findById(id).get();
		if(!user.getAllowDelete()){
			throw new RuntimeException("该用户不允许删除:" + user.getUsername());
		}

		userRepository.deleteById(id);
	}

	@Override
	public Page<User> findByPageWithoutAdmin(UserDto userDto) {
		Pageable pageable = PageRequest.of(userDto.getPage(),userDto.getLimit());
		return userRepository.findAll(new Specification() {
			@Override
			public Predicate toPredicate(Root root, CriteriaQuery criteriaQuery, CriteriaBuilder criteriaBuilder) {
				return criteriaBuilder.notEqual(root.get("username"),"admin");
			}
		}, pageable);
	}
	/**
	 * 根据角色id查找用户数
	 * @param id
	 * @return
	 */
	@Override
	public Integer findCountByRoleId(String id) {
		return userRepository.findCountByRoleId(id);
	}
}
