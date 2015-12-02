# General
bindkey -v # vim keybindings

# Prompt
autoload -U colors && colors
export PROMPT="%{$fg_no_bold[blue]%}%d%{$reset_color%} at %{$fg[yellow]%}%M
%{$fg_no_bold[green]%}%n%{$reset_color%} %# "

# Autocomplete
autoload -U compinit
compinit
setopt COMPLETE_IN_WORD # allow tab completion in the middle of a word

# Aliases
alias ls="ls --color=auto"
alias ta="tmux attach"
