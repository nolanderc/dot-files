zoxide init fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting


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

fish_config theme choose 'Base16 Eighties'
set fish_color_valid_path --italics

alias l='ls -a'
alias ll='ls -al'
alias gl='git pull'
alias gc='git commit --verbose'
alias ga='git add'
alias glg='git log --graph'
alias gs='git status'
alias gd='git diff'

