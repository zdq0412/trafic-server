
#企业类别表
drop table if exists org_category;
create table org_category(
  id varchar(36) primary  key comment '主键',
  name varchar(20) comment '企业类别名称',
  note varchar(2000) comment '类别描述',
  safetyCostRatio  float  comment '安全生产费用  提取百分比',
  deleted bit default 0 comment '删除标识',
  createDate datetime  comment '创建日期'
) comment '企业类别表';

#区域信息表
drop table if exists category;
create table category(
  id varchar(36) primary key comment '主键',
  name varchar(50) not null comment '区域名称',
  pid varchar(36) comment '父类ID',
  createDate datetime  comment '创建日期',
  note varchar(2000) comment '区域描述',
  type varchar(50) comment '类型',
  deleted bit default 0 comment '删除标识',
  constraint fk_category foreign key(pid) references category(id)
) comment '区域信息表';

#企业信息表
drop table if exists org;
create table org(
  id varchar(36) primary key comment '主键',
  code varchar(50)  comment '机构代码',
  name varchar(50) not null comment '机构名称',
  contact varchar(50) comment '联系人',
  tel varchar(20) comment '联系方式',
  addr varchar(200)  comment '企业地址',
  legalPerson varchar(30) comment '法人',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  createDate datetime  comment '创建日期',
  status char(1) default '0' comment '状态，0：正常，1：禁用，2：删除',
  note varchar(2000) comment '企业描述',
  org_category_id varchar(36) comment '企业类别ID',

  established_time datetime comment '成立日期',
  business_scope varchar(2000) comment '经营范围',
  email varchar(100) comment '邮箱',
  introduction text comment '企业介绍',
  report_tel varchar(20) comment '举报电话',

  fourColorPicUrl varchar(100) comment '四色图访问路径',
  fourColorPicRealPath varchar(100) comment '四色图磁盘路径',

  shortName varchar(50) comment '简称',
  constraint fk_org_category_province_id foreign key(province_id) references category(id),
  constraint fk_org_category_city_id foreign key(city_id) references category(id),
  constraint fk_org_category_region_id foreign key(region_id) references category(id),
  constraint fk_org_category_id_org foreign key(org_category_id) references org_category(id)
) comment '企业信息表';

#危险源清单
drop table if exists m037_hazard_sources_list;
create table m037_hazard_sources_list(
 id varchar(36) primary key comment 'ID主键',
  name varchar(50) not null comment '危险源名称',
  happen integer comment '发生可能性',
  consequence integer comment '后果严重性',
  criterion integer comment '判定准则',
  riskLevel varchar(100) comment '安全风险等级',
  fourColor varchar(50) comment '四色标识',
  measures varchar(2000) comment '应采取的行动/控制措施',
  timeLimit varchar(200) comment '实施期限',
  createDate datetime comment '创建日期',
  org_id varchar(36) not null comment '所属企业ID',
  constraint fkm037_hazard_sources_list_org_id foreign key(org_id) references org(id)
) comment '危险源清单';

#法律法规文件
drop table if exists m004_law;
create table m004_law(
 id varchar(36) primary key comment 'ID主键',
  name varchar(1000) not null comment '法律法规文件名称',
  content text comment '法律法规内容',
  publishDate datetime comment '发布日期',
  implementDate datetime comment '实施日期',
  publishDepartment varchar(100) comment '发文部门',
  note varchar(2000) comment '备注',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  orgCategory_id varchar(36) comment '企业类别',
  num varchar(500) comment '发文字号:企业简称+年+自增序号',
  org_id varchar(36) comment '所属企业ID',
  timeliness varchar(20) default '有效' comment '时效性，有效或无效',
  constraint fk_m004_law_category_province_id foreign key(province_id) references category(id),
  constraint fk_m004_law_category_city_id foreign key(city_id) references category(id),
  constraint fk_m004_law_category_region_id foreign key(region_id) references category(id),
  constraint fk_m004_law_org_id foreign key(org_id) references org(id),
  constraint fk_m004_law_orgCategory_id foreign key(orgCategory_id) references org_category(id)
) comment '法律法规文件';

#企业制度
drop table if exists m005_rules;
create table m005_rules(
 id varchar(36) primary key comment 'ID主键',
  name varchar(1000) not null comment '安全规章制度文件名称',
  content text comment '安全规章制度内容',
  publishDate datetime comment '发布日期',
  publishDepartment varchar(100) comment '发文部门',
  note varchar(2000) comment '备注',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  orgCategory_id varchar(36) comment '企业类别',
  num varchar(500) comment '发文字号:企业简称+年+自增序号',
  url varchar(200) comment '安全规章制度文件访问路径',
  realPath varchar(200) comment '安全规章制度存储路径',
  org_id varchar(36)  comment '所属企业ID',
  timeliness varchar(20) default '有效' comment '时效性，有效或无效',
  constraint fk_m005_rules_category_province_id foreign key(province_id) references category(id),
  constraint fk_m005_rules_category_city_id foreign key(city_id) references category(id),
  constraint fk_m005_rules_category_region_id foreign key(region_id) references category(id),
  constraint fk_m005_rules_org_id foreign key(org_id) references org(id),
  constraint fk_m005_rules_orgCategory_id foreign key(orgCategory_id) references org_category(id)
) comment '安全规章制度';

#企业发文通知
drop table if exists m006_notice;
create table m006_notice(
 id varchar(36) primary key comment 'ID主键',
  name varchar(1000) not null comment '企业发文通知名称',
  content text comment '企业发文通知内容',
  publishDate datetime comment '发布日期',
  publishDepartment varchar(100) comment '发文部门',
  note varchar(2000) comment '备注',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  orgCategory_id varchar(36) comment '企业类别',
  num varchar(500) comment '发文字号:企业简称+年+自增序号',
  org_id varchar(36)  comment '所属企业ID',
  law_id varchar(36) comment '法律法规id',
  rules_id varchar(36) comment '企业规章制度id',
  timeliness varchar(20) default '有效' comment '时效性，有效或无效',
  constraint fk_m006_notice_m005_rules_rules_id foreign key(rules_id) references m005_rules(id),
  constraint fk_m006_notice_m004_law_law_id foreign key(law_id) references m004_law(id),
  constraint fk_m006_notice_category_province_id foreign key(province_id) references category(id),
  constraint fk_m006_notice_category_city_id foreign key(city_id) references category(id),
  constraint fk_m006_notice_category_region_id foreign key(region_id) references category(id),
  constraint fk_m006_notice_org_id foreign key(org_id) references org(id),
  constraint fk_m006_notice_orgCategory_id foreign key(orgCategory_id) references org_category(id)
) comment '企业发文通知';


#企业图片
drop table if exists m001_org_img;
create table m001_org_img(
 id varchar(36) primary key comment 'ID主键',
  name varchar(50) not null comment '图片名称',
  url varchar(200) comment '资质文件路径',
  realPath varchar(200) comment '实际路径',
  uploadDate datetime comment '上传日期',
  org_id varchar(36) not null comment '所属企业ID',
  constraint fk_m001_org_img_org_id foreign key(org_id) references org(id)
) comment '企业图片';

#安全规章制度模板
drop table if exists m041_ruleTemplate;
create table m041_ruleTemplate(
 id varchar(36) primary key comment 'ID主键',
  name varchar(50) not null comment '模板名称',
  content text comment '模板内容',
  createDate datetime  comment '创建时间',
  creator varchar(50) comment '创建人用户名',
  note varchar(2000) comment '备注',
   url varchar(500) comment '签名文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  org_category_id varchar(36) comment '企业类别',
  org_id varchar(36) comment '企业ID',
   constraint fk_m041_template_org_org_id foreign key(org_id) references org(id),
  constraint fk_m041_template_category_province_id foreign key(province_id) references category(id),
  constraint fk_m041_template_category_city_id foreign key(city_id) references category(id),
  constraint fk_m041_template_category_region_id foreign key(region_id) references category(id),
  constraint fk_org_category_m041_template foreign key(org_category_id) references org_category(id)
) comment '安全规章制度模板';

#安全生产费用支出类别
drop table if exists m019_safety_investment_category;
create table m019_safety_investment_category(
 id varchar(36) primary key comment 'ID主键',
  serialNo varchar(10) not null comment '类别序号',
  name varchar(500) comment ' 类别名称'
) comment '安全生产费用支出类别';

