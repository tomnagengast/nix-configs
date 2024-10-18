{ config, pkgs, ... }: {

  # xdg.configFile."nvim" = {
  #   source = ./config;
  #   recursive = true;
  # };

  programs = {
    neovim = let
      toLua = str: "lua << EOF\n${str}\nEOF";
      toLuaFile = path: toLua (builtins.readFile path);
    in 
    {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraConfig = toLua (builtins.readFile ./lua/user/options.lua);

      plugins = with pkgs.vimPlugins; [
        {
          plugin = treesitter;
          config = toLuaFile ./lua/user/plugins/treesitter.lua;
        }
      ];  
    };
  };
}
