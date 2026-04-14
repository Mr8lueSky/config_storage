
# Setting PATH for Python 3.10
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"
echo >> /Users/skhulup/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH

eval "$(/opt/homebrew/bin/brew shellenv)"

# For local apps
PATH="/Users/skhulup/.local/bin:${PATH}"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export GOPROXY="https://goproxy.s.o3.ru"
export GOSUMDB=off
export PATH="$PATH:/Users/skhulup/.dotnet/tools"

# My aliases
alias ssh_init="eval \"$(ssh-agent)\"; ssh-add ~/.ssh/gitlab"
alias nvimc="~/.nvimc.sh"
alias pyformatters="ruff format; ruff check --fix --config ~/.ruff_conf; isort --multi-line 3 .;"
alias stmux="ssh_init; tmux new-session nvim base.json +'Gvdiffsplit other.json' \; rename work \; new-window -c ~/projects/manual_per_services/scripts \; rename scripts \; new-window -c ~/projects/  \; attach"
alias project_init="python3.10 -m venv .venv; source .venv/bin/activate; poetry install; raf packages -a"
alias v="nvim"
alias svenv="[ -f venv/bin/activate ] && source venv/bin/activate || source .venv/bin/activate"
alias ov="OLLAMA_HOST=192.168.1.86 MODEL=gpt-oss:20b nvim"
alias ai="~/projects/manual_per_services/scripts/venv/bin/python3 ~/projects/manual_per_services/scripts/ai_cli.py"


export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion












































