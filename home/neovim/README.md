# 👾

## Resources:
- https://laracasts.com/series/neovim-as-a-php-ide
- https://github.com/jessarcher/dotfiles
- https://github.com/ThePrimeagen/init.lua

## Cheat Sheet

### How Do I?

- Split the screen vertically?
- Split the screen horizontally?
- Pin a file with Harpoon?

### General Usage

> 🔰 = vim leader (space)
> 💠 = tmux leader (<C-b>)

Vim
- `🔰-df` show file tree
- `:new` create a new buffer pane
- `:%s/find/replace/gc` find and replace content
- `=` to format a selection

Telescope
- `<C-f>` search files with Telescope
- `ESC` to move focus to results window

Tmux (~/dotfiles/tmux/tmux.conf)
- `💠-:` enter tmux command mode
- `tmux` enter the current tmux server
- `💠-d` detach from the current server
- `💠-s` show open sessions
- `💠-w` show open windows
- `💠-f` create new session from directory
- `💠-c` create a new window
- `<C-d>` or `exit` kill the current process, closing then open window session
- `💠-[tab#]` select a specific window session
- `💠-%` split screen horizontally
- `💠-arrow` to move between open window panes
- `💠-x` close the current pane

