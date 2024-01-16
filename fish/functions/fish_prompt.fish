# Helper functions

function git_branch -d 'Return the current branch name'
    if set -q -x VIM
    else
        set -l branch (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
        if not test $branch > /dev/null
            set -l position (command git describe --contains --all HEAD 2> /dev/null)
            if not test $position > /dev/null
                set -l commit (command git rev-parse HEAD 2> /dev/null | sed 's|\(^.......\).*|\1|')
                set_color -o "yellow"
                if test $commit
                echo "($commit)"
            set_color normal
            echo " "
            end
            else
                set_color -o "purple"
                echo "($position)"
            set_color normal
            echo " "
            end
        else
            # set_color -b "cyan"
            set_color -o "cyan"
            echo "($branch)"
        set_color normal
            echo " "
        end
    end
end

set -g CMD_DURATION 0

function cmd_duration 
    set_color normal
    set -l seconds ''
    set -l minutes ''
    set -l hours ''
    set -l days ''
    set -l cmd_duration (expr $CMD_DURATION / 1000)
    if [ $cmd_duration -gt 0 ]
        set seconds (expr $cmd_duration \% 68400 \% 3600 \% 60)'s'
        if [ $cmd_duration -ge 60 ]
            set minutes (expr $cmd_duration \% 68400 \% 3600 / 60)'m'
            if [ $cmd_duration -ge 3600 ]
                set hours (expr $cmd_duration \% 68400 / 3600)'h'
                if [ $cmd_duration -ge 68400 ]
                    set days (expr $cmd_duration / 68400)'d'
                end
            end
        end
        if [ $last_status -ne 0 ]
            set_color -o "red"
            echo -n ' '$days$hours$minutes$seconds''
        else
            set_color -o "green"
            echo -n ' '$days$hours$minutes$seconds''
        end
    end
end

function redacted_pwd 
  echo -n ' '(prompt_pwd --full-length-dirs=4 --dir-length=1)''
end

# Prompt functions

function fish_prompt
  set -g last_status $status

  set_color -o "white"
  echo -n -s (whoami) ' '
  echo -n -s (git_branch)
end

function fish_right_prompt
    echo -n -s (cmd_duration) (redacted_pwd)
    set_color normal
end