#年度安全生产费用
drop table if exists m019_safety_production_cost;
create table m019_safety_production_cost(
 id varchar(36) primary key comment 'ID主键',
  safetyYear int  comment '年度',
  lastYearActualIncome decimal(15,3) default 0.00  comment '上年度实际营业收入',
  currentYearCost decimal(15,3) default 0.00   comment '本年度应提取的安全费用,计算：通过上年度营业收入计算，普货：1%，客运和威货：1.5%',
  lastYearCarryCost decimal(15,3) default 0.00  comment '上年度结转安全费用',
  currentYearActualCost decimal(15,3) default 0.00  comment '本年度实际可用安全费用，计算：本年度应提取+上年度结转',
  unit varchar(20) default '元' comment '费用单位',
  createDate TIMESTAMP comment '创建日期',
  org_id varchar(36) comment '所属企业ID',
  isFillIn bit default 0 comment '是否已填写安全生产费用使用计划',
  constraint fk_m019_safety_production_cost_org_org_id foreign  key(org_id) references org(id)
) comment '年度安全生产费用';

#年度安全生产费用使用计划
drop table if exists m019_safety_production_cost_plan;
create table m019_safety_production_cost_plan(
 id varchar(36) primary key comment 'ID主键',
 serialNo varchar(20) not null comment '序号',
 name varchar(500) comment '名称',
 planCost decimal(15,3) default 0.00 comment '计划金额',
 safety_production_cost_id varchar(36),
 constraint fk_m019_safety_production_cost_plan_safety_production_cost_id foreign key(safety_production_cost_id) references m019_safety_production_cost(id)
) comment '年度安全生产费用使用计划';

#年度安全生产费用使用明细
drop table if exists m019_safety_production_cost_plan_detail;
create table m019_safety_production_cost_plan_detail(
 id varchar(36) primary key comment 'ID主键',
 billingDate datetime comment '开票日期',
 createDate datetime comment '创建日期',
 content varchar(2000) comment '内容摘要',
 sumOfMoney decimal(15,3) default 0.00 comment '金额',
 billNo varchar(100) comment '票据号码',
 operator varchar(500) comment '经办人',
 note varchar(2000) comment '备注',
 org_id varchar(36) comment '所属企业ID',
 url varchar(200) comment '文件访问路径',
 realPath varchar(200) comment '文件存储路径',
 plan_id varchar(36) comment '年度安全生产费用使用计划id',
 constraint fk_m019_safety_production_cost_plan_plan_id foreign key(plan_id) references m019_safety_production_cost_plan(id),
  constraint fk_m019_safety_production_cost_plan_detail_org_org_id foreign  key(org_id) references org(id)
) comment '年度安全生产费用使用明细';

#企业资质文件
drop table if exists m001_org_doc;
create table m001_org_doc(
  id varchar(36) primary key comment 'ID主键',
  name varchar(50) not null comment '资质文件名称',
  doc_num varchar(100) comment '文件编号',
  beginDate datetime comment '有效期起始时间',
  endDate datetime comment '有效期终止时间',
  uploadDate datetime comment '上传日期',
  url varchar(200) comment '资质文件路径',
  realPath varchar(200) comment '实际路径',
  org_id varchar(36) not null comment '所属企业ID',
  constraint fk_m001_org_doc_org_id foreign key(org_id) references org(id)
) comment '企业资质文件表';

#部门表
drop table if exists m002_department;
create table m002_department(
  id varchar(36) primary key comment '主键',
  name varchar(50) not null comment '部门名称',
  pid varchar(36)   comment '父部门ID',
  tel varchar(50) comment '部门电话',
  org_id varchar(36) comment '企业id',
  business varchar(500) comment '部门职能',
  constraint fk_m002_department_pid foreign key(pid) REFERENCES m002_department(id),
  constraint fk_m002_department_org_id foreign key(org_id) references org(id)
)comment '部门表';

#职位表
drop table if exists m002_position;
create table m002_position(
  id varchar(36) primary key comment '主键',
  name varchar(50) not null comment '职位名称',
  note varchar(2000) comment '职位描述',
  managementLayer bit default  0 comment '是否为管理层，管理层可参加安全会议',
  department_id varchar(36) comment '所在部门',
  org_id varchar(36) comment '企业id',
  constraint fk_m002_position_m002_department_id foreign key(department_id) REFERENCES m002_department(id),
  constraint fk_m002_department_m002_position_org_id foreign key(org_id) references org(id)
)comment '职位表';


#权限表
drop table if exists functions;
create table functions(
  id varchar(36) primary key comment '主键',
  name varchar(50) not null comment '权限名称',
  url varchar(100)  comment '访问路径',
  leaf bit default 1 comment '是否为叶子节点,0:否  1： 是',
  type varchar(10) default '功能' comment '类型：功能或菜单',
  priority int default 0 comment '优先级，值越大页面显示越靠前',
  pid varchar(36)   comment '父权限ID',
  status varchar(10) default 0 comment '状态，0：正常，1：禁用，2：删除',
  creator varchar(50) comment '创建人',
  createDate datetime  comment '创建日期',
  note varchar(2000) comment '备注',
  icon varchar(50) comment '图标',
  c_index varchar(50)  comment '唯一标识，要和前端路由的地址相同',
	constraint fk_pid foreign key(pid) REFERENCES functions(id)
) comment '权限表';

#角色表
drop table if exists role;
create table role(
  id varchar(36) primary key comment '主键',
  name varchar(50) not null comment '角色名称',
  status varchar(10) default 0 comment '状态，0：正常，1：禁用，2：删除',
  creator varchar(50) comment '创建人',
  createDate datetime  comment '创建日期',
  note varchar(2000) comment '备注',
  org_id varchar(36) comment '所属企业',
  org_category_id varchar(36) comment '企业类别ID,企业管理员只能使用企业所在类别下的角色',
  allowedDelete bit default 1 comment '是否允许删除,0:不允许删除，1：允许删除',
  constraint fk_role_org foreign key(org_id) references org(id),
  constraint fk_role_org_category foreign key(org_category_id) references org_category(id)
) comment '角色表';

#用户表
drop table if exists t_user;
create table t_user(
  id varchar(36) primary key comment '主键',
  role_id varchar(36) comment '用户所属角色',
  username varchar(50) not null comment '用户名称',
  password varchar(100)  comment '密码',
  realname varchar(50) comment '真实姓名',
  tel varchar(20) comment '联系方式',
  status char(1) default '0' comment '状态，0：正常，1：禁用，2：删除',
  allowedDelete bit default 1 comment '是否允许删除,0:不允许删除，1：允许删除',
  creator varchar(50) comment '创建人',
  createDate datetime  comment '创建日期',
  note varchar(2000) comment '备注',
  org_id varchar(36) comment '所属企业',
  photo varchar(200) comment '头像访问路径',
  realpath varchar(200) comment '头像实际存储路径',
  constraint fk_user_org foreign key(org_id) references org(id),
  constraint fk_user_role foreign key(role_id) references role(id)
) comment '用户表';


#区域管理员
drop table if exists area_manager;
create table area_manager(
  id varchar(36) primary key comment '主键',
  username varchar(50) not null comment '用户名称',
  password varchar(100) unique default '123456' comment '密码',
  photo varchar(200) comment '头像访问路径',
  realpath varchar(200) comment '头像实际存储路径',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  createDate datetime  comment '创建日期',
  org_category_id varchar(36) comment '企业类别id',
   constraint fk_area_manager_category_province_id foreign key(province_id) references category(id),
  constraint fk_area_manager_category_city_id foreign key(city_id) references category(id),
  constraint fk_area_manager_category_region_id foreign key(region_id) references category(id),
  constraint fk_org_category_area_manager foreign key(org_category_id) references org_category(id)
) comment '区域管理员';


