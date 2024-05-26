#!/bin/bash
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-20s\n' "TCP Tweaker 1.0" ; tput sgr0
if [[ `grep -c "^#PH56" /etc/sysctl.conf` -eq 1 ]]
then
	echo ""
	echo "Les paramètres réseau TCP Tweaker ont déjà été ajoutés au système!"
	echo ""
	read -p "Vous souhaitez supprimer les paramètres TCP Tweaker? [s/n]: " -e -i n resposta0
	if [[ "$resposta0" = 's' ]]; then
		grep -v "^#PH56
net.ipv4.tcp_window_scaling = 1
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 16384 16777216
net.ipv4.tcp_low_latency = 1
net.ipv4.tcp_slow_start_after_idle = 0" /etc/sysctl.conf > /tmp/syscl && mv /tmp/syscl /etc/sysctl.conf
sysctl -p /etc/sysctl.conf > /dev/null
		echo ""
		echo "Les paramètres réseau de TCP Tweaker ont été supprimés avec succès."
		echo ""
	exit
	else 
		echo ""
		exit
	fi
else
	echo ""
	echo "Il s'agit d'un scénario expérimental. Utilisez-le à vos risques et périls !"
	echo "Ce script modifiera certains paramètres réseau"
	echo "pour réduire la latence et améliorer la vitesse."
	echo ""
	read -p "Poursuivre l'installation ? [s/n]: " -e -i n resposta
	if [[ "$resposta" = 's' ]]; then
	echo ""
	echo "Modification des paramètres suivants:"
	echo " " >> /etc/sysctl.conf
	echo "#PH56" >> /etc/sysctl.conf
echo "net.ipv4.tcp_window_scaling = 1
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 16384 16777216
net.ipv4.tcp_low_latency = 1
net.ipv4.tcp_slow_start_after_idle = 0" >> /etc/sysctl.conf
echo ""
sysctl -p /etc/sysctl.conf
		echo ""
		echo "Les paramètres réseau de TCP Tweaker ont été ajoutés avec succès. "
		echo ""
	else
		echo ""
		echo "L'installation a été annulée par l'utilisateur!"
		echo ""
	fi
fi
exit