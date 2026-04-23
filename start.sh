#!/bin/bash

#install pip

PACKAGES=(
    feh firefox ncdu nvim zsh btop flameshot
    autotiling curl xorg-xrandr picom docker
    docker-compose dysk kitty python tree
    obsidian git unzip net-tools ripgrep
)

get_distro() {
    source /etc/os-release
    echo "$ID"
}


font() {
	curl -L -o JetBrainsMono.zip https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip?_gl=1*emzzv4*_gcl_au*MTI5MTA2OTAxNy4xNzc2NzkyNjcx*FPAU*MTI5MTA2OTAxNy4xNzc2NzkyNjcx*_ga*MTYwOTg3MjYxNC4xNzc2NzkyNjcx*_ga_9J976DJZ68*czE3NzY3OTUyNjkkbzIkZzEkdDE3NzY3OTUzNDUkajUzJGwwJGgw
	unzip JetBrainsMono.zip -d temp
	cd temp
	sudo mkdir -p "/usr/share/fonts/JetBrains Mono"
	sudo cp fonts/ttf/*.ttf "/usr/share/fonts/JetBrains Mono"
	cd .. && rm -rf temp JetBrainsMono.zip
	fc-cache -fv
}

arch() {
	sudo pacman -Syu
	#(sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si)
	yay -Syu "${PACKAGES[@]}"
}

apt () {
	sudo apt update && sudo apt upgrade
	sudo apt install build-essential
	sudo apt install  "${PACKAGES[@]}"
}

essentialpackages() {

	distro=$(get_distro)

	case "$distro" in
		arch)	arch ;;
		ubuntu)	apt ;;
		debian)	apt ;;
		#apk)	echo "Ubuntu" ;;
		*)	echo "Unknown: $distro" ;;
	esac
}

ohmyzsh() {
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

gotocases() {
	case $1 in
		*0*)
			echo "Warning, this is only advisable when you just installed a fresh OS"
			essentialpackages && font ;;			
		*1*)
			essentialpackages ;;
		*2*) 
			font ;;
		*3*)	ohmyzsh ;;
		*)
			echo "Configuration not available yet." ;;
	esac
	
}

prompt() {
	while true; do
		echo "Welcome to the installation script, what do you want to install?"
		echo "0 - Everything."
		echo "1 - Essential packages."
		echo "2 - JetBrains Mono Font."
		echo "3 - Oh-My-Zsh."
		read -p "Options to include (eg: '1 2 3', '1-3'): " options
		if [[ "$options" =~ ^[0-9\ -]+$ ]]; then
			gotocases $options
			break
		else
			clear
		fi
	done
}

prompt

