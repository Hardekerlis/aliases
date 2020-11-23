Pull this repo at your home folder. To get to the root folder do **'cd ~'**

make sure to to add these line at the bottom in your .bashrc file in fedora:
```bash
source "$HOME/aliases/.bash_aliases"
source "$HOME/aliases/.bash_env"
```

### Kubectl
```bash
alias k="kubectl"
alias kga="k get all"
alias kgaa="kga --all-namespaces"
alias kgan="kga -n"
alias kd="k describe"
alias kdp="kd pod"
alias kds="kd service"
```



### Git
```bash
alias gc="git checkout"
alias gcm="git checkout master"
alias gcb="git checkout -b"
alias rebase='rebaseBranch'
alias gab="git branch -l"
alias grb="git branch -d"
alias grbforce="git branch -D"
```

### Only for development
```bash
alias quickpush="git add . && git commit -am 'Not important' && git push"
```

### Project management
```bash
alias confProj="setProject"
alias openProj="openProject"
```
