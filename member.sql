-- 实体表
drop table if exists mem_system;
drop table if exists mem_user;
drop table if exists mem_role;
drop table if exists mem_resource;
drop table if exists mem_menu;
drop table if exists mem_menu_mobile;
drop table if exists mem_institution;
drop table if exists mem_position;
drop table if exists mem_message;
drop table if exists mem_token;
drop table if exists mem_calendar;
drop table if exists mem_dict;
drop table if exists mem_template;
-- drop table if exists mem_sequence64;
-- 关系表
drop table if exists mem_sys_user;
drop table if exists mem_sys_user_institution;
drop table if exists mem_sys_dict;
drop table if exists mem_sys_template;
drop table if exists mem_user_institution;
drop table if exists mem_user_position;
drop table if exists mem_user_message;
drop table if exists mem_user_role;
drop table if exists mem_role_resource;
drop table if exists mem_role_menu;


create table mem_token (
  tokid varchar(64) PRIMARY KEY NOT NULL ,
  tvalue varchar(2000) NOT NULL ,
  regtime datetime NOT NULL ,
  reguid varchar(20) NOT NULL ,
  upttime datetime ,
  uptuid varchar(20)
)engine=innodb,charset=utf8;

create table mem_system (
  sid varchar(20) PRIMARY KEY NOT NULL ,
  cid varchar(20) NOT NULL ,
  sname varchar(30) NOT NULL ,
  descr varchar(200) NOT NULL DEFAULT '',
  islock tinyint(1) NOT NULL DEFAULT false,
  sort int NOT NULL DEFAULT 0,
  regtime datetime NOT NULL ,
  reguid varchar(20) NOT NULL ,
  upttime datetime ,
  uptuid varchar(20)
)engine=innodb,charset=utf8;


create table mem_calendar (
  cid varchar(20) PRIMARY KEY NOT NULL ,
  cname varchar(50) NOT NULL ,
  year varchar(4) NOT NULL ,
  month varchar(2) NOT NULL ,
  cdate date NOT NULL ,
  regtime datetime NOT NULL ,
  reguid varchar(20) NOT NULL ,
  upttime datetime ,
  uptuid varchar(20)
)engine=innodb,charset=utf8;


-- 记录系统管理员
create table mem_sys_user (
  sid varchar(20) NOT NULL ,
  uid varchar(20) NOT NULL ,
  regtime datetime NOT NULL ,
  reguid varchar(20) NOT NULL ,
  upttime datetime ,
  uptuid varchar(20),
  PRIMARY KEY (sid, uid)
)engine=innodb,charset=utf8;

-- 记录系统管理员管那些机构
create table mem_sys_user_institution (
  sid varchar(20) NOT NULL ,
  uid varchar(20) NOT NULL ,
  instid varchar(20) NOT NULL ,
  regtime datetime NOT NULL ,
  reguid varchar(20) NOT NULL ,
  upttime datetime ,
  uptuid varchar(20),
  PRIMARY KEY (sid, uid, instid)
)engine=innodb,charset=utf8;


create table mem_user (
  uid varchar(20) PRIMARY KEY NOT NULL ,
  passwd varchar(64) NOT NULL ,
  uname varchar(30) NOT NULL ,
  phone varchar(20) NOT NULL DEFAULT '',
  email varchar(50) NOT NULL DEFAULT '',
  address varchar(200) NOT NULL DEFAULT '',
  birthday datetime NOT NULL ,
  sex char(1) NOT NULL DEFAULT '',
  idcard varchar(30) NOT NULL DEFAULT '',
  salarycard varchar(30) NOT NULL DEFAULT '',
  profile varchar(1000) NOT NULL DEFAULT '',
  level int NOT NULL DEFAULT 0, #用户级别，越小越大
  icon varchar(200) NOT NULL DEFAULT '', #用户头像
  sort int NOT NULL DEFAULT 0, #系统排序
  issys tinyint(1) NOT NULL DEFAULT 0, #是否时系统管理员
  isvirtual tinyint(1) NOT NULL DEFAULT 0, #是否时虚拟用户
  isroot tinyint(1) NOT NULL DEFAULT 0, #是否时超级管理员
  islock tinyint(1) NOT NULL DEFAULT 0, #是否被锁定
  islive tinyint(1) NOT NULL DEFAULT 1, #是否是激活状态
  regtime datetime NOT NULL , #注册时间
  upttime datetime ,
  uptuid varchar(20)
)engine=innodb,charset=utf8;


