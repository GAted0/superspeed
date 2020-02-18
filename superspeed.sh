#!/usr/bin/env bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE="\033[0;35m"
CYAN='\033[0;36m'
PLAIN='\033[0m'

# check root
[[ $EUID -ne 0 ]] && echo -e "${RED}Error:${PLAIN} This script must be run as root!" && exit 1

# check python
if  [ ! -e '/usr/bin/python' ]; then
		echo -e
		read -p "${RED}Error:${PLAIN} python is not install. You must be install python command at first.\nDo you want to install? [y/n]" is_install
		if [[ ${is_install} == "y" || ${is_install} == "Y" ]]; then
			if [ "${release}" == "centos" ]; then
						yum -y install python
				else
						apt-get -y install python
				fi
		else
			exit
		fi
		
fi

# check wget
if  [ ! -e '/usr/bin/wget' ]; then
		echo -e
		read -p "${RED}Error:${PLAIN} wget is not install. You must be install wget command at first.\nDo you want to install? [y/n]" is_install
		if [[ ${is_install} == "y" || ${is_install} == "Y" ]]; then
				if [ "${release}" == "centos" ]; then
						yum -y install wget
				else
						apt-get -y install wget
				fi
		else
				exit
		fi
fi


clear

Echo "-- -- -- -- -- -- -- -- -- -- -- -- -- SuperSpeed comprehensive speed measurement version -- -- -- -- --
Echo "usage: bash < (curl - LSO - https://git.io/superspeed)"
Echo "view all nodes: https://git.io/superspeedlist"
Echo "node update date: July 2, 2019"
echo "———————————————————————————————————————————————————————————————————"
Echo "do you want to conduct comprehensive speed measurement? (the failed speed measurement node will automatically skip)"
Echo - Ne "1. Confirm speed measurement 2. Cancel speed measurement"

while :; do echo
		read -p "please enter a number to select: " telecom
		if [[ ! $telecom =~ ^[1-2]$ ]]; then
				echo "input error, please input the correct number!"
		else
				break   
		fi
done

[[ ${telecom} == 2 ]] && exit 1

# install speedtest
if  [ ! -e '/tmp/speedtest.py' ]; then
	wget --no-check-certificate -P /tmp https://raw.github.com/sivel/speedtest-cli/master/speedtest.py > /dev/null 2>&1
fi
chmod a+rx /tmp/speedtest.py

speed_test(){
	temp=$(python /tmp/speedtest.py --server $1 --share 2>&1)
	is_down=$(echo "$temp" | grep 'Download') 
	if [[ ${is_down} ]]; then
		local REDownload=$(echo "$temp" | awk -F ':' '/Download/{print $2}')
		local reupload=$(echo "$temp" | awk -F ':' '/Upload/{print $2}')
		local relatency=$(echo "$temp" | awk -F ':' '/Hosted/{print $2}')
		temp=$(echo "$relatency" | awk -F '.' '{print $1}')
		if [[ ${temp} -gt 1000 ]]; then
			relatency=" > 1 s"
		fi
		local nodeID=$1
		local nodeLocation=$2
		local nodeISP=$3

		printf "${RED}%-8s${YELLOW}%-10s${GREEN}%-10s${CYAN}%-16s${BLUE}%-16s${PURPLE}%-10s${PLAIN}\n" "${nodeID}  " "${nodeISP}  " "${nodeLocation}  " "${reupload}  " "${REDownload}  " "${relatency}"
	else
		local cerror="ERROR"
	fi
}

