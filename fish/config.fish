fish_add_path ~/.local/bin

zoxide init fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

set -g fish_key_bindings fish_hybrid_key_bindings

fish_config theme choose 'ayu Dark'
set fish_color_valid_path --italics

alias l='ls -lh'
alias ll='ls -alh'
alias gl='git pull'
alias gp='git push'
alias gc='git commit --verbose'
alias ga='git add'
alias glg='git log --graph'
alias gs='git status'
alias gd='git diff'

set EDITOR vim
set VISUAL vim

source "$HOME/.cargo/env.fish"

direnv hook fish | source

set tide_left_prompt_items pwd newline character
set tide_right_prompt_items status cmd_duration context jobs direnv node python rustc java php pulumi ruby go gcloud kubectl distrobox toolbox terraform aws nix_shell crystal elixir zig jj git

function jjd
    jj edit "description($argv[1])"
end
