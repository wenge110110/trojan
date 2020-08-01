" "
"================================="
"    开始下载伪装站点源码并部署"
" 1.旅游网站"
" 2.餐饮店铺外卖网站"
"================================="
	echo
    read -p "请输入数字:" num
    case "$num" in
		1)
		lvyou
		;;
		2)
		餐饮店铺外卖网站
		;;
lvyou(){
    rm -rf /usr/share/nginx/html/*
    cd /usr/share/nginx/html/
    wget https://github.com/wenge110110/trojan/raw/master/web.zip
    unzip web.zip
}

餐饮店铺外卖网站(){
    rm -rf /usr/share/nginx/html/*
    cd /usr/share/nginx/html/
    wget https://github.com/wenge110110/trojan/raw/master/foodbuzz.zip
    unzip foodbuzz.zip
}
