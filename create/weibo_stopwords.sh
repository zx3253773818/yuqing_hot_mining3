#! /bin/bash

source ../conf/set_env.sh

db_name='zhangxin'
tb_name='weibo_stopwords'

$HIVE -e "
use $db_name;
CREATE external TABLE weibo_stopwords(
word string
) 
comment 'weibo stopwords' 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' 
STORED AS textfile;
"