#企业人员资料
drop table if exists m003_employee;
create table m003_employee(
  id varchar(36) primary key comment 'ID主键',
  name varchar(50) not null comment '员工名称',
  sex varchar(10) comment '性别',
  age int comment '年龄',
  tel varchar(20) comment '联系电话',
  idnum varchar(20) comment '身份证号',
  org_id varchar(36) comment '所属企业ID',
  note varchar(2000) comment '备注',
  photo varchar(200) comment '头像',
  realPath varchar(200) comment '真实路径',
  user_id varchar(36) comment '人员对应用户ID',
  department_id varchar(36) comment '部门id',
  position_id varchar(36) comment '职位id',
  constraint fk_m003_employee_department_id foreign key(department_id) references m002_department(id),
  constraint fk_m003_employee_position_id foreign key(position_id) references m002_position(id),
  constraint fk_m003_employee_org_id foreign key(org_id) references org(id),
  constraint fk_m003_employee_user_id foreign key(user_id) references t_user(id)
) comment '企业人员资料表';


#角色权限表
drop table if exists role_functions;
create table role_functions(
  id varchar(36) primary key comment '主键',
  role_id varchar(36) not null comment '角色ID',
  function_id varchar(36) not null comment '权限ID',
  constraint fk_function foreign key(function_id) references functions(id),
  constraint fk_role_id foreign key(role_id) references role(id)
) comment '角色权限表';

#企业类别权限表
drop table if exists org_category_functions;
create table org_category_functions(
  id varchar(36) primary key comment '主键',
  org_category_id varchar(36) not null comment '企业类别ID',
  function_id varchar(36) not null comment '权限ID',
  constraint fk_function_id foreign key(function_id) references functions(id),
  constraint fk_org_category_id foreign key(org_category_id) references org_category(id)
) comment '类别权限表';

#模式表，模式表下关联一级菜单(directory表)
drop table if exists t_schema;
create table t_schema(
  id varchar(36) primary key comment '主键',
  name varchar(36) not null comment '模式名称',
  priority int comment '优先级',
  createDate datetime  comment '创建日期',
  note varchar(2000) comment '说明',
  selected bit(1) default 1 comment '是否选中，页面上显示选中的模式的菜单'
) comment '模式表';

#目录表，每个菜单可以存放在不同的目录下
drop table if exists directory;
create table directory(
  id varchar(36) primary key comment '主键',
  name varchar(50) not null comment '权限名称',
  priority int default 0 comment '优先级，值越大页面显示越靠前',
  schema_id varchar(36)   comment '所属模式ID',
  status varchar(10) default '0' comment '状态，0：正常，1：禁用，2：删除',
  creator varchar(50) comment '创建人',
  createDate datetime  comment '创建日期',
  note varchar(2000) comment '备注',
  icon varchar(50) comment '图标',
  c_index varchar(50)  comment '唯一标识，要和前端路由的地址相同',
	constraint fk_schema_id foreign key(schema_id) REFERENCES t_schema(id)
) comment '目录表';

#目录菜单表
drop table if exists directory_functions;
create table directory_functions(
  id varchar(36) primary key comment '主键',
  directory_id varchar(36) not null comment '目录ID',
  function_id varchar(36) not null comment '权限ID',
  constraint fk_directory_functions_function_id foreign key(function_id) references functions(id),
  constraint fk_directory_id foreign key(directory_id) references directory(id)
) comment '目录菜单表';

#安全会议模板表
drop table if exists m046_meeting_template;
create table m046_meeting_template(
  id varchar(36) primary key comment '主键',
 name varchar(500) comment '模板名称',
 createDate datetime comment '模板创建日期',
 meetingName varchar(100) comment '会议名称或主要议题',
 meetingDate datetime  comment '开会时间',
 endMeetingDate datetime  comment '闭会时间',
 meetingPlace varchar(500) comment '会议地点',
  president varchar(100) comment '主持人',
  recorder varchar(100) comment '记录人',
  attendants varchar(500) comment '出席人',
  content varchar(2000) comment '会议内容',
  finalDecision varchar(2000) comment '最后形成意见或决定',
  note varchar(2000) comment '备注',
  url varchar(500) comment '签名文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  creator varchar(100) comment '创建人',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  org_category_id varchar(36) comment '企业类别',
  org_id varchar(36) comment '企业ID',
   constraint fk_m046_meeting_template_org_org_id foreign key(org_id) references org(id),
  constraint fk_m046_meeting_template_category_province_id foreign key(province_id) references category(id),
  constraint fk_m046_meeting_template_category_city_id foreign key(city_id) references category(id),
  constraint fk_m046_meeting_template_category_region_id foreign key(region_id) references category(id),
  constraint fk_org_category_m046_meeting_template foreign key(org_category_id) references org_category(id)
) comment '安全会议模板表';

#安全培训模板表
drop table if exists m047_training_template;
create table m047_training_template(
  id varchar(36) primary key comment '主键',
 name varchar(500) comment '模板名称',
 createDate datetime comment '模板创建日期',
 trainingName varchar(100) comment '培训名称',
 trainingDate datetime  comment '培训时间',
 trainingPlace varchar(500) comment '培训地点',
  president varchar(100) comment '主持人',
  recorder varchar(100) comment '记录人',
  attendants varchar(500) comment '参加对象',
  attendance int comment '应到人数',
  realAttendance int comment '实到人数',
  content text comment '培训内容',
  note varchar(2000) comment '备注',
  url varchar(500) comment '签名文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  creator varchar(100) comment '创建人',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  org_category_id varchar(36) comment '企业类别',
  org_id varchar(36) comment '企业ID',
   constraint fk_m047_training_template_org_org_id foreign key(org_id) references org(id),
  constraint fk_m047_training_template_category_province_id foreign key(province_id) references category(id),
  constraint fk_m047_training_template_category_city_id foreign key(city_id) references category(id),
  constraint fk_m047_training_template_category_region_id foreign key(region_id) references category(id),
  constraint fk_m047_training_template_meeting_template foreign key(org_category_id) references org_category(id)
) comment '安全培训模板表';

#安全培训表
drop table if exists m022_training;
create table m022_training(
  id varchar(36) primary key comment '主键',
 name varchar(500) comment '模板名称',
 createDate datetime comment '模板创建日期',
 trainingName varchar(100) comment '培训名称',
 trainingDate datetime  comment '培训时间',
 trainingPlace varchar(500) comment '培训地点',
  president varchar(100) comment '主持人',
  recorder varchar(100) comment '记录人',
  attendants varchar(500) comment '参加对象',
  attendance int comment '应到人数',
  realAttendance int comment '实到人数',
  content text comment '培训内容',
  note varchar(2000) comment '备注',
  url varchar(500) comment '签名文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  creator varchar(100) comment '创建人',
  org_id varchar(36) comment '所属企业',
  constraint fk_m022_training_org_org_id foreign key(org_id) references org(id)
) comment '安全培训表';

#安全会议表
drop table if exists m021_meeting;
create table m021_meeting(
  id varchar(36) primary key comment '主键',
 name varchar(500) comment '名称',
 createDate datetime comment '创建日期',
 meetingName varchar(100) comment '会议名称',
 meetingDate datetime  comment '开会时间',
 endMeetingDate datetime  comment '闭会时间',
 meetingPlace varchar(500) comment '会议地点',
  president varchar(100) comment '主持人',
  recorder varchar(100) comment '记录人',
  attendants varchar(500) comment '出席人',
  content text comment '会议内容',
  finalDecision varchar(2000) comment '最后形成意见或决定',
  note varchar(2000) comment '备注',
  creator varchar(100) comment '创建人',
  url varchar(500) comment '签名文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  org_id varchar(36) comment '所属企业',
  constraint fk_m021_meeting_org_org_id foreign key(org_id) references org(id)
) comment '安全会议表';

#责任书模板表
drop table if exists m048_responsibility_template;
create table m048_responsibility_template(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  content text comment '模板内容',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
   creator varchar(100) comment '创建人',
   url varchar(500) comment '签名文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  org_category_id varchar(36) comment '企业类别',
   org_id varchar(36) comment '企业ID',
   constraint fk_m048_responsibility_template_org_org_id foreign key(org_id) references org(id),
  constraint fk_m048_responsibility_template_category_province_id foreign key(province_id) references category(id),
  constraint fk_m048_responsibility_template_category_city_id foreign key(city_id) references category(id),
  constraint fk_m048_responsibility_template_category_region_id foreign key(region_id) references category(id),
  constraint fk_org_category_m048_responsibility_template foreign key(org_category_id) references org_category(id)
) comment '责任书模板表';



