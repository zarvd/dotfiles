.PHONY: vim
vim:
	ln -sf $(CURDIR)/.vimrc ~/.vimrc;
	ln -sf $(CURDIR)/.vimrc ~/.ideavimrc

.PHONY: nvim
nvim: vim
	mkdir -p ~/.config/nvim;
	ln -sf $(CURDIR)/.vimrc ~/.config/nvim/init.vim;
	ln -sf $(CURDIR)/.config/nvim/coc-settings.json ~/.config/nvim/coc-settings.json

.PHONY: emacs
emacs:
	ln -sf $(CURDIR)/.spacemacs ~/.spacemacs

.PHONY: alacritty
alacritty:
	ln -sf $(CURDIR)/.alacritty.yml ~/.alacritty.yml

.PHONY: zsh
zsh:
	mkdir -p ~/.config;
	ln -sf $(CURDIR)/.config/starship.toml ~/.config/starship.toml;
	ln -sf $(CURDIR)/.zshrc ~/.zshrc

.PHONY: tmux
tmux:
	ln -sf $(CURDIR)/.tmux.conf ~/.tmux.conf

.PHONY: polybar
polybar:
	ln -sf $(CURDIR)/.config/polybar/config ~/.config/polybar/config;
	ln -sf $(CURDIR)/.config/polybar/launch.sh ~/.config/polybar/launch.sh

.PHONY: i3
i3:
	ln -sf $(CURDIR)/.config/i3/config ~/.config/i3/config;
	ln -sf $(CURDIR)/.config/i3/wallpaper.jpg ~/.config/i3/wallpaper.jpg

.PHONY: rofi
rofi:
	ln -sf $(CURDIR)/.config/rofi/config.rasi ~/.config/rofi/config.rasi

.PHONY: relink
relink: nvim emacs alacritty zsh tmux polybar i3 rofi
