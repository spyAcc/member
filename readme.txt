member对外提供4个service

userservice
menuservice
institutionservice
systemservice


可以选择开启redis缓存，或者不开启
redis缓存回缓存 token（用户信息，角色，权限，菜单，岗位，机构），日历，字典，模板

mem-core 核心
mem-client 客户端jar（业务系统引用）

rest服务4个
mem-rest 核心权限服务，登陆认证等
mem-id 序号生成服务(snowflake算法，集成到mem-core里面)
mem-job 定时任务服务
mem-wf 工作流服务

mem-cache redis缓存支持
mem-tool 长用工具类




ROOT为根系统，所有root建立系统都为子系统，子系统间有权限隔离



member支持springboot集成，oauth2集成，docker部署


mem-console 客户端系统案例，负责核心系统的界面管理
