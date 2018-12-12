#! /bin/bash

source ../conf/set_env.sh

db_name='zhangxin'
out_tb='weibo_seg_wc_v2'
in_tb='weibo_seq_result_v2'

one_partition=$1

$HIVE -e "
use $db_name;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table $out_tb partition(week_seq) 
select main.word,main.freq,main.week_seq from 
  (select word,count(1) as freq,week_seq 
  from $in_tb 
  lateral view explode(split(text_seg,'\001')) word_table as word 
  where week_seq='$one_partition' and text_seg is not null and length(word)>1 
  group by week_seq,word 
  order by freq desc)main 
left join (select word from weibo_stopwords)filter
on main.word = filter.word 
where filter.word is null;
"
