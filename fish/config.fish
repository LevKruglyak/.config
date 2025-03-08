set fish_greeting ""

pyenv init - | source

# Theme settings
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# Better ls commands
if type -q eza
  alias ls "eza -g --icons"
  alias lt "eza -g --icons --tree"
  alias la "eza -a -g --icons"
  alias lta "eza -a -g --icons --tree"
  alias ll "eza -l -g --icons"
  alias llt "eza -l -g --icons --tree"
  alias lla "ll -a"
end

alias journal "nvim -u ~/.config/journal/init.lua"
