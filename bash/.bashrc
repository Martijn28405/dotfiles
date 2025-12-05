if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

export PATH="$PATH:$HOME/flutter_sdk/flutter/bin"

if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi

extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias mkdir='mkdir -p'
alias f='nvim $(fzf)'

alias lg='lazygit'
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gpl='git pull'

alias dn='dotnet'
alias dnr='dotnet run'
alias dnb='dotnet build'
alias dnt='dotnet test'
alias dnw='dotnet watch'


alias ld='lazydocker'
alias d='docker'
alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dco='docker compose'
alias dcup='docker compose up -d'
alias dcdown='docker compose down'

alias reload='source ~/.bashrc'
alias please='sudo $(fc -ln -1)'
alias v="nvim"
alias vi="nvim"
alias vim="nvim"

if [[ "$OSTYPE" == "darwin"* ]]; then
    alias copy='pbcopy'
    alias myip='ipconfig getifaddr en0'
    alias flushdns='sudo killall -HUP mDNSResponder'
    alias rm='trash' 
else
    alias copy='xclip -selection clipboard'
    alias myip="ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print \$2}' | cut -f1  -d'/'"
    alias rm='trash-put'
fi

eval "$(zoxide init bash)"
eval "$(direnv hook bash)"
eval "$(starship init bash)"
eval "$(fzf --bash)"

alias ls="eza --icons"
alias ll="eza -la --icons --git"
alias lt="eza --tree --level=2 --icons"
alias cd="z"

unset rc
