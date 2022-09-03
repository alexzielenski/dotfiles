#!/usr/bin/env bash

# Root dependencies

# Install brew for Linux/OSX
if ! command -v brew &> /dev/null
then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    exit
fi

# Install Fish for Linux/OSX
if ! command -v fish &> /dev/null
then
    brew install -q fish
    exit
fi

