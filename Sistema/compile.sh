#!/bin/bash

tput setaf 7 ; tput setab 4 ; tput bold ; printf '%50s%s%-20s\n' "BadVPN, created By THE_ORION_SCRIPT_PRO" ; tput sgr0
if [ -f "/usr/local/bin/badvpn-udpgw" ]
then
	tput setaf 3 ; tput bold ; echo ""
	echo ""
	echo "BadVPN a déjà été installé avec succès."
	echo "Pour exécuter, créez un écran de session"
	echo "Et exécutez la commande:"
	echo ""
	echo "badudp"
	echo ""
	echo "Et laissez l'écran de session fonctionner en arrière-plan."
	echo "" ; tput sgr0
	exit
else
tput setaf 2 ; tput bold ; echo ""
echo -e "\033[1;36mIl s'agit d'un script qui compile et installe automatiquement le programme BadVPN sur les serveurs Debian et Ubuntu pour activer la redirection UDP sur le port 7300, utilisé par des programmes comme l'injecteur HTTP d'Evozi. Permettant ainsi l'utilisation du protocole UDP pour les jeux en ligne, les appels VoIP et d'autres choses intéressantes.\033[0m"
echo "" ; tput sgr0
read -p "Voulez-vous continuer ? [s/n]: " -e -i n resposta
if [[ "$resposta" = 's' ]]; then
	echo ""
	echo -e "\033[1;31mL'installation peut prendre un certain temps... Patienter!\033[0m"
	sleep 3
	apt-get update -y
	apt-get install screen wget gcc build-essential g++ make -y
	wget http://www.cmake.org/files/v2.8/cmake-2.8.12.tar.gz
	tar xvzf cmake*.tar.gz
	cd cmake*
	./bootstrap --prefix=/usr
	make 
	make install
	cd ..
	rm -r cmake*
	mkdir badvpn-build
	cd badvpn-build
	wget https://github.com/ambrop72/badvpn/archive/refs/tags/1.999.130.tar.gz
	tar xf 1.999.130.tar.gz
	cd bad*
	cmake -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1
	make install
	cd ..
	rm -r bad*
	cd ..
	rm -r badvpn-build
    chmod +x badvpn.sh
    ./badvpn.sh
	echo "#!/bin/bash
	badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 10000 --max-connections-for-client 8" > /bin/badudp
	chmod +x /bin/badudp
	clear
	tput setaf 3 ; tput bold ; echo ""
	echo ""
	echo -e "\033[1;36mBadVPN installé avec succès. Pour l'utiliser, créez une session décran et exécutez la commande badudp et laissez la session d'écran s'exécuter en arrière-plan.\033[0m"
	echo "" ; tput sgr0
	exit
else 
	echo ""
	exit
fi
fi
