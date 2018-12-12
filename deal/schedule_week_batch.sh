#! /bin/bash

#批量周数据处理
#获取输入zip文件夹中的zip_file列表，逐个传入schedule_week_once最细粒度调度器中执行

in_zip_dir='/home/zhangxin/yuqing_hot_mining3/udf/*.tar.gz'
out_csv_dir='/home/zhangxin/yuqing_hot_mining3/udf'


zip_files=`ls $in_zip_dir 2>/dev/null`
if [ ! "$zip_files"  ]; then
    echo "zip目录为空,请检查,将退出执行!"
    exit
fi

echo '即将开始执行'

for one_zip_file in $zip_files; do
    week_seq=`echo $one_zip_file | cut -d / -f6 | cut -d '.' -f1`
    sh schedule_week_once.sh $week_seq $one_zip_file $out_csv_dir
done

echo '全部执行完毕'
