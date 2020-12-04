red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`

reset=`tput sgr0`

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
	echo "$rebaseExists does this work"
	if [[ -z ${rebaseExists} ]]; then
		echo "The branch ${branchToRebase} doesn't exist";
		return;
	fi

	git checkout $branchToRebase;
	git rebase master;
	git checkout master;
	git branch -d $branchToRebase;
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


function quickSource {
	source ~/.bashrc
	wait
	echo ""
	echo "${green}Ran: ${magenta}source ~/.bashrc${reset}";
	echo ""
}
# Quick source
alias srcBash="quickSource"

function changeProjectConfig {
	read -p "Enter path to project folder (where all your projects are stored), base path is $HOME/" userPath
	PROJECT_BASE_PATH="$HOME/$userPath/";
	ACTIVE_PROJ_CONF="true";

	echo "export PROJECT_BASE_PATH='$PROJECT_BASE_PATH';" > "$HOME/aliases/.bash_env"
	echo "export ACTIVE_PROJ_CONF='$ACTIVE_PROJ_CONF';" >> "$HOME/aliases/.bash_env"
	wait
}

function setProject {

	while [[ true ]]; do

		if [[ $ACTIVE_PROJ_CONF == true ]]; then
			echo "";
			echo "${cyan}Active configuration: ${reset}";
			echo "${green}Base project folder path:${reset} $PROJECT_BASE_PATH"
			echo "";
			echo "${green}Project folder name:${reset} $PROJECT_FOLDER"
			echo ""

			read -p "Would you like to change base settings for the project configuration [y/n]: " option;

			optionFormatted=$(echo "$option" | tr '[:upper:]' '[:lower:]');

			if [[ $optionFormatted == "y" ]] || [[ $optionFormatted == "yes" ]]; then
				changeProjectConfig
				break;
				wait
			elif [[ $optionFormatted == "n" ]] || [[ $optionFormatted == "no" ]]; then
				break;
			else
				echo "Please supply [y/n]";
			fi
		else
			changeProjectConfig
			wait
			break;
		fi
	done

	echo "${green}Base project folder path:${reset} $PROJECT_BASE_PATH"
	folderArr=();

	while [[ true ]]; do
		if [[ "${PROJECT_BASE_PATH}" ]]; then
			echo "You have the following projects in $PROJECT_BASE_PATH":
			incr=0;
			for path in $PROJECT_BASE_PATH*; do

				if [[ ${path#$PROJECT_BASE_PATH} == "*" ]]; then
					echo "${red}You have no folders in ${magenta}$PROJECT_BASE_PATH${reset}"
					echo "Create some projects and run this again"
					echo "" > "$HOME/aliases/.bash_env"
					ACTIVE_PROJ_CONF="";
					PROJECT_BASE_PATH="";
					return;
				fi

				projectFolder=${path#$PROJECT_BASE_PATH};
				echo "[$incr]: $projectFolder";
				folderArr[incr]=$projectFolder;
				incr=$(($incr+1));

			done
			while [[ true ]]; do
				read -p "Enter the number of the project you want to set: " number
				if [ "$number" -eq "$number" ] 2>/dev/null && [[ $number -lt $((${#folderArr[@]}-1)) || $number == $((${#folderArr[@]}-1)) ]]; then

					folder=${folderArr[number]};
					IFS=$'\n' read -d '' -r -a bashEnvs < $HOME/aliases/.bash_env

					if [[ $((${#bashEnvs[@]}-1)) == "2" ]]; then
						sed -i '$ d' "$HOME/aliases/.bash_env"
					fi
					echo "export PROJECT_FOLDER='$folder';" >> "$HOME/aliases/.bash_env"

					wait

					source "$HOME/.bash_profile";
					break;
				else
				  echo "Please enter a number in the array"
				fi
			done
		fi
		break;
	done
}

# Project setup
alias confProj="setProject"

function openProject {
	if [[ -z $1 ]]; then
		if [[ -z $PROJECT_BASE_PATH ]] && [[ -z $PROJECT_FOLDER ]]; then
			confProj
		fi
		cd "$PROJECT_BASE_PATH/$PROJECT_FOLDER";
	else
		cd "$PROJECT_BASE_PATH/$1";
	fi
	atom .
}

alias openProj="openProject"
