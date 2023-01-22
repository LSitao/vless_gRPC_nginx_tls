#!/bin/bash

clear
read -p "你想要什么端口? [0-65535]:" temp
if [ $temp -ne 443 ]
 then port=$temp
 else port=443
fi

echo "OK 稍等一下"
sleep 2

if [ $port -eq 443 ]
 then
 cat << EOF > /etc/nginx/conf.d/grpc_proxy.conf
server {
    listen 80;
    server_name ${domain};
    #charset utf-8;   
    
    location / {
    rewrite (.*) https://${domain}\$1 permanent;
      }
}
server {
    listen 443 ssl http2;
    server_name ${domain};
	 location / {
          root /web;
	  index index.html;
    }
    location /grpc_proxy {
        grpc_read_timeout 2m;
        grpc_send_timeout 5m;
	grpc_pass 127.0.0.1:16969;
    }
    ssl_certificate /usr/server.crt;
    ssl_certificate_key /usr/server.key;
    ssl_stapling on;
    ssl_stapling_verify on;
    resolver 8.8.8.8 8.8.4.4 valid=300s;
    resolver_timeout 5s;
    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 5m;
    ssl_protocols TLSv1.3;
    ssl_ciphers "ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA:ECDHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES128-SHA256:DHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES256-GCM-SHA384:AES128-GCM-SHA256:AES256-SHA256:AES128-SHA256:AES256-SHA:AES128-SHA:DES-CBC3-SHA:HIGH:!aNULL:!eNULL:!EXPORT:!DES:!MD5:!PSK:!RC4";
    ssl_prefer_server_ciphers on;
} " 
EOF
else cat << EOF > /etc/nginx/conf.d/grpc_proxy.conf
server {
    listen $port ssl http2;
    server_name cera.2cd.cc;
    error_page 497 https://'$host':$port'$request_uri';
	
         location / {
          root /web;
          index index.html;
    }

    location /grpc_proxy {
        grpc_read_timeout 2m;
        grpc_send_timeout 5m;
        grpc_pass 127.0.0.1:16969;

    }

    ssl_certificate /usr/server.crt;
    ssl_certificate_key /usr/server.key;
    ssl_stapling on;
    ssl_stapling_verify on;
    resolver 8.8.8.8 8.8.4.4 valid=300s;
    resolver_timeout 5s;
    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 5m;
    ssl_protocols TLSv1.3;
    ssl_ciphers ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA:ECDHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES128-SHA256:DHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES256-GCM-SHA384:AES128-GCM-SHA256:AES256-SHA256:AES128-SHA256:AES256-SHA:AES128-SHA:DES-CBC3-SHA:HIGH:!aNULL:!eNULL:!EXPORT:!DES:!MD5:!PSK:!RC4;
    ssl_prefer_server_ciphers on;
}
EOF
service nginx restart

fi
clear
echo "已成功将端口更改为$port!"
echo
echo "记得在客户端修改节点端口哦"

