#! /bin/bash

source ../conf/set_env.sh

db_name='zhangxin'
in_csv_filepath=$1
one_partition=$2
out_tb='weibo_origin'


$HIVE -e "
    use $db_name;
    load data local inpath '$in_csv_filepath' overwrite into table $out_tb partition (week_seq='$one_partition');
"
ret_flag=$?

if [ $ret_flag -ne 0  ]; then
    echo "hive脚本执行失败，状态码是$ret_flag,请检查代码正确性"
else
   # rm $in_csv_filepath
   echo "成功删除csv原文件"$in_csv_filepath
fi
