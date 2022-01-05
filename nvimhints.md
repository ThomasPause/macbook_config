von Karsten:
vcsh clone git://spambri.de/tmux.git
vcsh clone git://spambri.de/vim.git
vcsh clone git://spambri.de/zsh.git

vorher brew install vcsh nvim moreutils

mittels in zsh definiertem mcd Befehl noch folgende Repos installieren:

	mcd ~/.local/share/nvim/site/pack/ale/start
	git clone https://github.com/dense-analysis/ale.git


	mcd ~/.local/share/nvim/site/pack/ansible/start
	git clone https://github.com/pearofducks/ansible-vim.git


	mcd ~/.local/share/nvim/site/pack/fugitive/start
	git clone https://github.com/tpope/vim-fugitive.git

noch einige Anregungen unter git clone git://spambri.de/dotfiles.git

