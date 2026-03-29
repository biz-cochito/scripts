# Auto-generated Fish abbreviations
abbr --add o opencode
abbr --add ze 'zeditor . &'
abbr --add gcr 'git clone --recursive'
abbr --add gc 'git clone'
abbr --add m mpv
abbr --add feeds 'nvim '$HOME/.config/newsraft/feeds''
abbr --add gpgd 'gpg --decrypt --armor'
abbr --add expub 'gpg --export --armor 009E98E05B64D505758E9727C0D1212D80B50937'
abbr --add mkdir 'mkdir -p'
abbr --add yeet 'yay -Rcs'
abbr --add news 'yay -Pw'
abbr --add .. 'cd ..'
abbr --add ... 'cd ../..'
abbr --add .3 'cd ../../..'
abbr --add .4 'cd ../../../..'
abbr --add .5 'cd ../../../../..'

# Appended from /home/bis/.zsh/aliases/hyprland
abbr --add flip 'hyprctl keyword monitor \'HDMI-A-1,preferred,auto,1,transform,1\''

# Appended from /home/bis/.zsh/aliases/system
abbr --add x exit
abbr --add c clear
abbr --add e '$EDITOR'
abbr --add zrc 'vim $HOME/.zsh/.zshrc'
abbr --add a antigravity
abbr --add ag 'antigravity . &'
abbr --add error 'journalctl -b -p err'
abbr --add mkx 'chmod +x'
abbr --add fetch1 'fastfetch --config examples/20.jsonc'
abbr --add mach '/home/bis/bin/machine_report.sh'
abbr --add browz 'pacman -Qq | fzf --preview \'pacman -Qil {}\' --layout=reverse --bind \'enter:execute(pacman -Qil {} | less)\''
