#!/usr/bin/env fish

source $DOTFILES_DATA/asdf/dot_asdf/asdf.fish
    or abort "failed to setup asdf"

begin
    asdf plugin add cmake https://github.com/asdf-community/asdf-cmake.git
    asdf install cmake latest
    asdf global cmake latest
    asdf reshim cmake
    success "install cmake"
end
or abort "failed to install cmake"

begin
    asdf plugin add python https://github.com/danhper/asdf-python.git
    asdf install python latest
    asdf global python latest
    asdf reshim python
    success "install python"
end
or abort "failed to install python"

# Required to install ruby
begin
    brew install --quiet libyaml
    asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
    asdf install ruby latest
    asdf global ruby latest
    asdf reshim ruby
    success "install ruby"
end
or abort "failed to install ruby"

begin
    asdf plugin add golang https://github.com/kennyp/asdf-golang.git
    asdf install golang latest
    asdf global golang latest
    asdf reshim golang
    and success "install golang"
end
or abort "failed to install golang"
