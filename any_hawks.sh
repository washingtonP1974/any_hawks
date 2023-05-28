#!/bin/bash
free -h
sudo swapoff -av ; sudo swapon -av
sudo du -h /var/cache/apt/archives
sudo sync; echo 1 > /proc/sys/vm/drop_caches
sysctl -w vm.drop_caches=1
sudo sync; echo 2 > /proc/sys/vm/drop_caches
sysctl -w vm.drop_caches=2
sync && sudo sysctl -w vm.drop_caches=1
sync && sudo sysctl -w vm.drop_caches=2
sudo rm -r /var/lib/dpkg/info
sudo rm -r /var/cache/apt/archives
sudo dpkg --configure -a
sudo apt-get install -f
sudo rm -rf /var/tmp/*
rm -rf .local/share/Trash/files/*
rm -rf .local/share/Trash/expunged/*
rm -rf .local/share/Trash/info/*
rm -r ~/.cache/thumbnails
sudo chown -R $USER:$USER ~/.local/share/
sudo swapoff -a; sudo swapon -a
sudo apt autoclean -y && sudo apt autoremove -y
sudo rm -rf /var/tmp/*
sudo apt update --fix-missing
sudo apt upgrade -y
sudo apt full-upgrade -y
sudo apt dist-upgrade -y
sudo /sbin/fstrim --all || true
journalctl --disk-usage
du -sh ~/.cache/thumbnails
rm -rf ~/.cache/thumbnails/*
sudo journalctl --vacuum-time=30d
echo rm -r ~/.cache/thumbnails
dconf write /org/gnome/nautilus/preferences/show-image-thumbnails '"always"'
sudo update-grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
