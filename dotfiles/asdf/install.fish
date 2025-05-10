#!/usr/bin/env fish

brew install --quiet asdf
    or abort "failed to install asdf"

# if unset data dir
if test -z "$ASDF_DATA_DIR"
    export ASDF_DATA_DIR="$HOME/.asdf"
end

begin
    asdf plugin add cmake https://github.com/asdf-community/asdf-cmake.git
    asdf install cmake latest
    asdf set cmake latest --home
    asdf reshim cmake
    success "install cmake"
end
or abort "failed to install cmake"

begin
    asdf plugin add python https://github.com/danhper/asdf-python.git
    asdf install python latest
    asdf set python latest --home
    asdf reshim python
    success "install python"
end
or abort "failed to install python"

# Required to install ruby
begin
    brew install --quiet libyaml
    asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
    asdf install ruby latest
    asdf set ruby latest --home
    asdf reshim ruby
    success "install ruby"
end
or abort "failed to install ruby"

begin
    asdf plugin add golang https://github.com/kennyp/asdf-golang.git
    asdf install golang latest
    asdf set golang latest --home
    asdf reshim golang
    and success "install golang"
end
or abort "failed to install golang"
