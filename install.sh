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

#   -------------------------------
#   1. ENVIRONMENT for Both
#   -------------------------------
    DEST=${1:-${HOME}}
    echo "[DEST=${DEST}]"

    # .aliases, .vimrc ...
    for cf in $(cat ./config.list); do
    put "config/$cf" "${DEST}/.$cf"
    done

    # install vim plugin
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim -c ":PluginInstall" -c ":q" -c ":q"

    # install gef https://github.com/hugsy/gef
    wget -q -O- https://github.com/hugsy/gef/raw/master/scripts/gef.sh | sh

    # generate ecdsa key
    ssh-keygen -t ecdsa -b 521 -N "" -f id_ecdsa

    # copy my public key to authorized_keys
    mkdir ~/.ssh
    cat key_pub.txt >> ~/.ssh/authorized_keys
    # allow local ssh
    cat id_ecdas.pub >> ~/.ssh/authorized_keys



#   -------------------------------
#   2. ENVIRONMENT for Linux
#   -------------------------------
    if [ $MAC -eq 0 ]; then
    # copy my scripts
    mkdir -p ${DEST}/program/usr/bin
    rsync -rpc bin/ ${DEST}/program/usr/bin

    # copy my lib
    mkdir -p ${DEST}/program/usr/lib

    # Install bash-it
    # git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
    git clone --depth=1 https://github.com/hansonzhao007/bash-it.git ~/.bash_it
    ~/.bash_it/install.sh

    fi


#   -------------------------------
#   3. Final Setup
#   -------------------------------
    echo "source ~/.aliases " >> ~/.bashrc
    echo "source ~/.installed_package" >> ~/.bashrc
    source ~/.bashrc




