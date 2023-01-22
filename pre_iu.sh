#!/usr/bin/env bash
# author: https://t.me/iu536

r00t=`echo $USER`
if [ $r00t != "root" ]
  then 
      clear
      echo "You are not root!"
	  echo
	  echo "请在root用户下执行该脚本!"
	  exit
fi

if test -e /usr/iu/iu.sh
 then 
      iu
 else 
      mkdir -p /usr/iu
	  
	  curl https://raw.githubusercontent.com/LSitao/vless_gRPC_nginx_tls/main/iu.sh > /usr/iu/iu.sh
	  
	  cp /usr/iu/iu.sh /usr/bin/iu
	  
	  curl https://raw.githubusercontent.com/LSitao/vless_gRPC_nginx_tls/main/install.sh > /usr/iu/install.sh
	  
	  chmod 700 /usr/bin/iu
	  /usr/bin/iu
	  
fi
	  
	  
	  
