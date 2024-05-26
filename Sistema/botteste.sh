#!/bin/bash
[[ $(screen -list| grep -c 'bot_teste') == '0' ]] && {
    clear
    echo -e "\E[44;1;37m     TEST D'ACTIVATION DU BOT SSH     \E[0m"
    echo ""
    echo -ne "\n\033[1;32mRAPPORT OU JETON\033[1;37m: "
    read token
    clear
    echo ""
    echo -e "\033[1;32mDÉMARRAGE DES TESTS DE BOT \033[0m\n"
    cd $HOME/BOT
    rm -rf $HOME/BOT/botssh
    wget https://raw.githubusercontent.com/Alphathennec/SERVEUR/main/Sistema/botssh >/dev/null 2>&1
    chmod 777 botssh
    echo ""
    sleep 1
    screen -dmS bot_teste ./botssh $token > /dev/null 2>&1
    clear
    echo "BOT ACTIVÉ"
    menu
} || {
    screen -r -S "bot_teste" -X quit
    clear
    echo "BOT DESACTIVÉ"
    menu
}
