#!/bin/bash
. /etc/profile
#. ~/.bash_profile
##################################################
# Author: lxy                                    #
# create date: 2015-10-10                        #
# Content:                                       #
##################################################
path=$(cd "$(dirname "$0")"; pwd)
cd "$path"
source config.sh
source init_common.sh
source fun_common.sh
log_path="$path"
path="$path""/workspace"
cd "$path"

#validate and init params
if [ $# -eq 2 ]
then
 f_init_params $1 $2;
 echo "use given parameters:v_bg_time_key=${v_bg_time_key},v_ed_time_key=${v_ed_time_key}"
elif [ $# -eq 0 ]
then
 f_init_params;
 echo "use default parameters:v_bg_time_key=${v_bg_time_key},v_ed_time_key=${v_ed_time_key}"
else
 echo "Usage: $0 p_bg_time_key as yyyymmddhh,p_ed_time_key as yyyymmddhh"
 exit 1
fi

echo mysql_host=${mysql_host}
echo mysql_port=${mysql_port}
echo mysql_user=${mysql_user}
echo mysql_pwd=${mysql_pwd}
echo mysql_db_bi=${mysql_db_bi}

while [ $v_bg_time_key -le $v_ed_time_key ]
do

echo v_bg_time_key=$v_bg_time_key 
echo v_ed_time_key=$v_ed_time_key

hadoop fs -mkdir /user/hive/warehouse/ext_data/log_act/year=${v_bg_year}/month=${v_bg_month}/day=${v_bg_day}/hour=${v_bg_hour}

echo 'finish sucess!'
v_bg_time_key=$(date_add $v_bg_time_key 1 "hour")
f_init_params $v_bg_time_key $v_ed_time_key

done