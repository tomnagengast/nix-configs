require("lazy").setup({
    defaults = {
        lazy = true,
    },
    dev = {
        -- reuse files from pkgs.vimPlugins.*
        path = "${lazyPath}",
        patterns = { "." },
        -- fallback to download
        fallback = true,
    },
    spec = {
        -- The following configs are needed for fixing lazyvim on nix
        -- force enable telescope-fzf-native.nvim
        { "nvim-telescope/telescope-fzf-native.nvim", enabled = true },
        -- disable mason.nvim, use programs.neovim.extraPackages
        { "williamboman/mason-lspconfig.nvim", enabled = false },
        { "williamboman/mason.nvim", enabled = false },
        -- import/override with your plugins
        { import = "plugins" },
        -- treesitter handled by xdg.configFile."nvim/parser", put this line at the end of spec to clear ensure_installed
        { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = {} } },
    },
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = false,
    },
    install = {
        colorscheme = { "rose-pine" },
    },
})
