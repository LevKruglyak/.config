if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Path directories
set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH ~/.cargo/bin $PATH

# Theme settings
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# Better ls commands
if type -q exa
  alias ls "exa -g --icons"
  alias lt "exa -g --icons --tree"
  alias la "exa -a -g --icons"
  alias lta "exa -a -g --icons --tree"
  alias ll "exa -l -g --icons"
  alias llt "exa -l -g --icons --tree"
  alias lla "ll -a"
end
