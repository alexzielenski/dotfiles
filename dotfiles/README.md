# Dotfiles

Repository of my dotfiles configuration for personal usage.

# Usage

## First Installation

Set up chezmoi configured to sync with this GitHub repository

1. Install [`chezmoi`](https://www.chezmoi.io): `sh -c "$(curl -fsLS get.chezmoi.io)"`
2. Initialize chezmoi against this repo: `chezmoi init --apply alexzielenski`

## Update

Pull the latest dotfiles from the repo and apply them to your machine:

1. `chezmoi update -v`

# Goals

The over-arching design goals of these dotfiles is to be:

1. self-contained
    
    All files and configurations when synced are kept nice and tidy packed into
    `~/dotfiles` as much as possible.
    
    The only exception to this are symlinks placed throughout the system to 
    point into the dotfiles folder for cases where it could not be avoided.

2. exensible

    Each component's installation, configuration, and sometimes installation
    is kept within its own folder. 
    
    Adding a new component is as easy as adding a new folder and giving it a name. 
    Removing a component is as easy as removing a folder.

    Extension points for things like custom environment files sourced before
    or after dependencies.

3. idempotent

    Installing/applying these dotfiles should always yield the same result
    no matter how many times you apply them. 
    
    This is achieved by making post-install scripts aware of this requirement
    and using chezmoi to manage application of dotfiles.

# Structure

## General Folder Structure

In general by convention, `.zsh` files are executed only on zsh shells, `.fish` only
in fish shells, and `.sh` are executed for all shells.

```
> dotfiles
|-> scripts
|---> install           # Folder of symlinks to install.fish for custom order
|-> <component>         # Folder for each component
|---> rc.{sh,zsh,fish}  # Sourced on shell startup.
|---> env.{sh,zsh,fish} # Sourced on shell startup before any module's `rc`
|---> install.fish      # Run after every `chezmoi apply`. Symlinked from scripts/install
|-> config.sh           # Sourced on shell startup before all env
|-> env.sh              # Sourced on shell startup before all rc, after all env
|-> install_env.fish    # Sourced before any `install.fish` during `chezmoi apply`
```
> Note most components do not need to use `env`. `rc` scripts should be preferred. 
env should be reserve for components which are dependencies of other components.
There is no way to order execution of env files in a dependency graph, since this
has not been needed.

## Install

`chezmoi` apply is the entry point for all installation steps. When applying
files chezmoi also runs some scripts included in this repo due to their special
names:

1. `run_once_before_install_deps.sh`: Runs once after first sucessful `chezmoi apply` 
to install bootstrap dependencies:
    - Xcode tools (for macOS)
    - brew, zsh, and fish since these are all dependencies to the rest of the tooling. Fish is a requirement even if your preferred shell is zsh.

2. `run_after_install_scripts.fish`: Runs after files are synced each time with `chezmoi apply`
    - Sources `install_env.fish`
    - Executes all scripts inside `scripts/install` in alphabetical order.

## Bootstrap

Bootstrapping refers to the process of injecting our dotfiles early in the startup
process of fish and zsh to make modifications to the shell environment and sourcing
all the module's rc scripts.

### Fish

1. Place files on system outside of dotfiles for fish entrypoints:
    - .config/fish/conf.d/fish_plugins: Symlink to ~/dotfiles/fisher/plugins
        1. Sadly not configurable at time of writing
    - .config/fish/conf.d/000000_dotfiles_env.fish:
        1. Set `$DOTFILES` and `$DOTFILES_DATA`
        2. Source `$DOTFILES/profile/bootstrap.fish`
2. On startup fish runs our env file first due to its naming, and promptly runs bootstrap.fish
with required environment variables:
    - Set `$shell` to `fish`
    - Runs root `config.sh`
    - Sets up homebrew
    - Runs all `<module>/env.sh` files
    - Runs all `<module>/env.fish` files
    - Runs root `env.sh`
    - Runs all `<module>/rc.sh` files
    - Runs all `<module>/rc.fish` files

### Zsh

1. Hook zsh startup using add special ~/.zshenv that:
    - Set `$DOTFILES` and `$DOTFILES_DATA`
    - Set `ZDOTDIR` (zsh configuration folder) to `$DOTFILES/zsh` which contains
        - .zshenv: For sourcing env files
        - .zshrc: For sourcing rc files
    - Runs `$DOTFILES/zshenv`
2. On startup `$DOTFILES/zsh/.zshenv` (sourced by our ~/.zshenv) will:
    - Set `$shell` to `zsh`
    - Sets up homebrew
    - Runs all `<module>/env.sh` files
    - Runs all `<module>/env.zsh` files
    - Runs root `env.sh`
3. After startup is complete, `$DOTFILES/zsh/.zshrc` is run by `zsh` due to `ZDOTDIR` override:
    - Runs all `<module>/rc.sh` files
    - Runs all `<module>/rc.zsh` files

# Caveats

1. Not well tested on linux
2. No plugins/autocomplete/highlighting yet set up for zsh
3. The scripts are written to be portable, but only ever tested when installed
    from `~/dotfiles`.
4. Doesn't touch `bash` environment, so you can use that as a fallback if these
scripts somehow brick your terminal.
5. Looks like sheldon now has experimental  support for fish. May move from fisher to sheldon so to have a unified package manager.

# Tools Summary

Often I forgot what tools I have or how they work.  This here is a cheatsheet
of useful things set up.

## Installed Packages

| Name                    | Description                                        |
|-------------------------|----------------------------------------------------|
| [asdf](#asdf)           | general-purpose version manager                    |
| [brew](#brew)           | Cross platform command line tool package manager   |
| [coreutils](#coreutils) | GNU command line utilities                         |
| [bat](#bat)             | `cat` replacement with syntax highlighting &  more |
| [exa](#exa)             | more readable `ls`                                 |
| [fd](#fd)               | faster and user friendly `find` replacement         |
| [fish](#fish)             | friendly interactive shell                         |
| [fisher](#fisher)         | package manager for fish                            |
| [fonts](#fonts)         | patched "nerd fonts" for use in terminal           |
| [fzf](#fzf)             | fuzzy file finder                                    |
| [grc](#grc)             | General purpose command output colorizer           |
| [sheldon](#sheldon)     | package manager for zsh                            |
| [starship](#starship)   | cross platform shell prompt                        |
| [tide](#tide)           | cross platform shell prompt                        |
| [iterm2](#iterm2)       | Juiced up & customizable terminal for macOS        |
| [zoxide](#zoxide)       | fast implementation of `z` for fast directory jump |

## Installed Aliases

| Name       | Description                                              | Folder |
|------------|----------------------------------------------------------|------|
| `ls`       | `exa --icons --color=always --group-directories-first`   | exa  |
| `ll`       | `ls -l --git`                                            | exa  |
| `t` | `ll -T --no-permissions --no-user --no-time --no-filesize -L=1` | exa  |
| `tt`       | `t -L=2`                                                 | exa  |
| `ttt`      | `t -L=3`                                                 | exa  |
| `tttt`     | `t -L=4`                                                 | exa  |
| `gs`       | `git status -s`                                          | git  |
| `packages` | `brew leaves \| xargs -n1 brew desc`                     | brew |
| `tower`    | `git-tower <folder>`                                     | tower |

## Installed Plugins
### Fish

| Name                                  | Description                          |
|---------------------------------------|--------------------------------------|
| jorgebucaran/fisher                   | Fish plugin/package manager          |
| jorgebucaran/replay.fish              | Allows fish to run bash scripts      |
| jorgebucaran/autopair.fish            | Inserts matching parens, etc         |
| paysonwallach/fish-you-should-use     | Suggest alias if available           |
| andreiborisov/sponge                  | Cleans CTRL-R history from failures  |
| PatrickF1/fzf.fish                    | Adds additional fzf integration      |
| oh-my-fish/plugin-grc                 | Defines common aliases for `grc`     |

### Zsh

No zsh plugins or plugin managers installed.

## KeyBinds

I always forget my hotkeys.

| HotKey     | Receiver  | Description                                         |
|------------|-----------|-----------------------------------------------------|
| Alt-C      | fzf       | cd into selected search directory                   |
| Ctrl-T     | fzf       | search files/dirs, paste path into command          |
| Ctrl-Alt-F | fzf-fish  | `F` for `file`. search files/dirs. paste path.      |
| Ctrl-Alt-S | fzf-fish  | `S` for `status`. search git changes, paste relpath |
| Ctrl-Alt-L | fzf-fish  | `L` for `log`. search git log. paste commit hash    |
| Ctrl-Alt-P | fzf-fish  | `P` for process. search `ps` names. paste PID       |
| Ctrl-V     | fzf-fish  | `V` for variables. search environ vars. paste $var  |
| Ctrl-R     | fzf-fish  | search command history, paste onto command line     |
| Alt-Left   | iterm     | cursor move to start of previous word               |
| Alt-Right  | iterm     | cursor move to end of next word                     |
| Ctrl-A     | iterm     | cursor move to beginning of prompt                  |
| Ctrl-E     | iterm     | cursor move to end of prompt                        |

## Package Reference

### asdf
https://asdf-vm.com

asdf exists because there are too many different version nmanagers all with
different arguments. ASDF unifies them (including version installation) all
under one nice CLI interface which works without touching your filesystem
(using aliases).

The following asdf plugins are configured:

| Command   | Source                                                           |
|-----------|------------------------------------------------------------------|
| CMake     | https://github.com/asdf-community/asdf-cmake.git                 |
| Ruby      | https://github.com/asdf-vm/asdf-ruby.git                         |
| Python    | https://github.com/danhper/asdf-python.git                       |
| Golang    | https://github.com/kennyp/asdf-golang.git                        |

### coreutils
https://formulae.brew.sh/formula/coreutils

A library of command line tools provided by GNU. Some of these tools are also
provided by macOS. In these cases the GNU tool will take precedence. Some
examples of such conflicts are `ls`, `sed`, `realpath`, `echo`, `make`, `tee`,
`cat`, etc.

### bat
https://github.com/sharkdp/bat

A cat(1) clone with syntax highlighting and Git integration.

### brew
https://brew.sh

The Missing Package Manager for macOS (or Linux)

### exa

https://the.exa.website

A more user-friendly `ls` replacement.

Caveats:

- `ls` is only aliased to `exa` if the shell is interactive. This is to
    prevent scripts or subshells making use of `ls` from having their expected
    output changed.

### fd
https://github.com/sharkdp/bat

A simple, fast and user-friendly alternative to 'find'

### fish
https://fishshell.com

### fisher
https://github.com/jorgebucaran/fisher

A plugin manager for Fish.

Chosen because it supports both OMF plugins and has wide GH repo support.

Plugins list is symlinked into `$DOTFILES/fisher/plugins`

#### TLDR Usage:

- `fisher install ilancosman/tide`
- `fisher install jorgebucaran/nvm.fish@2.1.0`
- `fisher install ~/path/to/plugin`
- `fisher list [regex]`
- `fisher update jorgebucaran/fisher`
- `fisher remove jorgebucaran/nvm.fish@2.1.0`

### fonts

Fonts are installed using `brew tap homebrew/cask-fonts`

- font-meslo-lg-nerd-font

    Font used by terminal. Must be a patched Nerd Font.

### fzf

🌸 A command-line fuzzy finder

https://github.com/junegunn/fzf

fzf fish integration:
Augment your fish command line with fzf key bindings.

https://github.com/PatrickF1/fzf.fish


Fish shell integration adds additional keybinds which make use of
the more expensive, interactive features such as preview window.

### grc
https://github.com/garabik/grc

Generic Colouriser

Does an OK job at colorizing the output of some generic commands.

Fisher plugin is used to install aliases on fish.

No extra zsh integration added.

### Sheldon
https://sheldon.cli.rs

Sheldon is a fast, configurable, command-line tool to manage your shell plugins.

Only used for zsh. Looks like it has experimental fish support.

### Starship
https://starship.rs

The minimal, blazing-fast, and infinitely customizable prompt for any shell!

![](https://starship.rs/demo.webm)

### Tide
https://github.com/IlanCosman/tide

The ultimate Fish prompt. Like a p10k but for fish.

### iterm2
https://iterm2.com

Modern macOS terminal.

The bootstrap script installs profiles to use with iTerm. I recommend using it
as default. As well as setting iTerm theme to `Minimal` in the `Appearance` tab.

Unfortunately I do not see a way to do this from the command line.

### zoxide
https://github.com/ajeetdsouza/zoxide

zoxide is a **smarter cd command**, inspired by z and autojump.

It remembers which directories you use most frequently, so you can "jump" to
them in just a few keystrokes.

zoxide works on all major shells.

```sh
z foo              # cd into highest ranked directory matching foo
z foo bar          # cd into highest ranked directory matching foo and bar
z foo /            # cd into a subdirectory starting with foo

z ~/foo            # z also works like a regular cd command
z foo/             # cd into relative path
z ..               # cd one level up
z -                # cd into previous directory

zi foo             # cd with interactive selection (using fzf)

z foo<SPACE><TAB>  # show interactive completions
```