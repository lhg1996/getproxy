#!/bin/sh
del () {
if [ -f "$1" ]; then
rm -f $1
fi
}
proxy () {
del temp_$1.txt

curl -o temp_$1.txt $2
sed -i '/^\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\}:[0-9]\{1,5\}$/!d' temp_$1.txt
#awk '!seen[$0]++' temp_$1.txt > temp_$1.txt
cat temp_$1.txt >> $1.txt

sed -i 's/^/'$1':\/\/&/g' temp_$1.txt
cat temp_$1.txt >> $1_with_protocol.txt

cat temp_$1.txt >> all.txt
del temp_$1.txt
}

del file
mkdir file
cd file

# http
proxy "http" "https://fastly.jsdelivr.net/gh/jetkai/proxy-list@main/online-proxies/txt/proxies-http.txt"
proxy "http" "https://www.proxy-list.download/api/v1/get?type=http"
proxy "http" "https://raw.githubusercontent.com/TheSpeedX/PROXY-List/master/http.txt"
# https
proxy "https" "https://fastly.jsdelivr.net/gh/jetkai/proxy-list@main/online-proxies/txt/proxies-https.txt"
proxy "https" "https://fastly.jsdelivr.net/gh/roosterkid/openproxylist@main/HTTPS_RAW.txt"
proxy "https" "https://www.proxy-list.download/api/v1/get?type=https"
#socks4
proxy "socks4" "https://fastly.jsdelivr.net/gh/jetkai/proxy-list@main/online-proxies/txt/proxies-socks4.txt"
proxy "socks4" "https://fastly.jsdelivr.net/gh/TheSpeedX/PROXY-List@master/socks4.txt"
proxy "socks4" "https://fastly.jsdelivr.net/gh/roosterkid/openproxylist@main/SOCKS4_RAW.txt"
proxy "socks4" "https://www.proxy-list.download/api/v1/get?type=socks4"
proxy "socks4" "https://raw.githubusercontent.com/TheSpeedX/PROXY-List/master/socks4.txt"
#socks5
proxy "socks5" "https://fastly.jsdelivr.net/gh/jetkai/proxy-list@main/online-proxies/txt/proxies-socks5.txt"
proxy "socks5" "https://fastly.jsdelivr.net/gh/hookzof/socks5_list@master/proxy.txt"
proxy "socks5" "https://fastly.jsdelivr.net/gh/TheSpeedX/PROXY-List@master/socks5.txt"
proxy "socks5" "https://fastly.jsdelivr.net/gh/roosterkid/openproxylist@main/SOCKS5_RAW.txt"
proxy "socks5" "https://www.proxy-list.download/api/v1/get?type=socks5"
proxy "socks5" "https://raw.githubusercontent.com/TheSpeedX/PROXY-List/master/socks5.txt"
proxy "socks5" "https://api.proxyscrape.com/v2/?request=getproxies&protocol=socks5&timeout=10000&country=all&simplified=true"

cd ../
echo "\e[1;32mDone!\e[0m"
