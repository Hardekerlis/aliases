Pull this repo at your home folder. To get to the root folder do 'cd ~'

make sure to to add this line at the bottom in your .bashrc file in fedora:
```bash
source "$HOME/aliases/.bash_aliases"
```

#Kubectl
```bash
alias k="kubectl"
alias kga="k get all"
alias kgaa="kga --all-namespaces"
alias kgan="kga -n"
alias kd="k describe"
alias kdp="kd pod"
alias kds="kd service"
```



#Git
```bash
alias gc="git checkout"
alias gcm="git checkout master"
alias gcb="git checkout -b"
alias rebase='rebaseBranch'
alias gab="git branch -l"
alias grb="git branch -d"
alias grbforce="git branch -D"
```
