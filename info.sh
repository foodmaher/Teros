#!/data/data/com.termux/files/usr/bin/bash

# Dialog information and animation in Function down ;;

dialoginfo () {
clear
FBS=0
col=17
go="\n\n\n\n\n \n\n\n\n \n\n\n \n\n \n \a \n \n\n \n\n\n \n\n\n\n \n\n\n\n\n \n\n\n\n\n \n\n\n\n \n\n\n \n\n \n \a"
for anim in $go; do
((FBS++))

# GENERATE RANDOM NUMBERS ::

col="$(( ( RANDOM % 7 ) + 1 ))"
printf "\033[1;3"$col"m"
#printf "$FBS"
echo -e "${anim}###############################"
echo -e "##      MADE BY MAHER       ##"
echo -e "##      SCREEN DIALOG      ##"
echo -e "##       INFORMATION      ##"
echo -e "##       ANLINUX APP     ##"
echo -e "##########################"
sleep 0.1
if [ $FBS -lt 17 ]; then
clear
else
echo -e "\033[0m\n\a\a\a"
echo -e "\033[0;107m\033[1;30mHELP PAGE .. !!\033[0m\n"
echo -e "SCRIPT ${version}"
echo -e """
This script works only on Termux application .. !!
1. Stressing it running on the Termux directly
2. Stressing of having enough space on your device
3. Prefer to work your device on Android 6.0 or higher and your device contains a strong processor
4. Do not use the tool if there is a system you installed before
5. The other systems will be supported soon
6. This system does not provide the powers of the routing only if your device contains
7. This tool contains many mistakes because she is still in its initial stages
8. Do not have a core adjustment of your disruptivity smooth your smartphone
9. The tool will support the installation of later installed
10. The program will be designed to install graphic destinations on the system installed later
\nWARNING : This information screen has been translated by a compiler for a loyalty to do not happen English
"""
echo -e "\n\e[0;107m\e[1;30mEXIT INFORMATION SCREEN, PLEASE PRESS KEY ENTER .. !!\e[0m"; read key
fi
done
}

#errall=0
