# EXTRA CLIPBOARD COPY TOOLS
#   taken from Oh My Zsh plugins - see:
#     - https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/copybuffer/copybuffer.plugin.zsh
#     - https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/copyfile/copyfile.plugin.zsh
#     - https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/copypath/copypath.plugin.zsh

# Copyies the active line from the command line buffer onto the system clipboard
xxbuf () {
    if builtin which xclip &>/dev/null; then
        printf "%s" "$BUFFER" | xclip -selection clipboard
    else
        zle -M "xclip not found"
    fi
}
zle -N xxbuf
bindkey '^O' xxbuf

# Copies the contents of a given file to the system or X Windows clipboard
function xxfile {
    emulate -L zsh
    xclip -selection clipboard $1
}

# Copies the path of given directory or file to the system or X Windows clipboard
#   (copies current directory if no parameter is provided)
function xxpath {
    # If no argument passed, use current directory
    local file="${1:-.}"
    # If argument is not an absolute path, prepend $PWD
    [[ $file = /* ]] || file="$PWD/$file"
    # Copy the absolute path without resolving symlinks (if clipcopy fails, exit the function with an error)
    print -n "${file:a}" | xclip -selection clipboard || return 1
    echo ${(%):-"%B${file:a}%b copied to clipboard."}
}
