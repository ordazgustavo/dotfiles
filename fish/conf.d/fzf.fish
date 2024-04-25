set -gx FZF_DEFAULT_COMMAND "fd --hidden --strip-cwd-prefix --exclude .git"

set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND "--type=f"
set -gx FZF_ALT_C_COMMAND $FZF_DEFAULT_COMMAND "--type=d"

set -gx FZF_CTRL_T_OPTS "--preview 'bat -n --color=always --line-range :500 {}'"
set -gx FZF_ALT_C_OPTS "--preview 'eza --tree --color=always {} | head -200'"

set -gx FZF_DEFAULT_OPTS $FZF_DEFAULT_OPTS'
  --color=fg:-1,fg+:#d3c6aa,bg:-1,bg+:#4c3743
  --color=hl:#7fbbb3,hl+:#7fbbb3,info:#a7c080,marker:#a7c080
  --color=prompt:#a7c080,spinner:#7fbbb3,pointer:#a7c080,header:#87afaf
  --color=gutter:#1e2326,border:#859289,label:#d3c6aa,query:#d3c6aa
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> "
  --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'

function _fzf_compgen_path
    fd --hidden --exclude .git . "$1"
end

function _fzf_compgen_dir
    fd --type=d --hidden --exclude .git . "$1"
end

fzf --fish | source