create table mem_user_role (
  uid varchar(20) NOT NULL ,
  rid varchar(20) NOT NULL ,
  regtime datetime NOT NULL ,
  reguid varchar(20) NOT NULL ,
  upttime datetime ,
  uptuid varchar(20) ,
  PRIMARY KEY (uid, rid)
)engine=innodb,charset=utf8;


create table mem_role (
  rid varchar(20) PRIMARY KEY NOT NULL ,
  rname varchar(30) NOT NULL ,
  sid varchar(20) NOT NULL, #外键system的sid
  descr varchar(100) NOT NULL DEFAULT '' ,
  islock tinyint(1) NOT NULL DEFAULT 0,
  regtime datetime NOT NULL ,
  reguid varchar(20) NOT NULL ,
  upttime datetime ,
  uptuid varchar(20)
)engine=innodb,charset=utf8;


create table mem_role_resource (
  rid varchar(20) NOT NULL ,
  rsid varchar(20) NOT NULL ,
  level int NOT NULL DEFAULT 15, #4位2进制表示 增8，删4，改2，查1， 权限注解@res("rsid", 15)
  regtime datetime NOT NULL ,
  reguid varchar(20) NOT NULL ,
  upttime datetime ,
  uptuid varchar(20),
  PRIMARY KEY (rid, rsid)
)engine=innodb,charset=utf8;


create table mem_resource (
  rsid varchar(20) PRIMARY KEY NOT NULL ,
  rsname varchar(30) NOT NULL ,
  sid varchar(20) NOT NULL, #外键system的sid
  descr varchar(100) NOT NULL DEFAULT '' ,
  url varchar(200) NOT NULL DEFAULT '',
  regtime datetime NOT NULL ,
  reguid varchar(20) NOT NULL ,
  upttime datetime ,
  uptuid varchar(20)
)engine=innodb,charset=utf8;


create table mem_menu (
  mid varchar(20) PRIMARY KEY NOT NULL ,
  rsid varchar(20) NOT NULL DEFAULT '',
  pmid varchar(20) NOT NULL DEFAULT '$',
  mname varchar(100) NOT NULL ,
  icon varchar(200) NOT NULL DEFAULT '',
  sort int NOT NULL DEFAULT 0,
  hiden tinyint(1) DEFAULT 0,
  regtime datetime NOT NULL ,
  reguid varchar(20) NOT NULL ,
  upttime datetime ,
  uptuid varchar(20)
)engine=innodb,charset=utf8;


create table mem_menu_mobile (
  mid varchar(20) PRIMARY KEY NOT NULL ,
  rsid varchar(20) NOT NULL DEFAULT '',
  pmid varchar(20) NOT NULL DEFAULT '$',
  mname varchar(100) NOT NULL ,
  icon varchar(200) NOT NULL DEFAULT '',
  sort int NOT NULL DEFAULT 0,
  hiden tinyint(1) DEFAULT 0,
  regtime datetime NOT NULL ,
  reguid varchar(20) NOT NULL ,
  upttime datetime ,
  uptuid varchar(20)
)engine=innodb,charset=utf8;

create table mem_role_menu (
  rid varchar(20) NOT NULL ,
  mid varchar(20) NOT NULL ,
  ismobile tinyint(1) NOT NULL ,
  regtime datetime NOT NULL ,
  reguid varchar(20) NOT NULL ,
  upttime datetime ,
  uptuid varchar(20),
  PRIMARY KEY (rid, mid)
)engine=innodb,charset=utf8;