if [[ ${telecom} == 1 ]]; then
	echo "———————————————————————————————————————————————————————————————————"
	printf "%-8s%-10s%-10s%-16s%-16s%-10s\n" "节点ID  " "运营商  " "位置     " "上传速度        " "下载速度        " "延迟"
	start=$(date +%s) 
	# ct
	speed_test '6132' '长沙' 'ct'
	speed_test '3633' '上海' 'ct'
	speed_test '3973' '兰州' 'ct'
	speed_test '4751' '北京' 'ct'
	speed_test '5316' '南京' 'ct'
	speed_test '10305' '南宁1' 'ct'
	speed_test '22724' '南宁2' 'ct'
	speed_test '10192' '南宁3' 'ct'
	speed_test '16399' '南昌1' 'ct'
	speed_test '6473' '南昌2' 'ct'
	speed_test '6345' '南昌3' 'ct'
	speed_test '7643' '南昌4' 'ct'
	speed_test '17145' '合肥' 'ct'
	speed_test '24012' '呼和浩特' 'ct'
	speed_test '6714' '天津' 'ct'
	speed_test '10775' '广州1' 'ct'
	speed_test '9151' '广州2' 'ct'
	speed_test '17251' '广州3' 'ct'
	speed_test '5324' '徐州' 'ct'
	speed_test '4624' '成都' 'ct'
	speed_test '6168' '昆明' 'ct'
	speed_test '7509' '杭州' 'ct'
	speed_test '23844' '武汉1' 'ct'
	speed_test '20038' '武汉2' 'ct'
	speed_test '23665' '武汉3' 'ct'
	speed_test '24011' '武汉4' 'ct'
	speed_test '5081' '深圳' 'ct'
	speed_test '5396' '苏州' 'ct'
	speed_test '6435' '襄阳1' 'ct'
	speed_test '12637' '襄阳2' 'ct'
	speed_test '19918' '西宁' 'ct'
	speed_test '5317' '连云港' 'ct'
	speed_test '4595' '郑州' 'ct'
	speed_test '21470' '鄂尔多斯' 'ct'
	speed_test '19076' '重庆1' 'ct'
	speed_test '6592' '重庆2' 'ct'
	speed_test '16983' '重庆3' 'ct'
	# cu
	speed_test '5145' '北京1' 'cu'
	speed_test '18462' '北京2' 'cu'
	speed_test '5505' '北京3' 'cu'
	speed_test '9484' '长春1' 'cu'
	speed_test '10742' '长春2' 'cu'
	speed_test '4870' '长沙' 'cu'
	speed_test '2461' '成都' 'cu'
	speed_test '5726' '重庆' 'cu'
	speed_test '4884' '福州' 'cu'
	speed_test '3891' '广州' 'cu'
	speed_test '5985' '海口' 'cu'
	speed_test '5300' '杭州' 'cu'
	speed_test '5460' '哈尔滨' 'cu'
	speed_test '5724' '合肥' 'cu'
	speed_test '5465' '呼和浩特' 'cu'
	speed_test '5039' '济南1' 'cu'
	speed_test '12538' '济南2' 'cu'
	speed_test '5103' '昆明' 'cu'
	speed_test '4690' '兰州' 'cu'
	speed_test '5750' '拉萨' 'cu'
	speed_test '7230' '南昌1' 'cu'
	speed_test '5097' '南昌2' 'cu'
	speed_test '5446' '南京1' 'cu'
	speed_test '13704' '南京2' 'cu'
	speed_test '5674' '南宁' 'cu'
	speed_test '6245' '宁波' 'cu'
	speed_test '5509' '宁夏' 'cu'
	speed_test '5710' '青岛' 'cu'
	speed_test '21005' '上海1' 'cu'
	speed_test '24447' '上海2' 'cu'
	speed_test '5083' '上海3' 'cu'
	speed_test '5017' '沈阳' 'cu'
	speed_test '10201' '深圳' 'cu'
	speed_test '19736' '太原1' 'cu'
	speed_test '12868' '太原2' 'cu'
	speed_test '12516' '太原3' 'cu'
	speed_test '5475' '天津' 'cu'
	speed_test '6144' '乌鲁木齐' 'cu'
	speed_test '5485' '武汉' 'cu'
	speed_test '5506' '厦门' 'cu'
	speed_test '5992' '西宁' 'cu'
	speed_test '5131' '郑州1' 'cu'
	speed_test '6810' '郑州2' 'cu'
	# cm
	speed_test '4665' '上海1' 'cm'
	speed_test '16719' '上海2' 'cm'
	speed_test '16803' '上海3' 'cm'
	speed_test '17388' '临沂' 'cm'
	speed_test '3784' '乌鲁木齐1' 'cm'
	speed_test '16858' '乌鲁木齐2' 'cm'
	speed_test '17228' '伊犁' 'cm'
	speed_test '16145' '兰州' 'cm'
	speed_test '4713' '北京' 'cm'
	speed_test '21590' '南京' 'cm'
	speed_test '15863' '南宁' 'cm'
	speed_test '16294' '南昌1' 'cm'
	speed_test '16332' '南昌2' 'cm'
	speed_test '21530' '南通' 'cm'
	speed_test '21642' '台州' 'cm'
	speed_test '4377' '合肥' 'cm'
	speed_test '17085' '呼和浩特' 'cm'
	speed_test '17437' '哈尔滨' 'cm'
	speed_test '10939' '商丘' 'cm'
	speed_test '17245' '喀什' 'cm'
	speed_test '17184' '天津' 'cm'
	speed_test '16005' '太原' 'cm'
	speed_test '6715' '宁波' 'cm'
	speed_test '21722' '宿迁' 'cm'
	speed_test '21845' '常州' 'cm'
	speed_test '6611' '广州' 'cm'
	speed_test '22349' '徐州' 'cm'
	speed_test '24337' '成都1' 'cm'
	speed_test '4575' '成都2' 'cm'
	speed_test '21600' '扬州' 'cm'
	speed_test '18444' '拉萨1' 'cm'
	speed_test '17494' '拉萨2' 'cm'
	speed_test '5122' '无锡1' 'cm'
	speed_test '21973' '无锡2' 'cm'
	speed_test '5892' '昆明' 'cm'
	speed_test '4647' '杭州1' 'cm'
	speed_test '12278' '杭州2' 'cm'
	speed_test '16395' '武汉' 'cm'
	speed_test '16167' '沈阳' 'cm'
	speed_test '16314' '济南1' 'cm'
	speed_test '17480' '济南2' 'cm'
	speed_test '16503' '海口' 'cm'
	speed_test '22037' '淮安' 'cm'
	speed_test '4515' '深圳' 'cm'
	speed_test '21946' '盐城' 'cm'
	speed_test '17223' '石家庄' 'cm'
	speed_test '16171' '福州' 'cm'
	speed_test '3927' '苏州1' 'cm'
	speed_test '21472' '苏州2' 'cm'
	speed_test '18504' '西宁1' 'cm'
	speed_test '16915' '西宁2' 'cm'
	speed_test '16398' '贵阳1' 'cm'
	speed_test '7404' '贵阳2' 'cm'
	speed_test '21584' '连云港' 'cm'
	speed_test '18970' '郑州1' 'cm'
	speed_test '4486' '郑州2' 'cm'
	speed_test '16409' '重庆1' 'cm'
	speed_test '17584' '重庆2' 'cm'
	speed_test '16392' '银川' 'cm'
	speed_test '17320' '镇江' 'cm'
	speed_test '16375' '长春' 'cm'
	speed_test '15862' '长沙' 'cm'
	speed_test '17432' '青岛' 'cm'
	speed_test '17222' '阿勒泰' 'cm'
	speed_test '17230' '阿拉善' 'cm'
	speed_test '17227' '和田' 'cm'

	end=$(date +%s)  
	rm -rf /tmp/speedtest.py
	echo "———————————————————————————————————————————————————————————————————"
	time=$(( $end - $start ))
	if [[ $time -gt 60 ]]; then
		min=$(expr $time / 60)
		sec=$(expr $time % 60)
		echo -ne "测试完成, 本次测速耗时: ${min} 分 ${sec} 秒"
	else
		echo -ne "测试完成, 本次测速耗时: ${time} 秒"
	fi
	echo -ne "\n当前时间: "
	echo $(date +%Y-%m-%d" "%H:%M:%S)
fi
