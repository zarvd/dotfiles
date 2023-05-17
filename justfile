cur_dir := `pwd`

default: nvim alacritty zsh fish wm cargo npm wezterm

nvim:
  ln -sf {{ cur_dir }}/.vimrc ~/.vimrc
  ln -sf {{ cur_dir }}/.ideavimrc ~/.ideavimrc
  mkdir -p ~/.config/nvim
  ln -sf {{ cur_dir }}/.vimrc ~/.config/nvim/init.vim
  ln -sf {{ cur_dir }}/.config/nvim/coc-settings.json ~/.config/nvim/coc-settings.json
  if [ ! -d ${HOME}/.intellimacs ]; then git clone git@github.com:MarcoIeni/intellimacs.git ~/.intellimacs; fi

alacritty:
  ln -sf {{ cur_dir }}/.alacritty.yml ~/.alacritty.yml

zsh:
  mkdir -p ~/.config
  ln -sf {{ cur_dir }}/.config/starship.toml ~/.config/starship.toml
  ln -sf {{ cur_dir }}/.zshrc ~/.zshrc

fish:
  mkdir -p ~/.config/fish
  ln -sf {{ cur_dir }}/.config/fish/config.fish ~/.config/fish/config.fish
  ln -sf {{ cur_dir }}/.config/fish/fish_plugins ~/.config/fish/fish_plugins

wm:
  mkdir -p ~/.config/i3
  ln -sf {{ cur_dir }}/.config/i3/config ~/.config/i3/config
  ln -sf {{ cur_dir }}/.config/i3/wallpaper.jpg ~/.config/i3/wallpaper.jpg
  mkdir -p ~/.config/polybar
  ln -sf {{ cur_dir }}/.config/polybar/config ~/.config/polybar/config
  ln -sf {{ cur_dir}}/.config/polybar/launch.sh ~/.config/polybar/launch.sh
  mkdir -p ~/.config/rofi
  ln -sf {{ cur_dir }}/.config/rofi/config.rasi ~/.config/rofi/config.rasi

cargo:
  mkdir -p ~/.cargo
  ln -sf {{ cur_dir }}/.cargo/config.toml ~/.cargo/config.toml

npm:
  ln -sf {{ cur_dir }}/.npmrc ~/.npmrc

wezterm:
  mkdir -p ~/.config/wezterm
  ln -sf {{ cur_dir }}/.config/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
