#!/usr/bin/env bash

DIR=${BASH_SOURCE%/*}

source "$DIR/install_dependencies.sh"

fish "$DIR/bootstrap.fish"
