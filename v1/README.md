# Nix

Based on:
- https://davi.sh/til/nix/nix-macos-setup
- https://github.com/thexyno/nixos-config
- https://github.com/ryantm/dotfiles
- https://github.com/notusknot/dotfiles-nix
- https://github.com/fmoda3/nix-configs

Resources:
- https://github.com/lnl7/nix-darwin
- https://github.com/nix-community/home-manager
- https://home-manager-options.extranix.com
- https://fasterthanli.me/series/building-a-rust-service-with-nix


## `nix-darwin`

https://github.com/LnL7/nix-darwin

Install nix-darwin:
```sh
nix run nix-darwin -- switch --flake ~/dotfiles/nix
```

Use nix-darwin:
```sh
darwin-rebuild switch --flake ~/dotfiles/nix
```