#责任书表
drop table if exists m025_responsibility;
create table m025_responsibility(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  content text comment '模板内容',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
   creator varchar(100) comment '创建人',
   url varchar(500) comment '签名文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  org_id varchar(36) comment '企业ID',
  constraint fk_m025_responsibility_org_org_id foreign key(org_id) references org(id)
) comment '责任书表';

#安全检查模板表
drop table if exists m042_security_check_template;
create table m042_security_check_template(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  checkObject varchar(500) comment '检查对象',
  deptAndEmp varchar(500) comment '监督检查的部门及人员',
  content varchar(2000) comment '检查的内容',
  problems varchar(2000) comment '查出的问题',
  result varchar(2000) comment '整改结果',
  suggestion varchar(2000) comment '检查组处理意见',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  checkDate datetime comment '安全检查日期',
  supervisorsSign varchar(500) comment '检查人员签字,以后可能为签字图片路径',
  confirmerSign varchar(500) comment '整改结果确认人签字,以后可能为签字图片路径',
  checkedObjectSign varchar(500) comment '受检查对象签字,以后可能为签字图片路径',
  creator varchar(100) comment '创建人',
  url varchar(500) comment '签名文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  org_category_id varchar(36) comment '企业类别',
   org_id varchar(36) comment '企业ID',
   constraint fk_m042_security_check_template_org_org_id foreign key(org_id) references org(id),
  constraint fk_m042_security_check_template_category_province_id foreign key(province_id) references category(id),
  constraint fk_m042_security_check_template_category_city_id foreign key(city_id) references category(id),
  constraint fk_m042_security_check_template_category_region_id foreign key(region_id) references category(id),
  constraint fk_org_category_m042_security_check_template foreign key(org_category_id) references org_category(id)
) comment '安全检查模板表';

#安全检查表
drop table if exists m023_security_check;
create table m023_security_check(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  checkObject varchar(500) comment '受检单位(部门、车辆)',
  deptAndEmp varchar(500) comment '参加监督检查的单位(部门)及人员',
  content varchar(2000) comment '监督检查的主要内容',
  problems varchar(2000) comment '监督检查中查出的问题',
  result varchar(2000) comment '整改结果',
  suggestion varchar(2000) comment '检查组处理意见',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  checkDate datetime comment '安全检查日期',
  supervisorsSign varchar(500) comment '检查人员签字,以后可能为签字图片路径',
  confirmerSign varchar(500) comment '整改结果确认人签字,以后可能为签字图片路径',
  checkedObjectSign varchar(500) comment '受检单位代表人签字,以后可能为签字图片路径',
  creator varchar(100) comment '创建人',
   url varchar(500) comment '签名文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  org_id varchar(36) comment '企业ID',
  constraint fk_m023_security_check_org_org_id foreign key(org_id) references org(id)
) comment '安全检查表';

#危险货物运输企业安全生产隐患排查整改台账模板表
drop table if exists m049_danger_goods_check_template;
create table m049_danger_goods_check_template(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  orgPersonSign varchar(500) comment '企业负责人签字',
  securityPersonSign varchar(500) comment '安全检查人员签字',
  creator varchar(100) comment '创建人',
  url varchar(500) comment '签名文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  org_category_id varchar(36) comment '企业类别',
   org_id varchar(36) comment '企业ID',
   constraint fk_m049_danger_goods_check_template_org_org_id foreign key(org_id) references org(id),
  constraint fk_m049_danger_goods_check_template_category_province_id foreign key(province_id) references category(id),
  constraint fk_m049_danger_goods_check_template_category_city_id foreign key(city_id) references category(id),
  constraint fk_m049_danger_goods_check_template_category_region_id foreign key(region_id) references category(id),
  constraint fk_org_category_m049_danger_goods_check_template foreign key(org_category_id) references org_category(id)
) comment '危险货物运输企业安全生产隐患排查整改台账模板表';

#危险货物运输企业安全生产隐患排查整改台账模板详情表
drop table if exists m049_danger_goods_check_detial;
create table m049_danger_goods_check_detial(
  id varchar(36) primary key comment '主键',
  checkDate datetime comment '检查日期',
  checkedOrg varchar(200) comment '被检查单位',
  hiddenDanger varchar(2000) comment '存在的安全隐患',
  correctiveAction varchar(2000) comment '整改措施',
  timelimit varchar(100) comment '整改时限',
  detailNote varchar(2000) comment '备注',
  person varchar(100) comment '责任人',
  endTime datetime  comment '整改到位时间',
  cancelDate datetime comment '销号时间',
  danger_goods_check_id varchar(36) comment '危险货物运输企业安全生产隐患排查整改台账模板id',
  constraint fk_m049_danger_goods_check_template_check_detail foreign key(danger_goods_check_id) references m049_danger_goods_check_template(id)
) comment '危险货物运输企业安全生产隐患排查整改台账模板详情表';


#危险货物运输企业安全生产隐患排查整改台账表
drop table if exists m024_danger_goods_check;
create table m024_danger_goods_check(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  orgPersonSign varchar(500) comment '企业负责人签字',
  securityPersonSign varchar(500) comment '安全检查人员签字',
  creator varchar(100) comment '创建人',
  url varchar(500) comment '签名文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  org_id varchar(36) comment '企业ID',
   constraint fk_m024_danger_goods_check_org_org_id foreign key(org_id) references org(id)
) comment '危险货物运输企业安全生产隐患排查整改台账表';

#危险货物运输企业安全生产隐患排查整改台账详情表
drop table if exists m024_danger_goods_check_detial_record;
create table m024_danger_goods_check_detial_record(
  id varchar(36) primary key comment '主键',
  checkDate datetime comment '检查日期',
  checkedOrg varchar(200) comment '被检查单位',
  hiddenDanger varchar(2000) comment '存在的安全隐患',
  correctiveAction varchar(2000) comment '整改措施',
  timelimit varchar(100) comment '整改时限',
  detailNote varchar(2000) comment '备注',
  person varchar(100) comment '责任人',
  endTime datetime  comment '整改到位时间',
  cancelDate datetime comment '销号时间',
  rectification bit default 0 comment '是否已整改',
  rectificationFund decimal(15,3) default 0.00 comment '整改金额',
  severity_id varchar(36) comment '严重程度:一般事故隐患、重大事故隐患',
  reason_category_id varchar(36) comment '造成隐患的因素：人的不安全行为、物的不安全状态、管理上的缺失等',
  org_id varchar(36) comment '企业ID',
  constraint fk_m024_danger_goods_check_detial_record_org_org_id foreign key(org_id) references org(id),
  constraint fk_m024_danger_goods_check_detial_record_category_severity_id foreign key(severity_id) references category(id),
  constraint fk_m024_danger_goods_check_detial_record_category_reason_id foreign key(reason_category_id) references category(id)
) comment '危险货物运输企业安全生产隐患排查整改台账详情表';

