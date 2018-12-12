#! /bin/bash

source ../conf/set_env.sh

db_name='zhangxin'
in_tb='weibo_product'
out_tb='weibo_seq_result_v2'

one_partition=$1

jar_path='../udf/YuqingHotMining2-jar-with-dependencies.jar'
class_path='cn.tl.udf.CwsV2UDF'

nature_list='n,nr,nr1,nr2,nrj,nrf,ns,nsf,nt,nz,nl,ng,nw'

$HIVE -e "
  use $db_name;
  set hive.exec.dynamic.partition.mode=nonstrict;
  
  add jar $jar_path;
  create temporary function seg as '$class_path';
  from (select * from  $in_tb where week_seq='$one_partition')tab 
  insert overwrite table $out_tb partition(week_seq) 
  select mid,retweeted_status_mid,uid,retweeted_uid,source,text,seg(text,'$nature_list') as text_seg,geo,created_at,week_seq;
"
