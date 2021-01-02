# dotfiles
Dotfiles, for easy access on any machine

### Installation

[GNU stow](https://www.gnu.org/software/stow/) is a useful tool for managing
dotfiles.

Download stow and then set up the symlinks with the following:
```
stow -t ~ -R git tmux vim
```

See `stow -h` for an explanation of the flags.
