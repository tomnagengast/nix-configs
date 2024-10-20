-- Bootstrap Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Color scheme
    { import = 'plugins.rose-pine' },

    -- Useful commands like :Rename and :SudoWrite
    { 'tpope/vim-eunuch' },

    -- Git commands.
    -- { 'tpope/vim-fugitive', dependencies = 'tpope/vim-rhubarb' },

    -- Indent autodetection with editorconfig support
    { 'tpope/vim-sleuth' },

    -- Add, change, and delete surrounding text
    { 'tpope/vim-surround' },

    -- Allow plugins to enable repeating of commands
    { 'tpope/vim-repeat' },

    -- Navigate seamlessly between Vim windows and Tmux panes
    { 'christoomey/vim-tmux-navigator' },

    -- Jump to the last location when opening a file
    { 'farmergreg/vim-lastplace' },

    -- Automatically create parent dirs when saving
    { 'jessarcher/vim-heritage' },

    -- Automatically add closing brackets, quotes, etc
    { 'windwp/nvim-autopairs', config = true },

    -- Add smooth scrolling to avoid jarring jumps
    { 'karb94/neoscroll.nvim', config = true },

    -- Cursor for vim
    { import = 'plugins.avante' },

    -- Show file and LSP context in a bar at the top of the screen
    { import = 'plugins.barbecue' },

    -- Colorize Hex Codes
    { import = 'plugins.colorizer' },

    -- GitHub Copilot
    { import = 'plugins.copilot' },

    -- Quick file navigation
    { import = 'plugins.harpoon' },

    -- LSP support
    { import = 'plugins.lsp-zero' },

    -- A Status line.
    { import = 'plugins.lualine' },

    -- Fuzzy finder
    { import = 'plugins.telescope' },

    -- Improved syntax highlighting
    { import = 'plugins.treesitter' },

    -- Split arrays and methods onto multiple lines, or join them back up
    { import = 'plugins.treesj' },

    -- Commenting support
    { import = 'plugins.vim-commentary' },

    -- Automatically fix indentation when pasting code
    { import = 'plugins.vim-pasta' },

    -- Automatically set the working directory to the project root
    { import = 'plugins.vim-rooter' },
    
    { import = 'plugins.which-key' },

}, {
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
