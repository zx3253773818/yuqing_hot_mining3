#! /bin/bash

source ../conf/set_env.sh

db_name='zhangxin'
tb_name='weibo_product'

$HIVE -e "
  use $db_name;
  create table $tb_name(
    mid string,
    retweeted_status_mid string,
    uid string,
    retweeted_uid string,
    source string,
    image string,
    text string,
    geo string,
    created_at string,
    deleted_last_seen string,
    permission_denied string) 
comment 'weibo product content table' 
partitioned by (week_seq string comment 'the week sequence')
row format delimited 
fields terminated by ',' 
lines terminated by '\n' 
stored as orcfile;
"
