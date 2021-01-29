#!/bin/bash

Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[信息]${Font_color_suffix}"
Error="${Red_font_prefix}[错误]${Font_color_suffix}"
Tip="${Green_font_prefix}[注意]${Font_color_suffix}"

blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}

if [[ -f /etc/redhat-release ]]; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
fi

change_panel(){
if test -s /etc/systemd/system/trojan-web.service; then
echo && echo -e "


${Font_color_suffix}=================================
${Green_font_prefix}检测到Trojan面板服务，开始配置
${Font_color_suffix}================================="
echo
	sleep 2s
	$systemPackage update -y
	$systemPackage -y install nginx unzip curl wget
	systemctl enable nginx
	systemctl stop nginx
if test -s /etc/nginx/nginx.conf; then
	rm -rf /etc/nginx/nginx.conf
  wget -P /etc/nginx https://raw.githubusercontent.com/wenge110110/trojan/master/nginx.conf
echo && echo -e "
${Font_color_suffix}=================================
${Green_font_prefix}请输入Trojan绑定的域名
${Font_color_suffix}================================="
echo
	read your_domain
  sed -i "s/localhost/$your_domain/;" /etc/nginx/nginx.conf
echo && echo -e "
start_webweizhuang(){
${Font_color_suffix}=================================
${Font_color_suffix}开始下载伪装站点源码并部署
${Green_font_prefix}1.${Font_color_suffix}旅游网站
${Green_font_prefix}2.${Font_color_suffix}餐饮店铺外卖网站
${Green_font_prefix}3.${Font_color_suffix}随机密码生成器
${Green_font_prefix}4.${Font_color_suffix}野外露营旅游网站
${Green_font_prefix}5.${Font_color_suffix}全民飞机大战小游戏
${Green_font_prefix}6.${Font_color_suffix}年会抽奖程序网站
${Green_font_prefix}7.${Font_color_suffix}农田种植技术网站
${Green_font_prefix}8.${Font_color_suffix}汽车改装维修公司网站
${Green_font_prefix}9.${Font_color_suffix}生活记录个人相册博客
${Green_font_prefix}10.${Font_color_suffix}外卖送餐APP官网
${Green_font_prefix}11.${Font_color_suffix}有机农业牧场网站
${Green_font_prefix}12.${Font_color_suffix}Netflix-SG
${Green_font_prefix}13.${Font_color_suffix}Netflix-IT
${Green_font_prefix}99.${Font_color_suffix}口红色号选择
${Font_color_suffix}================================="
	echo
    read -p "请输入数字:" num
    case "$num" in
		1)
		旅游网站
		;;
		2)
		餐饮店铺外卖网站
		;;
		3)
		随机密码生成器
		;;
		4)
		野外露营旅游网站
		;;
		5)
		全民飞机大战小游戏
		;;
		6)
		年会抽奖程序网站
		;;
		7)
		农田种植技术网站
		;;
		8)
		汽车改装维修公司网站
		;;
		9)
		生活记录个人相册博客
		;;
		10)
		外卖送餐APP官网
		;;
		11)
		有机农业牧场网站
		;;
		12)
		Netflix-SG
		;;
		13)
		Netflix-IT
		;;
		99)
		口红色号选择
		;;
		*)
			clear
}
	echo "num
	[[ -z "$num" ]] && num="10"
	echo $((${num}+0)) &>/dev/null"
	echo "正在安装默认网站伪装页面"
	sleep 2s
	start_webweizhuang
	;;
	
    esac
	echo && echo -e "
${Font_color_suffix}=================================
${Green_font_prefix}开始配置trojan-web
${Font_color_suffix}================================="
echo
	sleep 2s
	set_trojan_port

else
echo && echo -e "
${Font_color_suffix}===============================
${Error}     Nginx未正确安装 请重试
${Font_color_suffix}==============================="
echo
	sleep 2s
	exit 1
fi
else
echo && echo -e "
${Font_color_suffix}===============================
${Error}     未检测到Trojan面板服务
${Font_color_suffix}==============================="
echo
	sleep 2s
	exit 1
fi
}

set_trojan_port(){
    while true
    do
	echo -e "请输入要设置的trojan-web端口"
	read -e -p "(端口范围1~65535,默认为12138):" trojan_port
	[[ -z "$trojan_port" ]] && trojan_port="12138"
	echo $((${trojan_port}+0)) &>/dev/null
	if [[ $? == 0 ]]; then
	if [[ ${trojan_port} -ge 1 ]] && [[ ${trojan_port} -le 65535 ]]; then
	echo && echo ${Separator_1} && echo -e "	trojan的后台端口 : ${Green_font_prefix}${trojan_port}${Font_color_suffix}" && echo ${Separator_1}
		sed -i "/ExecStart/s/trojan web -p ${trojan_port}/trojan web/g" /etc/systemd/system/trojan-web.service
		sed -i "/ExecStart/s/trojan web/trojan web -p ${trojan_port}/g" /etc/systemd/system/trojan-web.service
		systemctl daemon-reload
		systemctl restart trojan-web
		systemctl restart nginx
echo && echo -e "
${Font_color_suffix}==================================================================
 
${Font_color_suffix}  伪装站点目录 /usr/share/nginx/html 
${Font_color_suffix}  面板管理地址 ${Green_font_prefix}http://$your_domain:${trojan_port} 
 
${Font_color_suffix}==================================================================" && echo
			break
	else
			echo -e "${Error} 请输入正确的数字(1-65535)"
		fi
	else
		echo -e "${Error} 请输入正确的数字(1-65535)"
	fi
    done
}

