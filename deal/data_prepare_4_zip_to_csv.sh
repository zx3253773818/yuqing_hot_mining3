#! /bin/bash

in_zip_file=$1
out_csv_dir=$2

tar -zxvf $in_zip_file -C $out_csv_dir

ret_flag=$?

if [ $ret_flag -ne 0  ]; then
    echo "处理zip文件"$in_zip_file"出现异常，请检查!"
    echo $ret_flag
else 
    echo "已解压完zip文件"$in_zip_file
#    echo "即将删除zip原文件"$in_zip_file

#    rm $input_zip_file
#    echo "成功删除zip原文件"$in_zip_file
fi
