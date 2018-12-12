#! /bin/bash
source ../conf/set_env.sh

db_name='zhangxin'
in_tb='weibo_origin'
out_tb='weibo_product'

one_partition=$1

$HIVE -e "
  use $db_name;
  set hive.exec.dynamic.partition.mode=nonstrict;
  from (select * from $in_tb where week_seq='$one_partition')tab
  insert overwrite table $out_tb partition(week_seq) 
  select *  where mid != 'mid';
"
