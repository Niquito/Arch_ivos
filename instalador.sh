#!/bin/sh

# Set -e sirve para prevenir que el script corra si aparece algún error
set -e

echo "=========================="
echo " 1 - Configurando mirrors "
echo "=========================="


echo "======================"
echo " Instalando reflector "
echo "======================"


# Instalar reflector para testear y asignar automáticamente los mirrors de descarga
sudo pacman -S --noconfirm --needed reflector


echo "==============================================="
echo " Buscando y sorteando los mejores 5 servidores "
echo "==============================================="


sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist


echo "========="
echo " ¡Hecho! "
echo "========="

# Actualizo el sistema con los nuevos mirrors

sudo pacman -Syu


echo "========================"
echo " ¡Mirrors actualizados! "
echo "========================"


echo "====================="
echo " 2 - Instalando XORG "
echo "====================="


echo "=============================="
echo " ¿Qué placa de drivers querés?"
echo "=============================="
echo "1) nvidia"
echo "2) ati"
echo "3) intel"
echo "4) virtualbox"

# Tomo el input del usuario

read variable

sudo pacman -S xorg-server xorg-apps xorg-xinit xorg-twm xterm --noconfirm --needed

if [ "$variable" = "1" ]; then

	sudo pacman -S xf86-video-nouveau --noconfirm --needed

elif [ "$variable" = "2" ]; then
	
	sudo pacman -S xf86-video-ati --noconfirm --needed
	 	
elif [ "$variable" = "3" ]; then

	sudo pacman -S xf86-video-intel --noconfirm --needed

elif [ "$variable" = "4" ]; then
	
	sleep 2

	sudo pacman -S virtualbox-guest-utils 

else

	echo "Salida de emergenciaaaa"
		  	
fi

echo "========================"
echo " 3 - Instalando i3 core "
echo "========================"

sudo pacman -S --noconfirm --needed i3lock i3status 

echo "=========================================="
echo " 4 - Instalando software básico (para mi) "
echo "=========================================="

sudo pacman -S --noconfirm --needed firefox
sudo pacman -S --noconfirm --needed screenfetch
sudo pacman -S --noconfirm --needed vlc
sudo pacman -S --noconfirm --needed wget
sudo pacman -S --noconfirm --needed git
sudo pacman -S --noconfirm --needed firefox

echo "======================"
echo " 5 - Instalando audio "
echo "======================"

sudo pacman -S pulseaudio pulseaudio-alsa pavucontrol  --noconfirm --needed
sudo pacman -S alsa-utils alsa-plugins alsa-lib alsa-firmware --noconfirm --needed
sudo pacman -S gst-plugins-good gst-plugins-bad gst-plugins-base gst-plugins-ugly  gstreamer  --noconfirm --needed

echo "===================="
echo " 6 - Instalando red "
echo "===================="

sudo pacman -S networkmanager --noconfirm --needed
sudo pacman -S network-manager-applet --noconfirm --needed
sudo systemctl enable NetworkManager.service
sudo systemctl start NetworkManager.service