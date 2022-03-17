#!/usr/bin/env bash
echo "Installing dependencies..."

# Keep going past subscript failures
set +e

# Install Xcode command line tools on osx
if [ "$(uname -s)" == "Darwin" ]; then
    xcode-select --install
fi

if ! command -v brew &> /dev/null
then
    echo "brew could not be found"
    echo "installing brew"
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
fi

if ! command -v fish &> /dev/null
then
    echo "fish could not be found"
    echo "installing fish"
    brew install fish
fi

#todo make sure fish at least 3.4.0
currentver="$(fish -v)"
requiredver="3.4.0"
if [ "$(printf '%s\n' "$requiredver" "$currentver" | sort -V | head -n1)" = "$requiredver" ]; then 
    echo "Fish at least v${requiredver}"
else
    echo "You must have at least fish version ${requiredver}. Please upgrade."
    exit 1
fi


if ! command -v zsh &> /dev/null
then
    echo "zsh could not be found"
    echo "installing zsh"
    brew install zsh
fi

echo "Done installing dependencies..."
