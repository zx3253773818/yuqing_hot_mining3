#! /bin/bash

source ../conf/set_env.sh

db_name='zhangxin'
tb_name='weibo_seg_wc_v2'
$HIVE -e "
  use $db_name;
  create table $tb_name(
word string,
freq int) 
comment 'weibo seg wc' 
partitioned by (week_seq string comment 'the week sequence') 
row format delimited 
fields terminated by ',' 
lines terminated by '\n' 
stored as orcfile;
"
