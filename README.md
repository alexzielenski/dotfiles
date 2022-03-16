# Dotfiles

Repository of my dotfiles configuration for personal usage.

# Usage

1. Clone this repo to `~/dotfiles`
2. In Terminal, `cd ~/dotfiles`
3. If on macOS, try out `scripts/platform/macos/defaults.sh` to set a few comfortable macOS defaults.
4. Run `scripts/bootstrap.sh` to install dependencies and link dotfiles

# Magic

Some notes on non-obvious things going on behind the scenes in this repo

1. `scripts/bootstrap.sh` and `bootstrap.fish` run every script in `scripts/install`.
Some are symlinked from elsewhere in the repo to keep things together and tidy.
2. To run fish init, `oh-my-fish`'s configuration dir is changed to `omf`. `omf`
will magically run `init.fish` within that dir on startup.
3. zshrc, zprofile, zshenv, are all symlinked into `profile/*.symlink` by `scripts/bootstrap.fish`
4. In each supported shell as part of startup of noninteractive environments,
    each subfolder will have its `rc.sh` run and then `rc_$SHELL.(sh/fish)` will
    be run, depending on the shell. The scripts in `profile` control this behavior.

# Caveats

1. Not well tested on linux
2. Not well tested using zsh