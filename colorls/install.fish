# ruby 2.x installed by default on macOS since el capitan
# unsure about linux

if not type -q colorls
    gem install colorls
end

alias --save ls="colorls"
