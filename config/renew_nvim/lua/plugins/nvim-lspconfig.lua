return {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp',
        { "williamboman/mason.nvim",
        config = function() require("mason").setup() end
    },
        { "williamboman/mason-lspconfig.nvim", config = function() end },
    },
    opts = {
        servers = {
            lua_ls = {},
            ts_ls = {}
        },
        ---@type vim.diagnostic.Opts
        diagnostics = {
            underline = false,
            update_in_insert = false,
            virtual_text = {
                spacing = 4,
                source = "if_many",
                prefix = "●",
            },
            severity_sort = true,
        },
        --      inlay_hints = {
        --   enabled = true,
        --   exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
        -- },
        capabilities = {
            workspace = {
                fileOperations = {
                    didRename = true,
                    willRename = true,
                },
            },
        },
    },
    config = function(_, opts)
        local lspconfig = require('lspconfig')
        for server, config in pairs(opts.servers) do
            config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
            lspconfig[server].setup(config)
        end
    end,
}
