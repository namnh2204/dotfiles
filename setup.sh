set -x
install_yay_aur_helper() {
    if hash yay 2>/dev/null; then
        echo "yay is installed"
    else
        echo "Install Yay AUR Helper..."
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	cd ../
	rm -rf yay
    fi
}

setup_dotfiles() {
    dotfilePath=$(pwd)
    ln -sfn $dotfilePath/.config/{alacritty,dunst,nvim,bspwm,picom,polybar,rofi,sxhkd} $HOME/.config
    ln -sfn $dotfilePath/.tmux.conf $HOME/.tmux.conf
    ln -sfn $dotfilePath/.fzf.zsh $HOME/.fzf.zsh
    ln -sfn $dotfilePath/.zshrc $HOME/.zshrc
    ln -sfn $dotfilePath/.bashrc $HOME/.bashrc
    ln -sfn $dotfilePath/.xprofile $HOME/.xprofile
    ln -sfn $dotfilePath/.xbindkeysrc $HOME/.xbindkeysrc
}

setup_screen() {
    ln -sfn $dotfilePath/wall/neon.png /usr/share/pixmaps/neon.png
    ln -sfn $dotfilePath/{lightdm} /etc
}

install_sdkman() {
    if hash sdk 2>/dev/null; then
       echo "sdkman is installed"
    else
       curl -s "https://get.sdkman.io" | bash
    fi
}

install_tmux_plugin() {
    if [ ! -d ~/.tmux/plugins/tpm ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	tmux source ~/.tmux.conf
    fi
}

install_bluetooth_driver() {
    git clone git@github.com:lwfinger/rtw89-BT.git
    cd rtw89-BT
    make
    sudo make install
}

install_wifi_driver() {
    git clone https://aur.archlinux.org/rtw89-dkms-git.git
    cd rtw89-dkms-git
    makepkg -sri
    cd ../
    rm -r rtw89-dkms-git

    git clone https://github.com/lwfinger/rtw89.git
    cd rtw89
    make
    sudo make install
    cd ../
    rm -r rtw89
    sudo modprobe -v rtw_8852be          #This loads the module
}

fix_wifi_card_thinkbook() {
    ln -sfn $dotfilePath/thinkbook/wifi-fix/50-rtw89.conf /etc/modprobe.d/50-rtw89.conf
}

install_yay_aur_helper
setup_dotfiles
install_sdkman
install_tmux_plugin
install_bluetooth_driver
install_wifi_driver
