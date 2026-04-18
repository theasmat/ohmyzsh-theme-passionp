# Load native time module gracefully
zmodload zsh/datetime 2>/dev/null || true


# login_info
function login_info() {
    local color="%{$fg_no_bold[cyan]%}";
    local ip
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        # Linux
        ip="$(ifconfig | grep ^eth1 -A 1 | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | head -1)";
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        ip="$(ifconfig | grep ^en1 -A 4 | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | head -1)";
    fi
    if [[ -n "$ip" ]]; then
        local color_reset="%{$reset_color%}";
        echo "${color} %n@${ip}${color_reset} ";
    fi
}

function root_warning() {
    if [[ $UID -eq 0 ]]; then
        echo "%{$bg[red]%}%{$fg[white]%} ⚡ ROOT %{$reset_color%} "
    fi
}

function venv_info() {
    local color="%{$fg_no_bold[green]%}"
    local color_reset="%{$reset_color%}"
    if [[ -n "$VIRTUAL_ENV" ]]; then
        echo "${color} ${VIRTUAL_ENV:t}${color_reset} "
    elif [[ -n "$CONDA_DEFAULT_ENV" ]]; then
        echo "${color} ${CONDA_DEFAULT_ENV}${color_reset} "
    fi
    if [[ -n "$NVM_BIN" ]]; then
        echo "${color} ${NVM_BIN:h:t}${color_reset} "
    fi
}

function aws_profile() {
    local profile="${AWS_PROFILE:-$AWS_DEFAULT_PROFILE}"
    if [[ -n "$profile" ]]; then
        echo "%{$fg_no_bold[yellow]%} ${profile}%{$reset_color%} "
    fi
}

# directory
function directory() {
    local color="%{$fg_no_bold[cyan]%}";
    local directory="${PWD/#$HOME/~}";
    local lock=""
    if [[ ! -w . ]]; then
        lock=" %{$fg_bold[red]%}"
    fi
    local color_reset="%{$reset_color%}";
    echo "${color} ${directory}${lock}${color_reset} ";
}

# git
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_no_bold[cyan]%} ";
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} ";
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_no_bold[red]%}  ";
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_no_bold[green]%}  ";

function update_git_status() {
    GIT_STATUS=$(_omz_git_prompt_info);
}

function git_status() {
    echo "${GIT_STATUS}"
}


# command
function update_command_status() {
    local arrow="";
    local color_reset="%{$reset_color%}";
    
    local exit_code=$1
    if [[ $exit_code -eq 0 ]]; then
        arrow="%{$fg_bold[red]%}❯%{$fg_bold[yellow]%}❯%{$fg_bold[green]%}❯ ";
    else
        arrow="%{$fg_bold[red]%} ${exit_code} ❯❯❯ ";
    fi
    COMMAND_STATUS="${arrow}${color_reset}";
}
update_command_status 0;

function command_status() {
    echo "${COMMAND_STATUS}"
}


# command execute before
preexec() {
    COMMAND_TIME_BEGIN=$EPOCHREALTIME
}

# command execute after
# REF: http://zsh.sourceforge.net/Doc/Release/Functions.html
precmd() { # cspell:disable-line
    # last_cmd
    local last_cmd_return_code=$?;
    local last_cmd_result=true;
    if [ "$last_cmd_return_code" = "0" ];
    then
        last_cmd_result=true;
    else
        last_cmd_result=false;
    fi

    # update_git_status
    update_git_status;

    # update_command_status
    update_command_status $last_cmd_return_code;

    # calculate execution time for RPROMPT
    local jobs_count=${#jobstates}
    local rprompt_jobs=""
    if [[ $jobs_count -gt 0 ]]; then
        rprompt_jobs="[%{$fg_bold[blue]%} ${jobs_count}%{$reset_color%}]"
    fi

    RPROMPT="${rprompt_jobs}"
    if [[ -n "$COMMAND_TIME_BEGIN" ]] && [[ -n "$EPOCHREALTIME" ]]; then
        local elapsed
        (( elapsed = EPOCHREALTIME - COMMAND_TIME_BEGIN ))
        if (( elapsed > 10.0 )); then
            RPROMPT="${RPROMPT}[%{$fg_no_bold[yellow]%}󱎫 $(builtin printf "%.2fs" $elapsed)%{$reset_color%}]"
        elif (( elapsed > 0.01 )); then
            local ms
            (( ms = elapsed * 1000 ))
            RPROMPT="${RPROMPT}[%{$fg_no_bold[cyan]%}󱎫 $(builtin printf "%.0fms" $ms)%{$reset_color%}]"
        fi
    fi
    COMMAND_TIME_BEGIN=""
}


# set option
setopt PROMPT_SUBST; # cspell:disable-line





# prompt
PROMPT='$(root_warning)$(venv_info)$(aws_profile)$(directory)$(git_status)$(command_status)'
