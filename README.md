# Nix

Resources:
- https://github.com/lnl7/nix-darwin
- https://github.com/nix-community/home-manager
- https://home-manager-options.extranix.com
- https://fasterthanli.me/series/building-a-rust-service-with-nix

Other Nix Configs:
- https://davi.sh/til/nix/nix-macos-setup
- https://github.com/thexyno/nixos-config
- https://github.com/cbrewster/nix-home
- https://github.com/ryantm/dotfiles
- https://github.com/Zabot/nixconfig
- https://github.com/notusknot/dotfiles-nix
- https://github.com/fmoda3/nix-configs
- https://github.com/lhchavez/dotfiles


Install
```sh
# nix-darwin
nix run nix-darwin -- switch --flake .#tom-m1

# home-manager
nix run home-manager -- switch --flake .#tom-vm
```


Rebuild
```sh
# nix-darwin
darwin-rebuild switch --flake .#tom-m1

# home-manager
home-manager switch --flake .#tom-vm
```
