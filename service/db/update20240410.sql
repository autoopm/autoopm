ALTER TABLE sys_dynamic_component ADD type INT(11) comment "0：分组，1：vue组件" AFTER compile_css;
ALTER TABLE sys_dynamic_component ADD remark text comment "备注" AFTER type;
update sys_dynamic_component set type = 0 where id in(select * from (select pid from sys_dynamic_component where is_del = 0) a) and is_del = 0
