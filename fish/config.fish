starship init fish | source

abbr -a gss git status -sb
abbr -a ga git add .
abbr -a gc git commit
abbr -a gca git commit -a --amend --no-edit

alias rmf="rm -rf"

alias ls="eza"

if status is-interactive
    # Commands to run in interactive sessions can go here
end
