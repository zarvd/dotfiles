.PHONY: vim
vim:
	ln -sf $(CURDIR)/.vimrc ~/.vimrc; ln -sf $(CURDIR)/.vimrc ~/.ideavimrc

.PHONY: nvim
nvim: vim
	mkdir -p ~/.config/nvim; \
		ln -sf $(CURDIR)/.vimrc ~/.config/nvim/init.vim; \
		ln -sf $(CURDIR)/.config/nvim/coc-settings.json ~/.config/nvim/coc-settings.json

.PHONY: emacs
emacs:
	ln -sf $(CURDIR)/.spacemacs ~/.spacemacs

.PHONY: alacritty
alacritty:
	ln -sf $(CURDIR)/.alacritty.yml ~/.alacritty.yml

.PHONY: zsh
zsh:
	ln -sf $(CURDIR)/.zshrc ~/.zshrc

.PHONY: tmux
tmux:
	ln -sf $(CURDIR)/.tmux.conf ~/.tmux.conf

.PHONY: relink
relink: nvim emacs alacritty zsh tmux
