function rebaseBranch {
	local BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`;

	if [ "${BRANCH}" == "" ]; then # Check if there is a branch. This is to see if the user is located in a git repo
		echo "You are not in a git repositry";
		return;
	fi
	if [ "$1" == "" ]; then # Check if an argument is supplied
		echo "No branch to rebase supplied";
		return;
	fi

	branchToRebase="$1";

	local rebaseExists=$(git branch --list ${branchToRebase}) # Check if the branch to rebase exists
	echo $rebaseExists
	if [[ -z ${rebaseExists} ]]; then
		echo "The branch ${branchToRebase} doesn't exist";
		return;
	fi

	git checkout $branchToRebase;
	git rebase master;
	git checkout master;
	git branch -d branchToRebase;
	echo Rebased $branchToRebase into master;
}

#Kubectl
alias k="kubectl"
alias kga="k get all"
alias kgaa="kga --all-namespaces"
alias kgan="kga -n"
alias kd="k describe"
alias kdp="kd pod"
alias kds="kd service"

#Git
alias gc="git checkout"
alias gcm="git checkout master"
alias gcb="git checkout -b"
alias rebase='rebaseBranch'
alias gab="git branch -l"
alias grb="git branch -d"
alias grbforce="git branch -D"

# Only for development
alias quickpush="git add . && git commit -am 'Not important' && git push"
