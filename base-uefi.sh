#!/bin/bash

# Configuração do fuso horário e locale
ln -sf /usr/share/zoneinfo/America/Bahia /etc/localtime
hwclock --systohc
locale-gen
echo "LANG=pt_BR.UTF-8" > /etc/locale.conf
echo "KEYMAP=br-abnt2" > /etc/vconsole.conf
echo "arch" > /etc/hostname
echo "127.0.0.1 localhost" > /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:password | chpasswd

# Instalação de pacotes essenciais e drivers AMD
pacman -Syu --noconfirm grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils cups hplip alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync reflector acpi acpi_call tlp virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font mesa xf86-video-amdgpu

# Instalação do GRUB
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB

# Configuração do GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Habilitação dos serviços necessários
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable tlp
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid

# Criação do usuário padrão e configuração do sudo
useradd -m bruno
echo bruno:password | chpasswd
usermod -aG libvirt bruno

echo "bruno ALL=(ALL) ALL" > /etc/sudoers.d/bruno

# Finalização
printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m\n"
