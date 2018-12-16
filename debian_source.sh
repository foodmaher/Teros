#!/data/data/com.termux/files/usr/bin/bash

# Functions install Debian OS ;;

Fundebian () {
pn="$(pwd)"
#cd "${terp}"
folder=debian-fs
tarball="debian-rootfs.tar.gz"
if [ -d "$folder" ]; then
first=1
echo "skipping downloading"
fi
if [ "$first" != 1 ]; then
if [ ! -f $tarball ]; then
case `dpkg --print-architecture` in
aarch64)
archurl="arm64" ;;
arm)
archurl="armhf" ;;
amd64)
archurl="amd64" ;;
x86_64)
archurl="amd64" ;;	
i*86)
archurl="i386" ;;
x86)
archurl="i386" ;;
*)
err=3; des="unknown architecture"; echo "$des"; exitf ;;
esac
URL="https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Rootfs/Debian/${archurl}/debian-rootfs-${archurl}.tar.gz" -O $tarball
namepackage="${tarball}"
dialogwget
fi
	cur=`pwd`
	mkdir -p "$folder"
	cd "$folder"
	filetar=${cur}/${tarball}||:
	dialogtar
	cd "$cur"
fi
mkdir -p debian-binds
bin=start-debian.sh
echo "writing launch script"
cat > $bin <<- EOM
#!/bin/bash
cd \$(dirname \$0)
## unset LD_PRELOAD in case termux-exec is installed
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -0"
command+=" -r $folder"
if [ -n "\$(ls -A debian-binds)" ]; then
    for f in debian-binds/* ;do
      . \$f
    done
fi
command+=" -b /dev"
command+=" -b /proc"
command+=" -b debian-fs/tmp:/dev/shm"
## uncomment the following line to have access to the home directory of termux
#command+=" -b /data/data/com.termux/files/home:/root"
## uncomment the following line to mount /sdcard directly to / 
#command+=" -b /sdcard"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=\$TERM"
command+=" LANG=C.UTF-8"
command+=" /bin/bash --login"
com="\$@"
if [ -z "\$1" ]; then
    exec \$command
else
    \$command -c "\$com"
fi
EOM

echo "fixing shebang of $bin"
termux-fix-shebang $bin
echo "making $bin executable"
chmod +x $bin
echo "removing image for some space"
dialog --backtitle "PAGE REMOVE ..." --msgbox "Remove ${tarball} ?" 8 30
if [ $? -eq 1 ];then
rm ${tarball}
fi
dialog --backtitle "PAGE END ..." --infobox "You can now launch Debian with the ./${bin} script, and run scrpit command (bash GUI.sh) install" 10 30
clear
./start-debian.sh
}

#errall=1
