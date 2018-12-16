#!/data/data/com.termux/files/usr/bin/bash
version="Beta 0.5v"
#setterm -cursor off
clear
echo "Tools, version ${version} tool any inside while error code"
sleep 3

# input nameapt informatiob ;;
# input URL,namepackage information ;:
# default value information functinos ;;
# URL=""; namepackage=""; nameapt=""
# Default screen startup = Function (dialogstart) Enable ;;

# Source File Connection ;;
terp="/data/data/com.termux/files"
terps="/data/data/com.termux/files/home/Teros"
bash_url="${terp}/usr/bin/bash"
#bash_url="/bin/bash"
colors_file="${terp}/home/SCD.conf"
info_file="${terps}/info.sh"
debian_source_file="${terps}/debian_source.sh"
external_file="${terps}/external_start.sh"
conf="${terps}/error_tool.conf"
echo -e """
# Remove File use the (rm -rf ${conf}) command at any terminal linux Good Tool :) ....
# WARNING : The setup program will re-create the file every time error are detected or the program restarts
# Version ${version} interface in terminal ... 
\n\n..... List Error .....""" > ${conf}
echo -e "\nPleasse, check file ${conf} after the exit tool\n"

# Function exiting and error ;;

exitf () {
clear
echo "Exiting ... Poragram stopping now ..."
if [ $err -eq 0 ]; then
echo "Normal Exit ..."
else
echo -e "Error, Ops A line has occurred in a number ($err)\nPlease Check File ${conf}"
echo -e "Details of error : $des\nError number : $err\nFile name : $1" >> ${conf}
fi
echo "........ End ........" >> ${conf}
exit 1
}

# Functions check the required programs ;;

Funcheck () {
if ! [ -r "$bash_url" ] && [ -r "$terps" ]; then
echo "Exiting ... Error I did not find a file bash or have not selected a valid path in termux :("
err=1; des="Path no termux : ($0) Teros ($terps) or not user account default termux"; exitf
fi
if ! [ -r "$info_file" ] && [ -r "$debian_source_file" ] && [ -r "$colors_file" ] && [ -r "$external_file" ]; then
echo "Lack of files .. !!" && err=2; des="$(ls)\n$(pwd) \nLack of files .."; exitf
else re=1
fi
if ! [ -r $(which dialog) ] && [ -r $(which pv) ] && [ -r $(which wget) ] && [ -r $(which proot) ]; then
echo "Download important programs ..."
apt install dialog pv proot wget -y
else ((re++))
fi
if [ $re -eq 2 ];then
echo "Found File ..."
export DIALOGRC=${colors_file}
source ${info_file}
source ${debian_source_file}
source ${external_file}
fi
}

# Functions dialog screen wget ;;

dialogwget () {
Funcheck
if [ $URL != "" ] && [ $namepackage != "" ]; then
wget "$URL" 2>&1 | stdbusf -o0 awk '/[.] +[0-9][0-9]?[0-9]?%/ { print substr ($0,63,3) }' | \
dialog --backtitle "PAGE DOWNLOAD ...." --title "Download Packege" \
--gauge "Download Packege : $namepackage ...." 7 40
else
dialog --backtitle "PAGE ERROR DOWNLOAD ...." --msgbox "Error, Ops .. !, selected link or name package, please check error file (${terp}/home/error_tool.conf)" 8 40
echo "Error download info package $namepackage\nURL = ${namepackage} is not correct url please try url download side web browser and agen download in tool me .. thank :)" >> ${conf}
fi
clear
echo -e "\a\aExiting program now please wait for out program ..... "
sleep 3
}

# Functions dialog tar extraction install ;;

dialogtar () {
Funcheck
if [ -r $filetar ]; then
(pv -n $filetar | proot --link2symlink tar xf - -C target_directory ) 2>&1 | \
dialog --backtitle "PAGE TAR TOOL ...." --title "Extraction System Files $filetar ..." --gauge "Install Sustem, Please wait ..." 7 40
else
dialog --backtitle "PAGE ERROR"--pause "I did not find the file, please try agin ...." 8 30 5
clear
fi
}

# Function Start Screen Dialog Interface inside the terminal ;;

dialogstart () {
sleep 2
exec 3>&1
select_os=$(dialog \
--backtitle "PAGE SELECT OS INSTALL ..." \
--menu "Menu Select OS" 10 25 8 \
"1" "Debian OS" \
"2" "External Tools" \
"3" "Information" \
2>&1 1>&3)
if [ $? -eq 1 ]; then echo -e "\nYou did not take any action :(\n" >> ${conf}; echo "Exiting .."; sleep 2; clear; fi
exec 3>&-
case "$select_os" in
1) Fundebian ;;
2) check_and_start; dialogstart ;;
3) dialoginfo; dialogstart ;;
esac
}

# Start Function name
# {
Funcheck
#if [ "$Auto_start" == "yes" ]; then
dialogstart
#fi
# }
err=0; exitf
# errall=2
#setterm -cursor on
