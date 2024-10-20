{ config, pkgs, ... }: {

  # xdg.configFile."nvim" = {
  #   source = ./lua;
  #   recursive = true;
  # };

  programs = {
    neovim = let
      toLua = str: "lua << EOF\n${str}\nEOF";
      toLuaFile = file: toLua (builtins.readFile file);
    in 
    {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
        
      extraConfig = ''
        ${toLuaFile ./lua/globals.lua}
        ${toLuaFile ./lua/options.lua}
        ${toLuaFile ./lua/keymaps.lua}
        
        colorscheme rose-pine
          
      '';
      # ${toLuaFile ./lua/plugins.lua}     

      # ${toLuaFile ./lua/plugins/rose-pine.lua}   

      # ${toLuaFile ./lua/plugins/barbecue.lua}
      # ${toLuaFile ./lua/plugins/colorizer.lua}
      # ${toLuaFile ./lua/plugins/harpoon.lua}
      # ${toLuaFile ./lua/plugins/lsp-zero.lua}
      # ${toLuaFile ./lua/plugins/lualine.lua}
      # ${toLuaFile ./lua/plugins/telescope.lua}
      # ${toLuaFile ./lua/plugins/treesitter.lua}
      # ${toLuaFile ./lua/plugins/treesj.lua}
      # ${toLuaFile ./lua/plugins/vim-commentary.lua}
      # ${toLuaFile ./lua/plugins/vim-pasta.lua}
      # ${toLuaFile ./lua/plugins/vim-rooter.lua}
      # ${toLuaFile ./lua/plugins/which-key.lua}

      plugins = with pkgs.vimPlugins; [
      #   # vim-heritage
      #   barbecue-nvim
      #   harpoon
      #   lsp-zero-nvim
      #   lualine-nvim
      #   neoscroll-nvim
      #   nvim-autopairs
      #   nvim-colorizer-lua
      #   nvim-treesitter
      #   nvim-treesitter-textobjects
      #   (nvim-treesitter.withAllGrammars)
      #   nvim-ts-context-commentstring
      #   nvim-web-devicons
      #   playground
      #   plenary-nvim
        rose-pine
      #   telescope-fzf-native-nvim
      #   telescope-live-grep-args-nvim
        plenary-nvim
        nvim-web-devicons
        telescope-fzf-native-nvim
        telescope-live-grep-args-nvim
        {
          plugin = telescope-nvim;
          type = "lua";
          config = builtins.readFile ./lua/plugins/telescope.lua;
        }

      #   vim-commentary
      #   vim-eunuch
      #   vim-lastplace
      #   vim-pasta
      #   vim-repeat
      #   vim-rooter
      #   vim-sleuth
      #   vim-surround
      #   vim-tmux-navigator
      #   which-key-nvim
      ];
    };
  };
}