#危险货物道路运输罐式车辆罐体检查记录模板表
drop table if exists m044_tank_vehicle_template;
create table m044_tank_vehicle_template(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  checkDate datetime comment '检查日期',
  carNo varchar(200) comment '车号',
  checkItem1 bit default 1 comment '检查项，罐体有无破损、罐体是否整洁、罐体灯光是否完整',
  checkItem2 bit default 1 comment '检查项，反光条是否完整、反光标示是否完整、反光牌是否有',
  checkItem3 bit default 1 comment '检查项，罐后保险杠是否合格',
  checkItem4 bit default 1 comment '检查项，静电接地带是否有效',
  checkItem5 bit default 1 comment '检查项，罐体两边防护网是否完整',
  checkItem6 bit default 1 comment '检查项，轮胎是否符合行车安全要求',
  checkItem7 bit default 1 comment '检查项，灭火器是否合格',
  checkItem8 bit default 1 comment '检查项，确认罐体上喷涂的介质名称是否与《公告》、《合格证》上记载的一致',
  checkItem9 bit default 1 comment '检查项，喷涂的介质与记载的内容一致，运输介质属于国家安监总局等五部委文件《关于明确在用液体危险货物罐车加装紧急切断装置液体介质范围的通知》（安监总管三〔2014〕135号）中列举的17种介质范围。检查其卸料口处是否安装有紧急切断阀、紧急切断阀是否有远程控制系统。',
  checkItem10 bit default 1 comment '检查项，检查紧急切断阀有无腐蚀、生锈、裂纹等缺陷，有无松脱、渗漏等现象，检查紧急切断阀控制按钮是否完好。',
  checkItem11 bit default 1 comment '检查项，检查紧急切断阀是否处于关闭状态，没有关闭的要求当场关闭，并对驾驶人进行一次面对面的教育提示。',
  checkItem12 bit default 1 comment '检查项，备用',
  checkItem13 bit default 1 comment '检查项，备用',
  checkItem14 bit default 1 comment '检查项，备用',
  checkItem15 bit default 1 comment '检查项，备用',
  checkItem1Msg varchar(200) comment 'checkItem1的描述',
  checkItem2Msg varchar(200) comment 'checkItem2的描述',
  checkItem3Msg varchar(200) comment 'checkItem3的描述',
  checkItem4Msg varchar(200) comment 'checkItem4的描述',
  checkItem5Msg varchar(200) comment 'checkItem5的描述',
  checkItem6Msg varchar(200) comment 'checkItem6的描述',
  checkItem7Msg varchar(200) comment 'checkItem7的描述',
  checkItem8Msg varchar(200) comment 'checkItem8的描述',
  checkItem9Msg varchar(200) comment 'checkItem9的描述',
  checkItem10Msg varchar(200) comment 'checkItem10的描述',
  checkItem11Msg varchar(200) comment 'checkItem11的描述',
  checkItem12Msg varchar(200) comment 'checkItem12的描述',
  checkItem13Msg varchar(200) comment 'checkItem13的描述',
  checkItem14Msg varchar(200) comment 'checkItem14的描述',
  checkItem15Msg varchar(200) comment 'checkItem15的描述',
  suggestion varchar(2000) comment '处理意见',
  url varchar(500) comment '签名文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  checkPersonSign varchar(500) comment '检查人员签字',
  creator varchar(100) comment '创建人',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  org_category_id varchar(36) comment '企业类别',
   org_id varchar(36) comment '企业ID',
   constraint fk_m044_tank_vehicle_template_org_org_id foreign key(org_id) references org(id),
  constraint fk_m044_tank_vehicle_template_category_province_id foreign key(province_id) references category(id),
  constraint fk_m044_tank_vehicle_template_category_city_id foreign key(city_id) references category(id),
  constraint fk_m044_tank_vehicle_template_category_region_id foreign key(region_id) references category(id),
  constraint fk_org_category_m044_tank_vehicle_template foreign key(org_category_id) references org_category(id)
) comment '危险货物道路运输罐式车辆罐体检查记录模板表';

#危险货物道路运输罐式车辆罐体检查记录表
drop table if exists m024_tank_vehicle;
create table m024_tank_vehicle(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  checkDate datetime comment '检查日期',
  carNo varchar(200) comment '车号',
  checkItem1 bit default 1 comment '检查项，罐体有无破损、罐体是否整洁、罐体灯光是否完整',
  checkItem2 bit default 1 comment '检查项，反光条是否完整、反光标示是否完整、反光牌是否有',
  checkItem3 bit default 1 comment '检查项，罐后保险杠是否合格',
  checkItem4 bit default 1 comment '检查项，静电接地带是否有效',
  checkItem5 bit default 1 comment '检查项，罐体两边防护网是否完整',
  checkItem6 bit default 1 comment '检查项，轮胎是否符合行车安全要求',
  checkItem7 bit default 1 comment '检查项，灭火器是否合格',
  checkItem8 bit default 1 comment '检查项，确认罐体上喷涂的介质名称是否与《公告》、《合格证》上记载的一致',
  checkItem9 bit default 1 comment '检查项，喷涂的介质与记载的内容一致，运输介质属于国家安监总局等五部委文件《关于明确在用液体危险货物罐车加装紧急切断装置液体介质范围的通知》（安监总管三〔2014〕135号）中列举的17种介质范围。检查其卸料口处是否安装有紧急切断阀、紧急切断阀是否有远程控制系统。',
  checkItem10 bit default 1 comment '检查项，检查紧急切断阀有无腐蚀、生锈、裂纹等缺陷，有无松脱、渗漏等现象，检查紧急切断阀控制按钮是否完好。',
  checkItem11 bit default 1 comment '检查项，检查紧急切断阀是否处于关闭状态，没有关闭的要求当场关闭，并对驾驶人进行一次面对面的教育提示。',
  checkItem12 bit default 1 comment '检查项，备用',
  checkItem13 bit default 1 comment '检查项，备用',
  checkItem14 bit default 1 comment '检查项，备用',
  checkItem15 bit default 1 comment '检查项，备用',
  checkItem1Msg varchar(200) comment 'checkItem1的描述',
  checkItem2Msg varchar(200) comment 'checkItem2的描述',
  checkItem3Msg varchar(200) comment 'checkItem3的描述',
  checkItem4Msg varchar(200) comment 'checkItem4的描述',
  checkItem5Msg varchar(200) comment 'checkItem5的描述',
  checkItem6Msg varchar(200) comment 'checkItem6的描述',
  checkItem7Msg varchar(200) comment 'checkItem7的描述',
  checkItem8Msg varchar(200) comment 'checkItem8的描述',
  checkItem9Msg varchar(200) comment 'checkItem9的描述',
  checkItem10Msg varchar(200) comment 'checkItem10的描述',
  checkItem11Msg varchar(200) comment 'checkItem11的描述',
  checkItem12Msg varchar(200) comment 'checkItem12的描述',
  checkItem13Msg varchar(200) comment 'checkItem13的描述',
  checkItem14Msg varchar(200) comment 'checkItem14的描述',
  checkItem15Msg varchar(200) comment 'checkItem15的描述',
  suggestion varchar(2000) comment '处理意见',
  checkPersonSign varchar(500) comment '检查人员签字',
  creator varchar(100) comment '创建人',
  url varchar(500) comment '签名文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  org_id varchar(36) comment '企业ID',
   constraint fk_m024_tank_vehicle_org_org_id foreign key(org_id) references org(id)
) comment '危险货物道路运输罐式车辆罐体检查记录表';

#人员档案：简历
drop table if exists m011_resume;
create table m011_resume(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  endDate datetime comment '截止日期',
  beginDate datetime comment '起始日期',
  url varchar(2000) comment '文件访问路径',
  realPath varchar(2000) comment '实际存储路径',
  deleted bit default 0 comment '删除标识',
  emp_id varchar(36) comment '所属人员',
  constraint fk_m011_resume_m003_employee_emp_id foreign key(emp_id) references m003_employee(id)
  )comment '人员档案：简历';

#人员档案:身份证
drop table if exists m011_idcard;
create table m011_idcard(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  beginDate datetime comment '起始日期',
  endDate datetime comment '终止日期',
  url varchar(2000) comment '文件访问路径',
  realPath varchar(2000) comment '实际存储路径',
   deleted bit default 0  comment '删除标识',
  emp_id varchar(36) comment '所属人员',
  constraint fk_m011_idcard_m003_employee_emp_id foreign key(emp_id) references m003_employee(id)
  )comment '人员档案：身份证';

#人员档案:劳动合同
drop table if exists m011_contract;
create table m011_contract(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  beginDate datetime comment '起始日期',
  endDate datetime comment '终止日期',
  url varchar(2000) comment '文件访问路径',
  realPath varchar(2000) comment '实际存储路径',
   deleted bit default 0  comment '删除标识',
  emp_id varchar(36) comment '所属人员',
  constraint fk_m011_contract_m003_employee_emp_id foreign key(emp_id) references m003_employee(id)
  )comment '人员档案：劳动合同';

#人员档案:资质文件
drop table if exists m011_qualification_document;
create table m011_qualification_document(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  beginDate datetime comment '起始日期',
  endDate datetime comment '终止日期',
  url varchar(2000) comment '文件访问路径',
  realPath varchar(2000) comment '实际存储路径',
   deleted bit default 0  comment '删除标识',
  emp_id varchar(36) comment '所属人员',
  constraint fk_m011_qualification_document_m003_employee_emp_id foreign key(emp_id) references m003_employee(id)
  )comment '人员档案：资质文件';

#人员档案:从业情况历史
drop table if exists m011_job_history;
create table m011_job_history(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  endDate datetime comment '截止日期',
  beginDate datetime comment '起始日期',
  url varchar(2000) comment '文件访问路径',
  realPath varchar(2000) comment '实际存储路径',
   deleted bit default 0  comment '删除标识',
  emp_id varchar(36) comment '所属人员',
  constraint fk_m011_job_history_m003_employee_emp_id foreign key(emp_id) references m003_employee(id)
  )comment '人员档案：从业情况历史';

