.PHONY: all
all: nvim emacs alacritty zsh tmux wm

.PHONY: nvim
nvim:
	@echo "configure nvim"
	ln -sf $(CURDIR)/.vimrc ~/.vimrc
	ln -sf $(CURDIR)/.vimrc ~/.ideavimrc
	mkdir -p ~/.config/nvim
	ln -sf $(CURDIR)/.vimrc ~/.config/nvim/init.vim
	ln -sf $(CURDIR)/.config/nvim/coc-settings.json ~/.config/nvim/coc-settings.json

.PHONY: emacs
emacs:
	@echo "configure emacs"
	ln -sf $(CURDIR)/.spacemacs ~/.spacemacs

.PHONY: alacritty
alacritty:
	@echo "configure alacritty"
	ln -sf $(CURDIR)/.alacritty.yml ~/.alacritty.yml

.PHONY: zsh
zsh:
	@echo "configure zsh"
	mkdir -p ~/.config
	ln -sf $(CURDIR)/.config/starship.toml ~/.config/starship.toml
	ln -sf $(CURDIR)/.zshrc ~/.zshrc

.PHONY: tmux
tmux:
	@echo "configure tmux"
	ln -sf $(CURDIR)/.tmux.conf ~/.tmux.conf

.PHONY: wm
wm:
	@echo "configure windows manager"
	mkdir -p ~/.config/i3
	ln -sf $(CURDIR)/.config/i3/config ~/.config/i3/config
	ln -sf $(CURDIR)/.config/i3/wallpaper.jpg ~/.config/i3/wallpaper.jpg
	mkdir -p ~/.config/polybar
	ln -sf $(CURDIR)/.config/polybar/config ~/.config/polybar/config
	ln -sf $(CURDIR)/.config/polybar/launch.sh ~/.config/polybar/launch.sh
	mkdir -p ~/.config/rofi
	ln -sf $(CURDIR)/.config/rofi/config.rasi ~/.config/rofi/config.rasi
