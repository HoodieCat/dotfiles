# eza for ls alternate
# default list with icons
if command -v eza >/dev/null 2>&1; then
alias ls='eza --icons'
alias tree='eza --tree --icons'
# detailed list
alias ll='eza -lah --icons --git'
fi

alias vi='nvim' 
alias cat='bat'
alias grep='grep --color=auto'
alias df='df -h'
alias .apply='chezmoi apply'
alias .reload='source $ZDOTDIR/.zshrc'
alias lg='lazygit'
export MANPAGER='nvim +Man!'
