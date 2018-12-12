#! /bin/bash

source ../conf/set_env.sh

db_name='zhangxin'
in_file='../udf/stopwords.txt'
out_tb='weibo_stopwords'

$HIVE -e "
  use $db_name;
  load data local inpath '$in_file' overwrite into table $out_tb;
"

