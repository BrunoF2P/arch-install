#!/bin/bash

# Atualizar o relógio do sistema
sudo timedatectl set-ntp true
sudo hwclock --systohc

# Atualizar a lista de espelhos do Pacman para o Brasil
sudo reflector -c Brazil -a 6 --sort rate --save /etc/pacman.d/mirrorlist

# Configurar o firewall
sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload

# Instalar yay (AUR helper) em vez do pikaur
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..

# Instalar KDE Plasma básico e alguns aplicativos essenciais
sudo pacman -S --noconfirm xorg sddm plasma konsole kde-applications-firewall kde-applications-systemsettings

# Instalar e configurar o tema de ícones
sudo pacman -S --noconfirm papirus-icon-theme

# Instalar aplicativos adicionais se necessário
sudo pacman -S --noconfirm firefox simplescreenrecorder obs-studio vlc kdenlive materia-kde

# Habilitar e iniciar o SDDM
sudo systemctl enable sddm

# Mensagem e reinicialização
/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
sleep 5
reboot