create table mem_institution (
  instid varchar(20) PRIMARY KEY NOT NULL ,
  instname varchar(20) NOT NULL ,
  owner varchar(20) NOT NULL ,
  pinstid varchar(20) NOT NULL DEFAULT '$',
  path varchar(128) NOT NULL ,
  fullname varchar(1000) NOT NULL DEFAULT '',
  sort int NOT NULL DEFAULT 0,
  regtime datetime NOT NULL ,
  reguid varchar(20) NOT NULL ,
  upttime datetime ,
  uptuid varchar(20)
)engine=innodb,charset=utf8;


create table mem_user_institution (
  uid varchar(20) NOT NULL ,
  instid varchar(20) NOT NULL ,
  ismain tinyint(1) NOT NULL DEFAULT 0, #是否主机构
  regtime datetime NOT NULL ,
  reguid varchar(20) NOT NULL ,
  upttime datetime ,
  uptuid varchar(20),
  PRIMARY KEY (uid, instid)
)engine=innodb,charset=utf8;



create table mem_message (
  msgid int PRIMARY KEY AUTO_INCREMENT NOT NULL ,
  msgtitle varchar(50) NOT NULL ,
  msgvalue varchar(1000) NOT NULL,
  regtime datetime NOT NULL ,
  reguid varchar(20) NOT NULL ,
  upttime datetime ,
  uptuid varchar(20)
)engine=innodb,charset=utf8;



create table mem_user_message (
  uid varchar(20) NOT NULL ,
  msgid varchar(20) NOT NULL ,
  isread tinyint(1) NOT NULL DEFAULT 0,
  regtime datetime NOT NULL ,
  reguid varchar(20) NOT NULL ,
  upttime datetime ,
  uptuid varchar(20),
  PRIMARY KEY (uid, msgid)
)engine=innodb,charset=utf8;



create table mem_position (
  pid varchar(20) PRIMARY KEY NOT NULL,
  pname varchar(50) NOT NULL ,
  level int NOT NULL DEFAULT 0, #岗位级别，越大越好
  regtime datetime NOT NULL ,
  reguid varchar(20) NOT NULL ,
  upttime datetime ,
  uptuid varchar(20)
)engine=innodb,charset=utf8;



create table mem_user_position (
  uid varchar(20) NOT NULL ,
  pid varchar(20) NOT NULL ,
  regtime datetime NOT NULL ,
  reguid varchar(20) NOT NULL ,
  upttime datetime ,
  uptuid varchar(20),
  PRIMARY KEY (uid, pid)
)engine=innodb,charset=utf8;



create table mem_dict (
  did varchar(20)  NOT NULL ,
  dname varchar(20) NOT NULL ,
  itemid varchar(20) NOT NULL ,
  itemname varchar(50) NOT NULL ,
  regtime datetime NOT NULL ,
  reguid varchar(20) NOT NULL ,
  upttime datetime ,
  uptuid varchar(20),
  PRIMARY KEY (did, itemid)
)engine=innodb,charset=utf8;


create table mem_sys_dict (
  sid varchar(20) NOT NULL ,
  did varchar(20) NOT NULL ,
  regtime datetime NOT NULL ,
  reguid varchar(20) NOT NULL ,
  upttime datetime ,
  uptuid varchar(20),
  PRIMARY KEY (sid, did)
)engine=innodb,charset=utf8;


create table mem_template (
  tid varchar(20) PRIMARY KEY NOT NULL ,
  tname varchar(50) NOT NULL ,
  tvalue varchar(1000) NOT NULL ,
  regtime datetime NOT NULL ,
  reguid varchar(20) NOT NULL ,
  upttime datetime ,
  uptuid varchar(20)
)engine=innodb,charset=utf8;


create table mem_sys_template (
  sid varchar(20) NOT NULL ,
  tid varchar(20) NOT NULL ,
  regtime datetime NOT NULL ,
  reguid varchar(20) NOT NULL ,
  upttime datetime ,
  uptuid varchar(20),
  PRIMARY KEY (sid, tid)
)engine=innodb,charset=utf8;


/*create table mem_sequence64 (
  id bigint(20) unsigned not null auto_increment primary key,
  stub char(1) not null default '',
  unique key stub (stub)
)engine=innodb,charset=utf8;*/


