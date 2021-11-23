#!/bin/sh
printf 'Willkommen zum Einrichtungsprogramm für das MacBook\n'
printf 'iTerm2 sollte bereits installiert sein\n'
printf 'Ist dies passiert? (j/n)\n'
read -r info

case $info in
    "j")
        printf "Super, weiter gehts\n" || exit;;
    "n")
        printf "Dann bitte von hier installieren: https://iterm2.com/downloads.html\n" 
        exit;;
    *)
        printf "Falsche Eingabe!"
        exit;;
esac

printf "Möchtest du einen SSH Key generieren? (j/n)\n"
read -r ssh

case $ssh in 
    "j")
        printf "SSH Key wird erstellt..."
        ssh-keygen -t rsa -b 4096
        printf "dein SSH Key:\n"
        cat ~/.ssh/id_rsa.pub || exit;;
    "n")
        printf "OK, dann gehts weiter\n" || exit;;
    *)
        printf "Falsche Eingabe!"
        exit;;
esac

printf "Möchtest du die GitConfig mit Aliases kopieren? (Achtung! EMail prüfen!) (j/n)\n"
read -r git

case $git in 
    "j")
        cp .gitconfig ~
        printf "Gitconfig kopiert";;
    "n")
        printf "OK, dann gehts weiter\n" || exit;;
    *)
        printf "Falsche Eingabe!"
        exit;;
esac

printf "Installiere Homebrew...\n"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
printf "Integriere Homebrew in den PATH...\n"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

printf "Installiere einige wichtige Tools via Homebrew...\n"
brew install git ranger htop kubectl helm iproute2mac minikube python3 gabrie30/utils/ghorg vagrant virtualenv awscli bpytop k3d
pip3 install ansible
brew install cask
brew install clock-bar

printf "Installiere oh-my-zsh...\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

printf "Installiere PowerLevel10K und Plugins...\n"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

printf "Nun müssen noch folgende Einstellungen in der Datei ~/.zshrc gesetzt werden: \n"
printf "ZSH_THEME=\"powerlevel10k/powerlevel10k\"\n"
printf "In der Section plugins: zsh-autosuggestions und zsh-syntax-highlighting\n"
printf "Anschließend muss noch iTerm2 neu gestartet werden und fertig!"
#ToDo: modularisieren und mit mehr Dialog versehen