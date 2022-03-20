# Symlink VSCode settings to here

if test_app "Visual Studio Code"
    info "vscode already installed"
else
    brew install --cask --quiet visual-studio-code
        and success "install vscode"
        or abort "install vscode"
end

switch (uname)
case Darwin
    set vscode_settings_path "$HOME/Library/Application Support/Code/User/settings.json"
    set code_binary "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
    if not test -f $code_binary
        set code_binary "$HOME/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
    end
case Linux
    set vscode_settings_path "$HOME/.config/Code/User/settings.json"
case Windows
    # lol does this even work
    set vscode_settings_path "%APPDATA%\\Code\\User\\settings.json"
case '*'
    abort 'unrecognized system: '(uname)
end

if not test -f $code_binary
    abort 'could not locate vscode `code` command line tool. Please move VSCode installation to standard location, or add `code` to PATH'
end

# Link settings
link_file "$DOTFILES/vscode/settings.json" "$vscode_settings_path" backup
    or abort 'failed to link vscode settings'

# Install Extensions
function vscode_install
    $code_binary --install-extension $argv[1] 1> /dev/null
        and success "install extension: $argv[2] ($argv[1])"
        or abort "install extension: $argv[2] ($argv[1])"
end

vscode_install "ms-vscode-remote.vscode-remote-extensionpack" "Remote Extension Pack"
vscode_install "shardulm94.trailing-spaces" "Trailing Spaces"
vscode_install "eamodio.gitlens" "GitLens"
vscode_install "bmalehorn.vscode-fish" "Fish Highlighting"
vscode_install "github.github-vscode-theme" "Github Themes"
vscode_install "PKief.material-icon-theme" "Material Icon Theme"
