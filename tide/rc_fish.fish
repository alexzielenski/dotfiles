test $interactive = 1
    or exit

# unfortunately there is no way to selectively disable installed fisher
# plugins

if test "$DOTFILES_FISH_PROMPT" = "tide"
    if not contains "ilancosman/tide" $_fisher_plugins
        fisher install ilancosman/tide
    end
else
    if contains "ilancosman/tide" $_fisher_plugins
        fisher remove ilancosman/tide
    end
end
