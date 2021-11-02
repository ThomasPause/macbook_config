# Anleitung zum Einrichten meiner ZSH
## Folfgende Schritte müssen ausgeführt werden:

* iTerm2 installieren 
siehe [hier](https://iterm2.com/downloads.html)

* Homebrew installieren
`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
in den PATH integrieren
`echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/t.pause/.zprofile`
`eval "$(/opt/homebrew/bin/brew shellenv)"`

* wichtige Tools installieren
`brew install git ranger htop kubectl helm `

* oh-my-zsh installieren
Oh My Zsh is installed by running one of the following commands in your terminal. You can install this via the command-line with either `curl`, `wget` or another similar tool.

| Method    | Command                                                                                           |
|:----------|:--------------------------------------------------------------------------------------------------|
| **curl**  | `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"` |
| **wget**  | `sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`   |
| **fetch** | `sh -c "$(fetch -o - https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"` |

#### Manual inspection

It's a good idea to inspect the install script from projects you don't yet know. You can do
that by downloading the install script first, looking through it so everything looks normal,
then running it:

```sh
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh
```

* PowerLevel 10k installieren
1. `git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k`
2. Set `ZSH_THEME="powerlevel10k/powerlevel10k"` in `~/.zshrc`.

* AutoSuggestions aktivieren
1. `git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`
2. Plugin zur Liste der Plugins hinzufügen (in `~/.zshrc`)
```plugins=( 
    # other plugins...
    zsh-autosuggestions
)
```

* Syntaxhighlighting aktivieren
1. `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`
2. Plugin zur Liste der Plugins hinzufügen (in `~/.zshrc`)
```plugins=( 
    # other plugins...
    zsh-syntax-highlighting
)
```

### Quellen:
* [https://github.com/ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
* [https://github.com/romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k)
* [https://github.com/zsh-users](https://github.com/zsh-users)
* []()