#人员档案:三级教育(入职培训)
drop table if exists m011_induction_training;
create table m011_induction_training(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  endDate datetime comment '截止日期',
  beginDate datetime comment '起始日期',
  url varchar(2000) comment '文件访问路径',
  realPath varchar(2000) comment '实际存储路径',
   deleted bit default 0  comment '删除标识',
  emp_id varchar(36) comment '所属人员',
  constraint fk_m011_induction_training_m003_employee_emp_id foreign key(emp_id) references m003_employee(id)
  )comment '人员档案：三级教育(入职培训)';


#人员档案:安全责任书
drop table if exists m011_safety_responsibility_agreement;
create table m011_safety_responsibility_agreement(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  beginDate datetime comment '起始日期',
  endDate datetime comment '终止日期',
  url varchar(2000) comment '文件访问路径',
  realPath varchar(2000) comment '实际存储路径',
   deleted bit  default 0  comment '删除标识',
  emp_id varchar(36) comment '所属人员',
  constraint fk_m011_safety_responsibility_agreement_m003_employee_emp_id foreign key(emp_id) references m003_employee(id)
  )comment '人员档案：安全责任书';

#人员档案:培训考核情况
drop table if exists m011_training_examine;
create table m011_training_examine(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  endDate datetime comment '截止日期',
  beginDate datetime comment '起始日期',
  url varchar(2000) comment '文件访问路径',
  realPath varchar(2000) comment '实际存储路径',
   deleted bit default 0  comment '删除标识',
  emp_id varchar(36) comment '所属人员',
  constraint fk_m011_training_examine_m003_employee_emp_id foreign key(emp_id) references m003_employee(id)
  )comment '人员档案：培训考核情况';

#人员档案:其他人员档案,打包上传
drop table if exists m011_other_document;
create table m011_other_document(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  endDate datetime comment '截止日期',
  beginDate datetime comment '起始日期',
  url varchar(2000) comment '文件访问路径',
  realPath varchar(2000) comment '实际存储路径',
   deleted bit default 0  comment '删除标识',
  emp_id varchar(36) comment '所属人员',
  constraint fk_m011_other_document_m003_employee_emp_id foreign key(emp_id) references m003_employee(id)
  )comment '人员档案：其他人员档案，打包上传';


#人员档案模板表
drop table if exists m55_emp_archives_template;
create table m55_emp_archives_template(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  type varchar(200) comment '人员档案模板类别:resume,idcard,contract,qualificationDocument,jobHistory,inductionTraining,safetyResponsibilityAgreement,trainingExamine,otherDocument',
  createDate datetime comment '创建日期',
  creator varchar(100) comment '创建人',
  url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  org_category_id varchar(36) comment '企业类别',
  org_id varchar(36) comment '企业ID',
  constraint fk_m55_emp_archives_template_org_org_id foreign key(org_id) references org(id),
  constraint fk_m55_emp_archives_template_category_province_id foreign key(province_id) references category(id),
  constraint fk_m55_emp_archives_template_category_city_id foreign key(city_id) references category(id),
  constraint fk_m55_emp_archives_template_category_region_id foreign key(region_id) references category(id),
  constraint fk_org_category_m55_emp_archives_template foreign key(org_category_id) references org_category(id)
) comment '人员档案模板表';

#设备管理
drop table if exists m012_device;
create table m012_device(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  equipmentCode varchar(50) comment '设备编码',
  specification varchar(50) comment '规格型号',
  manufacturer varchar(100) comment '厂商',
  position varchar(200) comment '放置位置',
  price decimal(15,3) default 0.00 comment '单价',
  buyDate datetime comment '购置日期',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  url varchar(2000) comment '文件访问路径',
  realPath varchar(2000) comment '实际存储路径',
  deleted bit default 0  comment '删除标识',
  org_id varchar(36) comment '所属企业',
  category_id varchar(36) comment '设备类别ID',
  constraint fk_m012_device_org_org_id foreign key(org_id) references org(id),
  constraint fk_m012_device_category_category_id foreign key(category_id) references category(id)
  )comment '设备管理';

#设备保养维修记录
drop table if exists m012_device_maintain;
create table m012_device_maintain(
  id varchar(36) primary key comment '主键',
  createDate datetime  comment '创建时间',
  operateDate datetime  comment '操作时间:维修、保养或检修',
  content varchar(2000) comment '维修、保养货检修内容',
   price decimal(15,3) default 0.00 comment '花费费用',
  url varchar(2000) comment '文件访问路径',
   note varchar(2000) comment '备注',
  realPath varchar(2000) comment '实际存储路径',
  deleted bit default 0  comment '删除标识',
  device_id varchar(36) comment '设备ID',
  constraint fk_m012_device_maintain_m012_device_device_id foreign key(device_id) references m012_device(id)
  )comment '设备保养维修记录';

#设备档案模板表,设备或设备维修保养记录模板
drop table if exists m56_device_maintain_template;
create table m56_device_maintain_template(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  creator varchar(100) comment '创建人',
  url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  org_category_id varchar(36) comment '企业类别',
  org_id varchar(36) comment '企业ID',
  constraint fk_m56_device_maintain_template_org_org_id foreign key(org_id) references org(id),
  constraint fk_m56_device_maintain_template_category_province_id foreign key(province_id) references category(id),
  constraint fk_m56_device_maintain_template_category_city_id foreign key(city_id) references category(id),
  constraint fk_m56_device_maintain_template_category_region_id foreign key(region_id) references category(id),
  constraint fk_org_category_m56_device_maintain_template foreign key(org_category_id) references org_category(id)
) comment '设备档案模板表';

#安全责任考核模板表
drop table if exists m50_security_examination_template;
create table m50_security_examination_template(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  beginDate datetime comment '有效期起始时间',
  endDate datetime comment '有效期终止时间',
  uploadDate datetime comment '上传日期',
   creator varchar(100) comment '创建人',
   url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  org_category_id varchar(36) comment '企业类别',
   org_id varchar(36) comment '企业ID',
   constraint fk_m50_security_examination_template_org_org_id foreign key(org_id) references org(id),
  constraint fk_m50_security_examination_template_category_province_id foreign key(province_id) references category(id),
  constraint fk_m50_security_examination_template_category_city_id foreign key(city_id) references category(id),
  constraint fk_m50_security_examination_template_category_region_id foreign key(region_id) references category(id),
  constraint fk_org_category_m50_security_examination_template foreign key(org_category_id) references org_category(id)
) comment '安全责任考核模板表';

#安全责任考核表
drop table if exists m026_security_examination;
create table m026_security_examination(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  beginDate datetime comment '有效期起始时间',
  endDate datetime comment '有效期终止时间',
  uploadDate datetime comment '上传日期',
   creator varchar(100) comment '创建人',
   url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
   org_id varchar(36) comment '企业ID',
   constraint fk_m026_security_examination_org_org_id foreign key(org_id) references org(id)
) comment '安全责任考核表';

#安全目标考核模板表
drop table if exists m51_goal_examination_template;
create table m51_goal_examination_template(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  beginDate datetime comment '有效期起始时间',
  endDate datetime comment '有效期终止时间',
  uploadDate datetime comment '上传日期',
   creator varchar(100) comment '创建人',
   url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  org_category_id varchar(36) comment '企业类别',
   org_id varchar(36) comment '企业ID',
   constraint fk_m51_goal_examination_template_org_org_id foreign key(org_id) references org(id),
  constraint fk_m51_goal_examination_template_category_province_id foreign key(province_id) references category(id),
  constraint fk_m51_goal_examination_template_category_city_id foreign key(city_id) references category(id),
  constraint fk_m51_goal_examination_template_category_region_id foreign key(region_id) references category(id),
  constraint fk_org_category_m51_goal_examination_template foreign key(org_category_id) references org_category(id)
) comment '安全目标考核模板表';

