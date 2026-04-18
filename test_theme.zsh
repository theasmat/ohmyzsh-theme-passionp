source ./passionp.zsh-theme
echo "Initial RPROMPT: $RPROMPT"
preexec
sleep 0.1
precmd
echo "After 100ms cmd RPROMPT: $RPROMPT"
preexec
sleep 1.2
precmd
echo "After 1.2s cmd RPROMPT: $RPROMPT"
