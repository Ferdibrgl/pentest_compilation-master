archive() {
	
	curl -s 'http://web.archive.org/cdx/search?url='$1'%2F&matchType=prefix&collapse=urlkey&output=json&fl=original%2Cmimetype%2Ctimestamp%2Cendtimestamp%2Cgroupcount%2Cuniqcount&filter=!statuscode%3A%5B45%5D..&limit=100000&_=1532513891577' --compressed | grep -Po "(?<=\[\").*?(?=\")"

}

bing() {

	curl -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:63.0) Gecko/20100101 Firefox/63.0" "https://www.bing.com/search?q=domain%3a$1&first=1" -s |grep -Po "(?<=b_title\"><h2><a href=\").*?(?=\")"| egrep -v "microsoft|bing|pointdecontact" 

}

bing2() {

curl -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:63.0) Gecko/20100101 Firefox/63.0" "https://www.bing.com/search?q=domain%3a$1&first=1" -s |grep -Po "(?<=target=\"_blank\" href=\").*?(?=\")" | egrep -v "microsoft|bing|pointdecontact"

}


google() {

curl -i -s -k  -X  GET   -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:63.0) Gecko/20100101 Firefox/63.0" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" -H $'Connection: close'     "https://www.google.to/search?q=site:$1&num=60" -x socks5://127.0.0.1:1337 | grep -Po  "(?<=iUh30\">).*?(?=<)"

}

duckduckgo() {

token=$(curl -A "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101 Firefox/67.0" "https://api.duckduckgo.com/?q=site%3A$1" -s | grep -Po "(?<=vqd=).*?(?=&)" | tail -1); curl -A "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101 Firefox/67.0" "https://duckduckgo.com/d.js?q=site%3A$1&vqd=$token" -s | grep -Po "(?<=u\":\").*?(?=\")"

}


# Usage: archive <domain> or bing <domain> or google <domain> (this last one is suppossed to be launched with doxycannon to bypass google captcha)