#安全目标考核表
drop table if exists m027_goal_examination;
create table m027_goal_examination(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  beginDate datetime comment '有效期起始时间',
  endDate datetime comment '有效期终止时间',
  uploadDate datetime comment '上传日期',
   creator varchar(100) comment '创建人',
   url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
   org_id varchar(36) comment '企业ID',
   constraint fk_m027_goal_examination_org_org_id foreign key(org_id) references org(id)
) comment '安全目标考核表';

#应急预案演练模板表
drop table if exists m52_emergency_plan_drill_template;
create table m52_emergency_plan_drill_template(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  beginDate datetime comment '有效期起始时间',
  endDate datetime comment '有效期终止时间',
  uploadDate datetime comment '上传日期',
   creator varchar(100) comment '创建人',
   url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  org_category_id varchar(36) comment '企业类别',
   org_id varchar(36) comment '企业ID',
   constraint fk_m52_emergency_plan_drill_template_org_org_id foreign key(org_id) references org(id),
  constraint fk_m52_emergency_plan_drill_template_category_province_id foreign key(province_id) references category(id),
  constraint fk_m52_emergency_plan_drill_template_category_city_id foreign key(city_id) references category(id),
  constraint fk_m52_emergency_plan_drill_template_category_region_id foreign key(region_id) references category(id),
  constraint fk_org_category_m52_emergency_plan_drill_template foreign key(org_category_id) references org_category(id)
) comment '应急预案演练模板表';

#应急预案演练表
drop table if exists m028_emergency_plan_drill;
create table m028_emergency_plan_drill(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  beginDate datetime comment '有效期起始时间',
  endDate datetime comment '有效期终止时间',
  uploadDate datetime comment '上传日期',
   creator varchar(100) comment '创建人',
   url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
   org_id varchar(36) comment '企业ID',
   constraint fk_m028_emergency_plan_drill_org_org_id foreign key(org_id) references org(id)
) comment '应急预案演练表';

#职业健康记录模板表
drop table if exists m53_healthy_record_template;
create table m53_healthy_record_template(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  beginDate datetime comment '有效期起始时间',
  endDate datetime comment '有效期终止时间',
  uploadDate datetime comment '上传日期',
   creator varchar(100) comment '创建人',
   url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  org_category_id varchar(36) comment '企业类别',
   org_id varchar(36) comment '企业ID',
   constraint fk_m53_healthy_record_template_org_org_id foreign key(org_id) references org(id),
  constraint fk_m53_healthy_record_template_category_province_id foreign key(province_id) references category(id),
  constraint fk_m53_healthy_record_template_category_city_id foreign key(city_id) references category(id),
  constraint fk_m53_healthy_record_template_category_region_id foreign key(region_id) references category(id),
  constraint fk_org_category_m53_healthy_record_template foreign key(org_category_id) references org_category(id)
) comment '职业健康记录模板表';

#职业健康记录表
drop table if exists m029_healthy_record;
create table m029_healthy_record(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  beginDate datetime comment '有效期起始时间',
  endDate datetime comment '有效期终止时间',
  uploadDate datetime comment '上传日期',
   creator varchar(100) comment '创建人',
   url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
   org_id varchar(36) comment '企业ID',
   constraint fk_m029_healthy_record_org_org_id foreign key(org_id) references org(id)
) comment '职业健康记录表';

#标准化自评模板表
drop table if exists m54_standardization_template;
create table m54_standardization_template(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  beginDate datetime comment '有效期起始时间',
  endDate datetime comment '有效期终止时间',
  uploadDate datetime comment '上传日期',
   creator varchar(100) comment '创建人',
   url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  org_category_id varchar(36) comment '企业类别',
   org_id varchar(36) comment '企业ID',
   constraint fk_m54_standardization_template_org_org_id foreign key(org_id) references org(id),
  constraint fk_m54_standardization_template_category_province_id foreign key(province_id) references category(id),
  constraint fk_m54_standardization_template_category_city_id foreign key(city_id) references category(id),
  constraint fk_m54_standardization_template_category_region_id foreign key(region_id) references category(id),
  constraint fk_org_category_m54_standardization_template foreign key(org_category_id) references org_category(id)
) comment '标准化自评模板表';

#标准化自评表
drop table if exists m030_standardization;
create table m030_standardization(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  beginDate datetime comment '有效期起始时间',
  endDate datetime comment '有效期终止时间',
  uploadDate datetime comment '上传日期',
   creator varchar(100) comment '创建人',
   url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
   org_id varchar(36) comment '企业ID',
   constraint fk_m030_standardization_org_org_id foreign key(org_id) references org(id)
) comment '标准化自评表';

#应急预案备案
drop table if exists m038_emergency_plan_bak;
create table m038_emergency_plan_bak(
  id varchar(36) primary key comment '主键',
  prePlanName varchar(500) comment '预案名称',
  createDate datetime comment '创建日期',
  writeDate datetime comment '编制日期',
  prePlanUploadDate datetime comment '预案上传日期',
   prePlanUrl varchar(500) comment '预案文件访问路径',
  prePlanRealPath varchar(500) comment '预案实际存储路径',
   keepOnRecordName varchar(500) comment '备案名称',
  keepOnRecordUploadDate datetime comment '备案上传日期',
  keepOnRecordDate datetime comment '备案日期',
   keepOnRecordUrl varchar(500) comment '备案文件访问路径',
  keepOnRecordRealPath varchar(500) comment '备案实际存储路径',
  keepOnRecord bit default 0 comment '是否已备案',
   org_id varchar(36) comment '企业ID',
   constraint fk_m038_emergency_plan_bak_org_org_id foreign key(org_id) references org(id)
) comment '应急预案备案';

#应急救援预案演练记录表
drop table if exists m038_preplan_drill_record;
create table m038_preplan_drill_record(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '项目名称',
  type varchar(100) comment '应急预案类型：综合、专项、现场处置',
  createDate datetime comment '创建日期',
  developDate datetime comment '开展时间',
  note varchar(2000) comment '备注',
  url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
   emergency_plan_bak_id varchar(36) comment '应急预案备案记录ID',
   constraint fk_m038_preplan_drill_record_emergency_plan_bak_bak foreign key(emergency_plan_bak_id) references m038_emergency_plan_bak(id)
) comment '应急救援预案演练记录表';

#风险排查模板
drop table if exists m45_risk_check_template;
create table m45_risk_check_template(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  creator varchar(100) comment '创建人',
  url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  org_category_id varchar(36) comment '企业类别',
  org_id varchar(36) comment '企业ID',
  constraint fk_m45_risk_check_template_org_org_id foreign key(org_id) references org(id),
  constraint fk_m45_risk_check_template_category_province_id foreign key(province_id) references category(id),
  constraint fk_m45_risk_check_template_category_city_id foreign key(city_id) references category(id),
  constraint fk_m45_risk_check_template_category_region_id foreign key(region_id) references category(id),
  constraint fk_org_category_m45_risk_check_template foreign key(org_category_id) references org_category(id)
) comment '风险排查模板';

#设备点检模板
drop table if exists m43_device_check_template;
create table m43_device_check_template(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  creator varchar(100) comment '创建人',
  url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  org_category_id varchar(36) comment '企业类别',
  org_id varchar(36) comment '企业ID',
  constraint fk_m43_device_check_template_org_org_id foreign key(org_id) references org(id),
  constraint fk_m43_device_check_template_category_province_id foreign key(province_id) references category(id),
  constraint fk_m43_device_check_template_category_city_id foreign key(city_id) references category(id),
  constraint fk_m43_device_check_template_category_region_id foreign key(region_id) references category(id),
  constraint fk_org_category_m43_device_check_template foreign key(org_category_id) references org_category(id)
) comment '设备点检模板';

#GPS使用日志,GPS台账
drop table if exists m020_gps_account;
create table m020_gps_account(
  id varchar(36) primary key comment '主键',
  carNum varchar(100) comment '车牌号',
  createDate datetime comment '创建日期',
  driveDate datetime comment '行驶时间',
  driverName varchar(100) comment '驾驶员姓名',
  driveLines varchar(2000) comment '运营路线',
  goodsName varchar(200) comment '货物名称',
  carStatus varchar(2000) comment '车辆运行状况',
  gpsStatus varchar(2000) comment 'GPS运行状况',
  illegal bit default 0 comment '车辆有无违法违章行为',
  note varchar(2000) comment '备注',
  org_id varchar(36) comment '企业ID',
  constraint fk_m020_gps_account_org_org_id foreign key(org_id) references org(id)
) comment 'GPS使用日志';

