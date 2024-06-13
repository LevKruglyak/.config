# Helper functions

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

# Prompt functions

function fish_prompt
  set -g last_status $status

  set_color -o -i "brwhite"
  echo -n -s '['(whoami)'] '
  set_color normal

  # Git branch
  set -l branch (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
  if not test -z "$branch"
    set_color -o "brcyan"

    # set -l changes (command git status --porcelain)
    # if not test -z "$changes"
    #   echo -n -s "($branch *) "
    # else
      echo -n -s "($branch) "
    # end

    set_color normal
  end
end

function fish_right_prompt
    echo -n -s (cmd_duration) 
    set -g CMD_DURATION 0

    set_color -i "brwhite"
    echo -n -s ' '(prompt_pwd --full-length-dirs=4 --dir-length=1)''
    set_color normal
end
