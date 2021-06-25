# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/marcus_mors/.oh-my-zsh"
# export PATH="/home/marcus_mors/anaconda3/bin:$PATH"  # commented out by conda initialize



# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias gmoji="gitmoji -c"
#alias gch = "git checkout header"
#alias gcf = "git checkout footer"
#alias gcb = "git checkout body"


alias m:psql-start="sudo service postgresql start"



m:clear(){
  default=20
  for i in `seq 1 ${1:-${default}}` do
    echo ""
}

m:git_flow_init(){ 
  declare -a arr=($1 $2 ${3:-"h"} ${4:-"r"} ${5:-"d"}) 
  git init
  for i in "${arr[@]}" do
    case ${i} in
    m)  git branch marcus ;;
    f)  echo "Feature branch name: "
        read fname
        git branch $fname ;;
    h)  git branch hotfix ;;
    r)  git branch releases ;;
    d)  git branch develop ;;
    ?) echo "Not recognizable gitflow branch";;
    esac
}


m:c++_init(){
#   declare -a arr=($1 $2 $3)
#   CURRENTDATE=`date +”%A, %b %d, %Y %H:%M:%S”"`
  mkdir src/ build/ libs/ include/ tests/
  # mkdir ./src/headers/
  touch ./src/main.cpp ./cmakeLists.txt .gitignore README.md
  #date
  #date +”%A, %b %d, %Y %H:%M:%S”
  #sed
  echo "¿What license you want for your project?
  [GPLv3][none]
  default: GPLv3
  ==> "
  read license
  if [[ "$license" != "none" ]]
  then
    cp ~/.aliases-src/licenses/$license.txt .
    mv ./$license.txt ./COPYING
  fi
  echo "build/*" >> .gitignore
  echo "## Project Fyle Structure
    
    Project_name/
    |
    |---- CMakeLists.txt
    |---- main.cpp
    |
    |---- include/
    |       |
    |       |---- Project_name
    |               |
    |               |---- public_headers.hh (C++ only)
    |               |---- public_headers.h (C & C++)
    |---- src/
    |       |
    |       |---- private_headers.hh (C++ only)
    |       |---- private_headers.h  (C & C++)
    |       |---- implementation_files.cc
    |       |---- implementation_files.C (if compiler doesn't accept .cc)
    |       |---- inline_definition_files.icc
    |
    |---- libs/
    |       |
    |       |---- A
    |       |
    |       |---- B
    |
    |---- tests/

## Compile the project

\`\`\`bash I'm A tab
    take build/
    cmake ..
    make --build .
\`\`\`" >> README.md
}

    # $0 - The name of the Bash script.
    # $1 - $9 - The first 9 arguments to the Bash script. (As mentioned above.)
    # $# - How many arguments were passed to the Bash script.
    # $@ - All the arguments supplied to the Bash script.
    # $? - The exit status of the most recently run process.
    # $$ - The process ID of the current script.
    # $USER - The username of the user running the script.
    # $HOSTNAME - The hostname of the machine the script is running on.
    # $SECONDS - The number of seconds since the script was started.
    # $RANDOM - Returns a different random number each time is it referred to.
    # $LINENO - Returns the current line number in the Bash script.




source ~/powerlevel10k/powerlevel10k.zsh-theme
#source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/marcus_mors/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/marcus_mors/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/marcus_mors/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/marcus_mors/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/marcus_mors/.sdkman"
[[ -s "/home/marcus_mors/.sdkman/bin/sdkman-init.sh" ]] && source "/home/marcus_mors/.sdkman/bin/sdkman-init.sh"
