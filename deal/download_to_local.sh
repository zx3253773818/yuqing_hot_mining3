#! /bin/bash

source ../conf/set_env.sh


db_name='zhangxin'
in_tb='weibo_seg_wc_v2'
out_file='./download_data'

one_partition=$1

$HIVE -e "
  use $db_name;
  insert overwrite local directory '$out_file' 
  row format delimited fields terminated by '\t' 
select * from $in_tb where week_seq='$one_partition' 
order by freq desc 
limit 100;
"

