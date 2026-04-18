source ./passionp.zsh-theme
echo "=== Base ==="
echo "PROMPT=$PROMPT"
precmd
echo "RPROMPT=$RPROMPT"

echo "=== Fake Root & Read-only ==="
UID=0
# create read only dir to test
mkdir -p test_ro && chmod 555 test_ro && cd test_ro
precmd
zsh -c "source ../passionp.zsh-theme; echo PROMPT=\$PROMPT"
cd .. && rm -rf test_ro
UID=501

echo "=== Virtual Envs & Cloud ==="
export VIRTUAL_ENV="/tmp/some/test-python-env"
export AWS_PROFILE="production"
zsh -c "source ./passionp.zsh-theme; echo PROMPT=\$PROMPT"

