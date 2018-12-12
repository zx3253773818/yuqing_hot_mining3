#! /bin/bash

#最细周粒度的执行

in_one_partition=$1
in_zip_file=$2
out_csv_dir=$3

#1 zip -> csv
echo '1 正在执行zip -> csv' 
sh data_prepare_4_zip_to_csv.sh $in_zip_file $out_csv_dir
ret_flag=$?
if [ $ret_flag -ne 0  ]; then
    echo "data_prepare出现处理异常，将中断流程执行!"
    exit $ret_flag 
fi

#2 csv -> origin
echo '2 正在执行csv -> origin' 
sh produce_weibo_origin.sh $out_csv_dir  $in_one_partition 

#3 origin -> product
echo '3 正在执行origin -> product' 
sh produce_weibo_product.sh $in_one_partition

#4 product -> seq_result
echo '4 正在执行product -> seq_result' 
sh produce_weibo_seq.result_v2.sh $in_one_partition

#5 seq_result -> seg_wc
echo '5 正在执行seq_result -> seg_wc' 
sh produce_weibo_seg_wc_v2.sh $in_one_partition

#6 seg_wc -> loacl
echo '6 正在执行seg_wc -> loacl' 
sh download_to_local.sh $in_one_partition

#7 local -> mysql
echo '7 正在执行local -> mysql' 
sh upload_to_mysql.sh
