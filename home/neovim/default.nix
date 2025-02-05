{ config, lib, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;

    extraPackages = with pkgs; [
      # LazyVim
      lua-language-server
      stylua
      # Go
      gopls
      golangci-lint
      gofumpt
      gotools # includes goimports
      delve  # for debugging
      # Telescope
      ripgrep
    ];

    plugins = with pkgs.vimPlugins; [ lazy-nvim ];

    extraLuaConfig =
      let
        plugins = with pkgs.vimPlugins; [
          barbecue-nvim
          harpoon
          lazy-nvim
          lsp-zero-nvim
          lua_ls
          lualine-nvim
          neoscroll-nvim
          nvim-autopairs
          nvim-colorizer-lua
          nvim-treesitter.withAllGrammars
          nvim-treesitter-context
          nvim-treesitter-textobjects
          nvim-ts-context-commentstring
          nvim-web-devicons
          playground
          plenary-nvim
          rose-pine
          telescope-fzf-native-nvim
          # telescope-live-grep-args-nvim
          telescope-nvim
          which-key-nvim
          # vim-heritage
        ];
        mkEntryFromDrv = drv:
          if lib.isDerivation drv then
            { name = "${lib.getName drv}"; path = drv; }
          else
            drv;
        lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
      in
      ''
        ${builtins.readFile ./lua/globals.lua}
        ${builtins.readFile ./lua/options.lua}
        ${builtins.readFile ./lua/keymaps.lua}
        ${builtins.readFile ./lua/init.lua}
      '';
  };

  # https://github.com/nvim-treesitter/nvim-treesitter#i-get-query-error-invalid-node-type-at-position
  xdg.configFile."nvim/parser".source =
    let
      parsers = pkgs.symlinkJoin {
        name = "treesitter-parsers";
        paths = (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: with plugins; [
          c
          lua
        ])).dependencies;
      };
    in
    "${parsers}/parser";

  # Normal LazyVim config here, see https://github.com/LazyVim/starter/tree/main/lua
  xdg.configFile."nvim/lua".source = ./lua;
}
