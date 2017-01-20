#!/usr/bin/env bash
# 

# color macros

# reset colors
COL_RESET="\033[0m"

# regular colors
RED="\033[31;1m"
BLUE="\033[34;1m"

need_cmd () {
    if ! hash "$1" &>/dev/null; then
        echo -e "${RED}need '$1' (command not found)${COL_RESET}"
        exit 1
    fi
}

fetch_repo () {
    if [[ -d "$HOME/.oob-vim" ]]; then
        git --git-dir "$HOME/.oob-vim/.git" pull
        echo -e "${BLUE}Successfully update oob-vim${COL_RESET}"
    else
        git clone https://github.com/zer4tul/oob-vim.git "$HOME/.oob-vim"
        echo -e "${BLUE}Successfully clone oob-vim${COL_RESET}"
    fi
}

install_vim () {
    if [[ -f "$HOME/.vimrc" ]]; then
        mv "$HOME/.vimrc" "$HOME/.vimrc_back"
        echo -e "${BLUE}BackUp $HOME/.vimrc${COL_RESET}"
    fi

    if [[ -d "$HOME/.vim" ]]; then
        if [[ $(readlink "$HOME"/.vim) =~ \.oob-vim$ ]]; then
            echo -e "${BLUE}Installed oob-vim for vim${COL_RESET}"
        else
            mv "$HOME/.vim" "$HOME/.vim_back"
            echo -e "${BLUE}BackUp $HOME/.vim${COL_RESET}"
            ln -s "$HOME/.oob-vim" "$HOME/.vim"
            echo -e "${BLUE}Installed oob-vim for vim${COL_RESET}"
        fi
    else
        ln -s "$HOME/.oob-vim" "$HOME/.vim"
        echo -e "${BLUE}Installed oob-vim for vim${COL_RESET}"
    fi
    vim +PlugInstall +qa
}

install_neovim () {
    if [[ -d "$HOME/.config/nvim" ]]; then
        if [[ "$(readlink $HOME/.config/nvim)" =~ \.oob-vim$ ]]; then
            echo -e "${BLUE}Installed oob-vim for neovim${COL_RESET}"
        else
            mv "$HOME/.config/nvim" "$HOME/.config/nvim_back"
            echo -e "${BLUE}BackUp $HOME/.config/nvim${COL_RESET}"
            ln -s "$HOME/.oob-vim" "$HOME/.config/nvim"
            echo -e "${BLUE}Installed oob-vim for neovim${COL_RESET}"
        fi
    else
        ln -s "$HOME/.oob-vim" "$HOME/.config/nvim"
        echo -e "${BLUE}Installed oob-vim for neovim${COL_RESET}"
    fi
    nvim +PlugInstall +qa
}

uninstall_vim () {
    if [[ -d "$HOME/.vim" ]]; then
        if [[ "$(readlink $HOME/.vim)" =~ \.oob-vim$ ]]; then
            rm "$HOME/.vim"
            echo -e "${BLUE}Uninstall oob-vim for vim${COL_RESET}"
            if [[ -d "$HOME/.vim_back" ]]; then
                mv "$HOME/.vim_back" "$HOME/.vim"
                echo -e "${BLUE}Recover $HOME/.vim${COL_RESET}"
            fi
        fi
    fi
    if [[ -f "$HOME/.vimrc_back" ]]; then
        mv "$HOME/.vimrc_back" "$HOME/.vimrc"
        echo -e "${BLUE}Recover $HOME/.vimrc${COL_RESET}"
    fi
}

uninstall_neovim () {
    if [[ -d "$HOME/.config/nvim" ]]; then
        if [[ "$(readlink $HOME/.config/nvim)" =~ \.oob-vim$ ]]; then
            rm "$HOME/.config/nvim"
            echo -e "${BLUE}Uninstall oob-vim for neovim${COL_RESET}"
            if [[ -d "$HOME/.config/nvim_back" ]]; then
                mv "$HOME/.config/nvim_back" "$HOME/.config/nvim"
                echo -e "${BLUE}Recover $HOME/.config/nvim${COL_RESET}"
            fi
        fi
    fi
}

usage () {
    echo "$0"
    echo "    Install oob-vim for vim and neovim"
    echo "        install.sh"
    echo "    Install oob-vim for vim only or neovim only"
    echo "        install.sh install vim"
    echo "        or"
    echo "        install.sh install neovim"
    echo "    Uninstall oob-vim"
    echo "        install.sh uninstall"
}


if [ $# -gt 0 ]
then
    case $1 in
        uninstall)
            uninstall_vim
            uninstall_neovim
            exit 0
            ;;
        install)
            need_cmd 'git'
            fetch_repo
            if [ $# -eq 2 ]
            then
                case $2 in
                    neovim)
                        install_neovim
                        exit 0
                        ;;
                    vim)
                        install_vim
                        exit 0
                esac
            fi
            install_vim
            install_neovim
            exit 0
            ;;
        -h)
            usage
            exit 0
    esac
fi
# if no argv, installer will install oob-vim
need_cmd 'git'
fetch_repo
install_vim
install_neovim
