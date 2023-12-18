cur_dir := `pwd`

default: ideavim fish cargo npm wezterm bat

bat:
  mkdir -p ~/.config/bat
  ln -sf {{ cur_dir }}/.config/bat/config ~/.config/bat/config

ideavim:
  ln -sf {{ cur_dir }}/.ideavimrc ~/.ideavimrc
  if [ ! -d ${HOME}/.intellimacs ]; then git clone git@github.com:MarcoIeni/intellimacs.git ~/.intellimacs; fi

fish:
  mkdir -p ~/.config/fish
  ln -sf {{ cur_dir }}/.config/fish/config.fish ~/.config/fish/config.fish
  ln -sf {{ cur_dir }}/.config/fish/fish_plugins ~/.config/fish/fish_plugins

cargo:
  mkdir -p ~/.cargo
  ln -sf {{ cur_dir }}/.cargo/config.toml ~/.cargo/config.toml

npm:
  ln -sf {{ cur_dir }}/.npmrc ~/.npmrc

wezterm:
  mkdir -p ~/.config/wezterm
  ln -sf {{ cur_dir }}/.config/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua

install-fisher:
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
