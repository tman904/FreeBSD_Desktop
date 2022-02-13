#!/bin/sh

#Author: Tyler K Monroe
#Date: 2/13/2022
#Purpose: Take a stock freebsd install and tweak it to how I use it as a desktop system.

#Get current user
echo "Please enter your nonroot username for normal system use."
read user

#These vars are in case freebsds commands change in the future just change these here instead of in the entire program.
prog_update="pkg update"
prog_install="pkg install"

#Easy user changable vars to customize the installation.
rcconf="/etc/rc.conf"
rpconf="/home/$user/.ratpoisonrc"
xinitrc="/home/$user/.xinitrc"

#This is the desktop you want to install eg mate/fluxbox/ratpoison/gnome3/kde etc.
desktop="ratpoison"
xserver="Xorg"
touchpad="xf86-input-synaptics"
browser="firefox"
office="libreoffice"
virtualization="virtualbox-ose"

#Install everything I use.
$prog_update

$prog_install $xserver $touchpad $browser $office $virtualization $desktop

#add current user to proper groups
pw usermod $user -G vboxusers,wheel

#Configure .xinitrc file
echo "synclient TapButton1=1" > $xinitrc
echo "/usr/local/bin/ratpoison" >> $xinitrc

#Configure .ratpoisonrc file
echo "bind c exec xterm -fg green -bg black -fn 9x15" > $rpconf
echo "bind x exec /home/$user/killxorg.sh" >> $rpconf

#Configure /etc/rc.conf file
echo "moused_enable=\"YES\"" >> $rcconf
echo "dbus_enable=\"YES\"" >> $rcconf
echo "vboxnet_enable=\"YES\"" >> $rcconf
