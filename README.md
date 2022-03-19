# Dotfiles

Repository of my dotfiles configuration for personal usage.

# Usage

1. Clone this repo to `~/dotfiles`
2. In Terminal, `cd ~/dotfiles`
3. If on new macOS install, try out `scripts/platform/macos/defaults.sh` to set
    a few comfortable macOS defaults.

    Note: It is not easy to revert this
4. Run `scripts/bootstrap.sh` to install dependencies and link dotfiles

# Magic

Some notes on non-obvious things going on behind the scenes in this repo

1. `scripts/bootstrap.sh` and `bootstrap.fish` run every script in
    `scripts/install`.
Some are symlinked from elsewhere in the repo to keep things together and tidy.
2. Each of fish and zsh get similar environments. This is due to dotfiles trying
    to ensure they both load consistently:
    - Fish: `scripts/bootstrap.fish` creates the following symlinks:
        1. `~/.config/fish/config.fish` is symlinked to `profile/fish.fish`
        2. `~/.config/fish/conf.d/000dotfilesenv.fish` is symlinked to
            `profile/env.fish`
        3. this is done to make environment vars available to the fish plugins
            which load before `config.fish`.
    - Zsh: `~/.zshrc`, `~/.zprofile`, `~/.zshenv`, are all symlinked into
    `profile/*.symlink` by `scripts/bootstrap.fish`
3. Startup scripts define `$shell` as `fish` or `zsh`
4. In each supported shell as part of startup of new shells, each subfolder will
    have its `env.sh` run and then  `env_$shell.(sh/fish)` will
    be run, depending on the shell.

    This is controlled by `profile/common_env.sh`, `profile/env.fish`, and
    `profile/zshrc.symlink`.
5. In each supported shell at the END of startup for all environments,
    each subfolder will have its `rc.sh` run and then `rc_$shell.(sh/fish)` will
    be run, depending on the shell.

    This is controlled by `profile/common_env.sh`, `profile/env.fish`, and
    `profile/zshrc.symlink`.

# Caveats

1. Not well tested on linux
2. No plugins/autocomplete/highlighting yet set up for zsh
3. The scripts are written to be portable, but only ever tested when installed
    from `~/dotfiles`.
4. Doesn't touch `bash` environment, so you can use that as a fallback if these
scripts somehow brick your terminal.

# Tools Summary

Often I forgot what tools I have or how they work.  This here is a cheatsheet
of useful things set up.

## Installed Packages

| Name                    | Description                                        |
|-------------------------|----------------------------------------------------|
| [asdf](#asdf)           | general-purpose version manager                    |
| [coreutils](#coreutils) | GNU command line utilities                         |
| [bat](#bat)             | `cat` replacement with syntax highlighting &  more |
| [exa](#exa)             | more readable `ls`                                 |
| [fd](#fd)               | faster and user friendly `find` replacement        |
| [fish](#fish)           | friendly interactive shell                         |
| [fisher](#fisher)       | package manager for fish                           |
| [fonts](#fonts)         | patched "nerd fonts" for use in terminal           |
| [fzf](#fzf)             | fuzzy file finder                                  |
| [grc](#grc)             | General purpose command output colorizer           |
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
| Ruby      | https://github.com/asdf-vm/asdf-ruby.git                         |
| Python    | https://github.com/danhper/asdf-python.git                       |

### coreutils
https://formulae.brew.sh/formula/coreutils

A library of command line tools provided by GNU. Some of these tools are also
provided by macOS. In these cases the GNU tool will take precedence. Some
examples of such conflicts are `ls`, `sed`, `realpath`, `echo`, `make`, `tee`,
`cat`, etc.

### bat
https://github.com/sharkdp/bat

A cat(1) clone with syntax highlighting and Git integration.

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