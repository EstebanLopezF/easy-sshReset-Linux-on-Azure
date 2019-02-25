#!/bin/bash
#Reinstall Openssh -> SSHD
#temp Stop internal firewall.
#centos - Yes
#fedora - Yes
#redhat - NO
#SuSE   - NO        We need this
#Ubuntu - Yes
#Debian - Yes


python-is-installed=`echo $?`                       
distro=0

tar -cvf /etc/ssh.$(date '+%Y-%m-%d_%H:%M:%S').bak /etc/ssh                        

if [ "${python_status}" -eq 0 ]; 
    then distro=`python -c 'import platform ; print platform.dist()[0]'`;
else
    if [ -f /etc/fedora-release ] ; 
        then distro=fedora ;
    
        elif [ -f /etc/redhat-release ] ;                                            
            then distro=centos ;
            else distro=ubuntu ;               
    fi
fi

#REINSTALL OPENSSH

if [ "${distro}" = "ubuntu" || "${distro}" = "debian" ];                   
    then apt-get remove -y openssh && apt-get install -y openssh;
	apt-get install waagent;
    apt-get install -y iptables-services ;
    elif [ "${distro}" = "centos" || "${distro}" = "redhat" ];              
        then yum remove -y openssh && yum install -y openssh;
        yum install WALinuxAgent;
		yum install -y iptables-services;
        elif [ "${distro}" = "fedora" ];                                   
            then dnf remove -y openssh && dnf install -y openssh;
            dnf install -y iptables-services ;
fi

#Temp STOP FIREWALL

if [ "${distro}" = "ubuntu" || "${distro}" = "debian" ];                 
    then
	ufw disable;
	service iptables stop;
	systemctl stop iptables;
    elif [ "${distro}" = "centos" || "${distro}" = "redhat" || "${distro}" = "fedora" ];             
        then 
		service iptables stop;
		systemctl stop iptables;                             
		systemctl stop firewalld;
		yum install -y iptables-services;		
fi

exit 0;
