zoxide init fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

set -g fish_key_bindings fish_hybrid_key_bindings

function fish_prompt
    # Prompt status only if it's not 0 (keep this first)
    set -l last_status $status
    set -l stat
    if test $last_status -ne 0
        set stat (set_color --dim red)" [$last_status]"(set_color normal)
    end

    string join '' -- \
        (set_color --bold) \
        (set_color cyan) (prompt_pwd --full-length-dirs 2) \
        (set_color blue) (fish_vcs_prompt) \
        $stat \
        (set_color normal) ' '
end

fish_config theme choose 'None'
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
