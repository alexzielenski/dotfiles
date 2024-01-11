if ! type "brew" &> /dev/null; then
  # brew not installed. exit silently
  echo "brew not found?"
  return
fi

# Use coreutils gnubins first in PATH to override built-in macOS versions which
# # support non-standard flags

# having problems with uname -m reporting x86 on new windows
# with zsh for some reason when we use this
# export PATH="$(brew --prefix coreutils)/libexec/gnubin":PATH
# export MANPATH="$$(brew --prefix coreutils)/libexec/gnuman":$MANPATH
# support non-standard flags
export PATH=$(brew --prefix grep)/libexec/gnubin:$PATH
export MANPATH="$(brew --prefix coreutils)/libexec/gnuman":$MANPATH
export PATH=$(brew --prefix gnu-sed)/libexec/gnubin:$PATH