#设备点检表
drop table if exists m057_device_check;
create table m057_device_check(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  uploadDate datetime comment '上传日期',
   creator varchar(100) comment '创建人',
   url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
   org_id varchar(36) comment '企业ID',
   constraint fk_m057_device_check_org_org_id foreign key(org_id) references org(id)
) comment '设备点检表';

#安全文化建设
drop table if exists m033_security_build;
create table m033_security_build(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  uploadDate datetime comment '上传日期',
   creator varchar(100) comment '创建人',
   url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
   org_id varchar(36) comment '企业ID',
   constraint fk_m033_security_build_org_org_id foreign key(org_id) references org(id)
) comment '安全文化建设';

#安全生产月
drop table if exists m034_security_month;
create table m034_security_month(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  uploadDate datetime comment '上传日期',
   creator varchar(100) comment '创建人',
   url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
   org_id varchar(36) comment '企业ID',
   constraint fk_m034_security_month_org_org_id foreign key(org_id) references org(id)
) comment '安全生产月';

#各种安全活动
drop table if exists m035_security_activity;
create table m035_security_activity(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  uploadDate datetime comment '上传日期',
   creator varchar(100) comment '创建人',
   url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
   org_id varchar(36) comment '企业ID',
   constraint fk_m035_security_activity_org_id foreign key(org_id) references org(id)
) comment '各种安全活动';

#事故记录及处理
drop table if exists m039_accident_record;
create table m039_accident_record(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  uploadDate datetime comment '上传日期',
   creator varchar(100) comment '创建人',
   url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
   org_id varchar(36) comment '企业ID',
   constraint fk_m039_accident_record_org_id foreign key(org_id) references org(id)
) comment '事故记录及处理';
#四不放过记录
drop table if exists m040_four_record;
create table m040_four_record(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  uploadDate datetime comment '上传日期',
   creator varchar(100) comment '创建人',
   url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
   org_id varchar(36) comment '企业ID',
   constraint fk_m040_four_record_org_id foreign key(org_id) references org(id)
) comment '四不放过记录';


#作业管理台账模板
drop table if exists m059_job_management_account_template;
create table m059_job_management_account_template(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  type_id varchar(36) comment '类别:相关方管理台账、相关方检查、相关方安全协议模板、出租场地安全检查、值班表模板、动火作业许可证、临时用电作业许可证、高处作业许可证、有限空间作业许可证',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  creator varchar(100) comment '创建人',
  url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  org_category_id varchar(36) comment '企业类别',
  constraint fk_m059_job_management_account_template_category_province_id foreign key(province_id) references category(id),
  constraint fk_m059_job_management_account_template_category_city_id foreign key(city_id) references category(id),
  constraint fk_m059_job_management_account_template_category_region_id foreign key(region_id) references category(id),
  constraint fk_m059_job_management_account_template_category_type_id foreign key(type_id) references category(id),
  constraint fk_org_category_m059_job_management_account_template foreign key(org_category_id) references org_category(id)
) comment '作业管理台账模板';

#作业管理台账
drop table if exists m058_job_management_account;
create table m058_job_management_account(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  type_id varchar(36) comment '类别:相关方管理台账、相关方检查、相关方安全协议模板、出租场地安全检查、值班表模板、动火作业许可证、临时用电作业许可证、高处作业许可证、有限空间作业许可证',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  uploadDate datetime comment '上传日期',
   creator varchar(100) comment '创建人',
   url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
   org_id varchar(36) comment '企业ID',
   constraint fk_m058_job_management_account_category_type_id foreign key(type_id) references category(id),
   constraint fk_m058_job_management_account_org_id foreign key(org_id) references org(id)
) comment '作业管理台账';

#风险等级
drop table if exists m060_risk_level;
create table m060_risk_level(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  color varchar(20) comment '颜色',
  upperLimit int comment '风险值范围上限值',
  lowerLimit int comment '风险值范围下限值',
  timeLimit varchar(2000) comment '实施期限',
  measure varchar(2000) comment '控制措施',
  createDate datetime comment '创建日期',
  note varchar(2000) comment '备注'
) comment '风险等级';

#安全文化建设模板表
drop table if exists m061_security_build_template;
create table m061_security_build_template(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  creator varchar(100) comment '创建人',
  url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  org_category_id varchar(36) comment '企业类别',
  org_id varchar(36) comment '所属企业',
  constraint fk_m061_security_build_template_org_org_id foreign key(org_id) references org(id),
  constraint fk_m061_security_build_template_category_province_id foreign key(province_id) references category(id),
  constraint fk_m061_security_build_template_category_city_id foreign key(city_id) references category(id),
  constraint fk_m061_security_build_template_category_region_id foreign key(region_id) references category(id),
  constraint fk_org_category_m061_security_build_template foreign key(org_category_id) references org_category(id)
) comment '安全文化建设模板表';

#安全生产月模板表
drop table if exists m062_security_month_template;
create table m062_security_month_template(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  creator varchar(100) comment '创建人',
  url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  org_category_id varchar(36) comment '企业类别',
  org_id varchar(36) comment '所属企业',
  constraint fk_m061_security_month_template_org_org_id foreign key(org_id) references org(id),
  constraint fk_m062_security_month_template_category_province_id foreign key(province_id) references category(id),
  constraint fk_m062_security_month_template_category_city_id foreign key(city_id) references category(id),
  constraint fk_m062_security_month_template_category_region_id foreign key(region_id) references category(id),
  constraint fk_org_category_m062_security_month_template foreign key(org_category_id) references org_category(id)
) comment '安全生产月模板表';

#其他安全活动模板表
drop table if exists m063_security_activity_template;
create table m063_security_activity_template(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  creator varchar(100) comment '创建人',
  url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  org_category_id varchar(36) comment '企业类别',
  org_id varchar(36) comment '所属企业',
  constraint fk_m061_security_activity_template_org_org_id foreign key(org_id) references org(id),
  constraint fk_m063_security_activity_template_category_province_id foreign key(province_id) references category(id),
  constraint fk_m063_security_activity_template_category_city_id foreign key(city_id) references category(id),
  constraint fk_m063_security_activity_template_category_region_id foreign key(region_id) references category(id),
  constraint fk_org_category_m063_security_activity_template foreign key(org_category_id) references org_category(id)
) comment '其他安全活动模板表';

#事故记录处理模板表
drop table if exists m064_accident_record_template;
create table m064_accident_record_template(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  creator varchar(100) comment '创建人',
  url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  org_category_id varchar(36) comment '企业类别',
  org_id varchar(36) comment '所属企业',
  constraint fk_m061_accident_record_template_org_org_id foreign key(org_id) references org(id),
  constraint fk_m064_accident_record_template_category_province_id foreign key(province_id) references category(id),
  constraint fk_m064_accident_record_template_category_city_id foreign key(city_id) references category(id),
  constraint fk_m064_accident_record_template_category_region_id foreign key(region_id) references category(id),
  constraint fk_org_category_m064_accident_record_template foreign key(org_category_id) references org_category(id)
) comment '事故记录处理模板表';

#四不放过记录模板表
drop table if exists m065_four_record_template;
create table m065_four_record_template(
  id varchar(36) primary key comment '主键',
  name varchar(500) comment '名称',
  fileName varchar(500) comment '文件原始名称',
  note varchar(2000) comment '备注',
  createDate datetime comment '创建日期',
  creator varchar(100) comment '创建人',
  url varchar(500) comment '文件访问路径',
  realPath varchar(500) comment '实际存储路径',
  province_id varchar(36) comment '所属省',
  city_id varchar(36) comment '所属市',
  region_id  varchar(36) comment '所属地区',
  org_category_id varchar(36) comment '企业类别',
  org_id varchar(36) comment '所属企业',
  constraint fk_m061_four_record_template_org_org_id foreign key(org_id) references org(id),
  constraint fk_m065_four_record_template_category_province_id foreign key(province_id) references category(id),
  constraint fk_m065_four_record_template_category_city_id foreign key(city_id) references category(id),
  constraint fk_m065_four_record_template_category_region_id foreign key(region_id) references category(id),
  constraint fk_org_category_m065_four_record_template foreign key(org_category_id) references org_category(id)
) comment '四不放过记录模板表';
