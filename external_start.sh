#!/data/data/com.termux/files/usr/bin/bash

# SETTING FILE DEFAUIT ;;

#export DIALOGRC=~/select_colors_dialog.conf
file_start="${terps}/beta.sh"
file_info="${terps}/info.sh"
clear

# JOBS SCRIPT DOWN ;;

wget_external () {

	return 1
}

tar_external () {
exec 3>&1
file=$(dialog --inputbox "URL File tar" 7 60 2>&1 1>&3)
if [ $? -eq 1 ]; then echo -e "\nNo URL link Download :(\n" >> ${conf}; echo "Exiting .."; sleep 2; clear; fi
exec 3>&-
if [ -r "$file" ]; then
echo "$(pwd)$file"
else
dialog 
--backtitle "PAGE ERROR ..." \
--msgbox "Error. file not found ..." 6 40
fi
}

dialogch () {
sleep 2
exec 3>&1
select_tool=$(dialog \
--backtitle "PAGE SELECT TOOLS ..." \
--menu "Menu Select TOOLS" 11 25 9 \
"1" "WEBGET TOOL" \
"2" "TAR TOOL" \
"3" "Advanced" \
"4" "Information" \
2>&1 1>&3)
if [ $? -eq 1 ]; then echo -e "\nYou did not take any action :(\n" >> ${conf}; echo "Exiting .."; sleep 2; clear; fi
exec 3>&-
case "$select_tool" in
	1) gwet_external; dialogch ;;
	2) tar_external; dialogch ;;
	3) echo "Will not be available yet"; sleep 2; dialogch ;;
	4) dialoginfo; dialogch ;;
esac
}

check_and_start () { 
if [ -r "${file_info}" ]; then
source ${file_info}
else
echo "I did not find the files"
err=4; des="ERROR, No files > error form external_start.sh1"
exitf
fi
dialog --backtitle "PAGE EXTERNLA ..." \
--yesno "This program allows you to use the tools attached to the ${file_start} file externally" 7 60
case "$?" in
	1)  #echo "Exiting program external_start.sh"
		echo "Nothing ..." >> ${conf} ;;
	0)	dialogch ;;
esac
 }
#errall=1
#check_and_start
