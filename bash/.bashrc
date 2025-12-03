# .bashrc
#

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi


# Slim uitpakken
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

# --- Navigatie & Bestanden ---
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Maak mappen aan (en submappen) als ze niet bestaan
alias mkdir='mkdir -p'

# Weet je nog fzf? Dit maakt zoeken makkelijker
# 'f' opent fzf en opent het gekozen bestand direct in nvim
alias f='nvim $(fzf)' 

# --- Git & LazyGit ---
# Waarom 'lazygit' typen als 'lg' ook kan?
alias lg='lazygit'

# Voor als je toch snel even met CLI git werkt
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gpl='git pull'

# --- Programmeren (.NET & Rust) ---
# Omdat je .NET 8 gebruikt:
alias dn='dotnet'
alias dnr='dotnet run'
alias dnb='dotnet build'
alias dnt='dotnet test'
alias dnw='dotnet watch' # Hot reload!


# --- Docker ---
# Standaard docker afkortingen
alias d='docker'
alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dco='docker compose'
alias dcup='docker compose up -d'
alias dcdown='docker compose down'

# --- Systeem & Utils ---
# Snel je configuratie herladen na een wijziging
alias reload='source ~/.bashrc'

# Kopieer output naar klembord (werkt op Linux/WSL/Mac als je 'xclip' of 'pbcopy' hebt)
# Check even wat je hebt, op Ubuntu vaak: alias copy='xclip -selection clipboard'

# my ip: Wat is mijn lokale IP? (handig voor mobiel testen)
alias myip="ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print \$2}' | cut -f1  -d'/'"


eval "$(zoxide init bash)"
eval "$(direnv hook bash)"
eval "$(starship init bash)"
eval "$(fzf --bash)"

alias ls="eza --icons"
alias ll="eza -la --icons --git"
alias lt="eza --tree --level=2 --icons"

alias cd="z"

alias rm=trash

alias please='sudo $(fc -ln -1)'

alias v="nvim"
alias vi="nvim"
alias vim="nvim"

unset rc
