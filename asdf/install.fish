#!/usr/bin/env fish

brew install -q asdf

asdf plugin add python https://github.com/danhper/asdf-python.git
asdf install python latest
asdf global python latest

asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf install ruby latest
asdf global ruby latest
