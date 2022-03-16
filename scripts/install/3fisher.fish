#!/usr/bin/env fish

if type -q fisher
    info "fisher is already installed"
    exit 0
end

curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > /tmp/install_omf
# source /tmp/install_omf --config="$DOTFILES/omf" --noninteractive --yes
#     and success "install oh-my-fish"
#     or abort "install oh-my-fish"
