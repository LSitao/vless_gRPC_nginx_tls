#!/bin/bash

clear
echo "欢迎使用iu的vless+gRPC+nginx+tls一键脚本!"
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
	        bash /usr/iu/change_port.sh
			
	 elif [ $check -eq 3 ]
	   then 
	        cat /usr/iu/node
	 fi
	 
done 