bbr_boost_sh(){
    $systemPackage install -y wget
    wget -N --no-check-certificate "https://github.000060000.xyz/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
}

trojan_install(){
    $systemPackage install -y curl
	source <(curl -sL https://git.io/trojan-install)
}

旅游网站(){
    rm -rf /usr/share/nginx/html/*
    cd /usr/share/nginx/html/
    wget https://github.com/wenge110110/trojan/raw/master/web/web.zip
    unzip web.zip
}

餐饮店铺外卖网站(){
    rm -rf /usr/share/nginx/html/*
    cd /usr/share/nginx/html/
    wget https://github.com/wenge110110/trojan/raw/master/web/foodbuzz.zip
    unzip foodbuzz.zip
}

随机密码生成器(){
    rm -rf /usr/share/nginx/html/*
    cd /usr/share/nginx/html/
    wget https://github.com/wenge110110/trojan/raw/master/web/3.zip
    unzip 3.zip
}

野外露营旅游网站(){
    rm -rf /usr/share/nginx/html/*
    cd /usr/share/nginx/html/
    wget https://github.com/wenge110110/trojan/raw/master/web/4.zip
    unzip 4.zip
}

全民飞机大战小游戏(){
    rm -rf /usr/share/nginx/html/*
    cd /usr/share/nginx/html/
    wget https://github.com/wenge110110/trojan/raw/master/web/5.zip
    unzip 5.zip
}

年会抽奖程序网站(){
    rm -rf /usr/share/nginx/html/*
    cd /usr/share/nginx/html/
    wget https://github.com/wenge110110/trojan/raw/master/web/6.zip
    unzip 6.zip
}

农田种植技术网站(){
    rm -rf /usr/share/nginx/html/*
    cd /usr/share/nginx/html/
    wget https://github.com/wenge110110/trojan/raw/master/web/7.zip
    unzip 7.zip
}

汽车改装维修公司网站模板(){
    rm -rf /usr/share/nginx/html/*
    cd /usr/share/nginx/html/
    wget https://github.com/wenge110110/trojan/raw/master/web/8.zip
    unzip 8.zip
}

生活记录个人相册博客模板(){
    rm -rf /usr/share/nginx/html/*
    cd /usr/share/nginx/html/
    wget https://github.com/wenge110110/trojan/raw/master/web/9.zip
    unzip 9.zip
}

外卖送餐APP官网(){
    rm -rf /usr/share/nginx/html/*
    cd /usr/share/nginx/html/
    wget https://github.com/wenge110110/trojan/raw/master/web/10.zip
    unzip 10.zip
}

有机农业牧场网站(){
    rm -rf /usr/share/nginx/html/*
    cd /usr/share/nginx/html/
    wget https://github.com/wenge110110/trojan/raw/master/web/11.zip
    unzip 11.zip
}

Netflix-SG(){
    rm -rf /usr/share/nginx/html/*
    cd /usr/share/nginx/html/
    wget https://github.com/wenge110110/trojan/raw/master/web/12.zip
    unzip 12.zip
}

Netflix-IT(){
    rm -rf /usr/share/nginx/html/*
    cd /usr/share/nginx/html/
    wget https://github.com/wenge110110/trojan/raw/master/web/13.zip
    unzip 13.zip
}

口红色号选择(){
    rm -rf /usr/share/nginx/html/*
    cd /usr/share/nginx/html/
    wget https://github.com/wenge110110/trojan/raw/master/web/lipstick.zip
    unzip lipstick.zip
}


start_menu(){
clear
echo && echo -e "
${Font_color_suffix}==========================================================
${Font_color_suffix}       一键更改 Trojan-Panel 面板端口并设置伪装站点
${Font_color_suffix}==========================================================
${Font_color_suffix}      本脚本支持：Debian9+ / Ubuntu16.04+ / Centos7+
${Font_color_suffix}==========================================================
${Green_font_prefix}1.${Font_color_suffix}安装 VPS 加速
${Green_font_prefix}2.${Font_color_suffix}安装 Trojan 多用户管理部署程序
${Green_font_prefix}3.${Font_color_suffix}一键设置Trojan 面板端口并设置伪装站点
${Green_font_prefix}0.${Font_color_suffix}退出脚本"
echo
    read -p "请输入数字:" num
    case "$num" in
        1)
        bbr_boost_sh
		;;
		2)
		trojan_install
		;;
		3)
		change_panel
		;;
		0)
		exit 0
		;;
		*)
	clear
	echo "请输入正确数字"
	sleep 2s
	start_menu
	;;
    esac
}

start_menu
