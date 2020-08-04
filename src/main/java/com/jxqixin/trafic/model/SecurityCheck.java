package com.jxqixin.trafic.model;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;
/**
 * 安全检查记录
 */
@Entity
@Table(name = "m023_security_check")
@GenericGenerator(name="id_gen",strategy = "uuid")
public class SecurityCheck {
	@Id
	@GeneratedValue(generator = "id_gen")
	private String id;
	/**名称*/
	private String name;
	/**检查对象*/
	private String checkObject;
	/**监督检查的部门及人员*/
	private String deptAndEmp;
	/**检查的内容*/
	private String content;
	/**提出的问题*/
	private String problems;
	/**整改结果*/
	private String result;
	/**检查组处理意见*/
	private String suggestion ;
	/**整改结果确认人签字*/
	private String confirmerSign;
	/**检查人员签字,以后可能为签字图片路径*/
	private String supervisorsSign;
	/**受检查对象签字,以后可能为签字图片路径*/
	private String checkedObjectSign;
	/**创建日期*/
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date createDate;
	/**安全检查日期*/
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date checkDate;
	/**创建人*/
	private String creator;
	/**备注*/
	private String note;
	/**签名文件访问路径*/
	private String url;
	/**签名文件实际路径*/
	private String realPath;
	@ManyToOne
	@JoinColumn(name="org_id",foreignKey = @ForeignKey(ConstraintMode.NO_CONSTRAINT))
	@NotFound(action = NotFoundAction.IGNORE)
	private Org org;

	public String getConfirmerSign() {
		return confirmerSign;
	}

	public void setConfirmerSign(String confirmerSign) {
		this.confirmerSign = confirmerSign;
	}

	public String getSuggestion() {
		return suggestion;
	}

	public void setSuggestion(String suggestion) {
		this.suggestion = suggestion;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getRealPath() {
		return realPath;
	}

	public void setRealPath(String realPath) {
		this.realPath = realPath;
	}

	public Org getOrg() {
		return org;
	}

	public void setOrg(Org org) {
		this.org = org;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCheckObject() {
		return checkObject;
	}

	public void setCheckObject(String checkObject) {
		this.checkObject = checkObject;
	}

	public String getDeptAndEmp() {
		return deptAndEmp;
	}

	public void setDeptAndEmp(String deptAndEmp) {
		this.deptAndEmp = deptAndEmp;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getProblems() {
		return problems;
	}

	public void setProblems(String problems) {
		this.problems = problems;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getSupervisorsSign() {
		return supervisorsSign;
	}

	public void setSupervisorsSign(String supervisorsSign) {
		this.supervisorsSign = supervisorsSign;
	}

	public String getCheckedObjectSign() {
		return checkedObjectSign;
	}

	public void setCheckedObjectSign(String checkedObjectSign) {
		this.checkedObjectSign = checkedObjectSign;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getCheckDate() {
		return checkDate;
	}

	public void setCheckDate(Date checkDate) {
		this.checkDate = checkDate;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}
}