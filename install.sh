#!/bin/bash
put ()
{
    if [[ -f "${2}" ]]; then
        if [[ -x $(which colordiff 2>/dev/null) ]]; then
            colordiff "${2}" "${1}"
        elif [[ -x $(which diff 2>/dev/null) ]]; then
            diff "${2}" "${1}"
        fi
    fi

    if [[ -x $(which rsync 2>/dev/null) ]]; then
            rsync -pc "${1}" "${2}"
        else
            cp "${1}" "${2}"
    fi
}

# Whether mac or other linux
if [[ -f "/etc/os-release" ]];then
    MAC=0
    echo "linux"
else
    MAC=1
    echo "Mac"
fi

# normal .xx files
#echo "install all config files into your HOME."
DEST=${1:-${HOME}}
echo "[DEST=${DEST}]"

# .aliases, .vimrc ...
for cf in $(cat ./config.list); do
    put "config/$cf" "${DEST}/.$cf"
done

# install vim plugin 
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -c ":PluginInstall" -c ":q" -c ":q"

mkdir -p ${DEST}/Program/usr/bin
rsync -rpc bin/ ${DEST}/Program/usr/bin


# Install bash-it
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
# git clone --depth=1 https://github.com/hansonzhao007/bash-it.git ~/.bash_it
~/.bash_it/install.sh

echo "source ~/.aliases " >> ~/.bashrc
source ~/.bashrc

# install gef https://github.com/hugsy/gef
wget -q -O- https://github.com/hugsy/gef/raw/master/scripts/gef.sh | sh
