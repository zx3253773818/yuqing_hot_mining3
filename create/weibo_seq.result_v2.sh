#! /bin/bash

source ../conf/set_env.sh

db_name='zhangxin'
tb_name='weibo_seq_result_v2'

$HIVE -e "
  use $db_name;
  create external table $tb_name(
mid string,
retweeted_status_mid string,
uid string,
retweeted_uid string,
source string,
text string,
text_seg string,
geo string,
created_at string
) comment 'weibo_seq_result' 
partitioned by (week_seq string comment 'the week sequence') 
row format delimited fields terminated by ',' 
lines terminated by '\n' 
stored as orcfile;
"
