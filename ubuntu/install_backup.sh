cd 
git clone https://github.com/longriyao/backup.git
rm -rf Documents/
mv backup/ Documents
ln -s ~/Documents/config/shell/zshrc ~/.zshrc   #设置zsh配置文件
ln -s ~/Documents/config/shell/comzsh ~/.comzsh
ln -s ~/Documents/config/vim/vimrc ~/.vimrc  #这是vimrc配置文件
chsh -s /usr/bin/zsh   #need input the password

echo "TerminalWindow .notebook {
            padding: 0;
            border-width: 0;
        }" | sudo tee --append /usr/share/themes/Ambiance/gtk-3.0/apps/gnome-terminal.css


