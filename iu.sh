#!/bin/bash
# author: https://t.me/iu536
clear
echo "欢迎使用iu的vless+gRPC+nginx+tls一键脚本!"
echo "author: https://t.me/iu536"
echo
sleep 1
echo

check=0
while [ $check -ne 4 ]
do 
   echo -e "[1] 开始安装\n"
   echo -e "[2] 更换端口\n"
   echo -e "[3] 查看节点\n"
   echo -e "[4] 退出脚本\n"
   read -p "请选择[1-4]:" check
   
   if [ $check -eq 1 ]
	   then 
	        bash /usr/iu/install.sh
			
     elif [ $check -eq 2 ]
	   then 
	        if `test -e /etc/nginx/conf.d/grpc_proxy.conf`
		  then 
	                     bash /usr/iu/change_port.sh
		     else 
			     echo "你还没安装节点！"
		             sleep 1
	        fi
			 
     elif [ $check -eq 3 ]
	   then 
	      if `test -e /usr/iu/node`
	         then
	             cat /usr/iu/node
	      else  
		     echo "你还没安装节点！"
		     sleep 1
	      fi
	
fi
	 
done 
