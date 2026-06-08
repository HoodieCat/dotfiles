##==== fzf config
if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden '
fi
# including hidden files
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
export FZF_ALT_C_COMMAND="fd -td --follow --hidden"
_TXT_FZF_PREVIEW_CMD='bat --color=always --style=plain,numbers --line-range=:500 {}'
export FZF_CTRL_T_OPTS="--preview '$_TXT_FZF_PREVIEW_CMD'"
export FZF_ALT_C_OPTS=" --preview 'tree -C {}'"
_fzf_file_no_hidden_files() {
  local cmd result
  cmd="${FZF_DEFAULT_COMMAND/--hidden /}"
  result=$(eval "${cmd:-find . -type f}" | fzf --preview "$_FZF_PREIVEW_CMD") \
    && LBUFFER+="$result"
  zle reset-prompt
}
zle -N _fzf_file_no_hidden_files
source <(fzf --zsh)
