return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
        "neovim/nvim-lspconfig", -- Required

        -- Autocomplete
        "hrsh7th/nvim-cmp", -- Required
        "hrsh7th/cmp-nvim-lsp", -- Required
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "saadparwaiz1/cmp_luasnip",

        -- Snippets
        "L3MON4D3/LuaSnip", -- Required
        "rafamadriz/friendly-snippets",
    },
    config = function()
        local lsp = require('lsp-zero')

        local lspconfig_defaults = require('lspconfig').util.default_config
        lspconfig_defaults.capabilities = vim.tbl_deep_extend(
            'force',
            lspconfig_defaults.capabilities,
            require('cmp_nvim_lsp').default_capabilities()
        )

        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
              local opts = {buffer = event.buf}

              vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
              vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
              vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
              vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
              vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
              vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
              vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
              vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
              vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
              vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
            end,
        })

        require('lspconfig').lua_ls.setup({})
        require('lspconfig').gopls.setup({})

        local cmp = require('cmp')

        cmp.setup({
            sources = {
                {name = 'nvim_lsp'},
            },
            snippet = {
                expand = function(args)
                -- You need Neovim v0.10 to use vim.snippet
                vim.snippet.expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({}),
        })

        lsp.setup()
    end
}
