#! /bin/bash

mysql -h192.168.1.15  -ujob004_group3 -pjob004_group3 -e "
  use group3_weibo;
  LOAD DATA LOCAL INFILE './download_data/000000_0' INTO TABLE zx_weibo_hot_words FIELDS TERMINATED BY '\t';
"
