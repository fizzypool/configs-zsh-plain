_start_load_time=$(gdate +%s)

# Load Zplug plugin manager.
source "${HOME}/.zplug/init.zsh"

# Abbreviations.
zplug "momo-lab/zsh-abbrev-alias"

# ZSH normalization.
zplug "fizzypool/zsh-normalize"
# Integration between ZSH and external tools.
zplug "fizzypool/zsh-external-tools"
# Highlight words.
zplug "zdharma/fast-syntax-highlighting"
# Search in substrings.
zplug "zsh-users/zsh-history-substring-search"
# Autosuggestions.
zplug "zsh-users/zsh-autosuggestions"
# Additional completion definitions.
zplug "zsh-users/zsh-completions"
# Colorize ls.
zplug "trapd00r/LS_COLORS"
if [[ ! -f ~/.zplug/repos/trapd00r/LS_COLORS/LS_COLORS.plugin.zsh ]]; then
  gdircolors -b ~/.zplug/repos/trapd00r/LS_COLORS/LS_COLORS > ~/.zplug/repos/trapd00r/LS_COLORS/LS_COLORS.plugin.zsh
fi
source ~/.zplug/repos/trapd00r/LS_COLORS/LS_COLORS.plugin.zsh
# Colorize man pages.
zplug "ael-code/zsh-colored-man-pages"
# Auto-close and delete matching delimiters.
typeset -gA AUTOPAIR_PAIRS; AUTOPAIR_PAIRS+=("<" ">")
zplug "hlissner/zsh-autopair"
# Automatically send out a notification when a long running task has completed.
AUTO_NOTIFY_THRESHOLD=20
zplug "MichaelAquilina/zsh-auto-notify"
# Install diff-so-fancy and enables git subcommand git dsf.
zplug "zdharma/zsh-diff-so-fancy"
# FZF integration with git.
zplug "wfxr/forgit"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Source plugins (and add commands to $PATH).
zplug load

# Configure Homebrew completions.
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
  autoload -Uz compinit
  compinit
fi

# Initialize abbrev-alias.
if which abbrev-alias > /dev/null 2>&1; then
  abbrev-alias --init
else
  echo "Missing command abbrev-alias: skipping aliases initialization"
fi

# Load ZSH starship prompt.
eval "$(starship init zsh)"

_end_load_time=$(gdate +%s)
echo "Shell loading time: $(( $_end_load_time - $_start_load_time )) seconds"
unset _start_load_time
unset _end_load_time
