# Migrate the existing zsh startup environment: Homebrew, local user tools, and mise.
if test -x /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
else if test -x /usr/local/bin/brew
    eval (/usr/local/bin/brew shellenv)
end

fish_add_path --prepend --global "$HOME/.local/bin"

if command -q mise
    mise activate fish | source
end
