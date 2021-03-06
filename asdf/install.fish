#!/usr/bin/env fish

brew install -q asdf

asdf plugin add python https://github.com/danhper/asdf-python.git
asdf install python latest
asdf global python latest

asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf install ruby latest
asdf global ruby latest

asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf install golang latest
asdf global golang latest
