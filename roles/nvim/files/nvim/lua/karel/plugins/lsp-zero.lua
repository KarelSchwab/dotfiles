return {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
        -- LSP Support
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        -- Autocompletion
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        -- Snippets
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets"
    },
    config = function()
        local lsp_zero = require("lsp-zero")
        local mason = require('mason')
        local mason_lspconfig = require("mason-lspconfig")
        local cmp = require("cmp")

        mason.setup({})

        mason_lspconfig.setup({
            ensure_installed = {
                "lua_ls",
                "clangd",
                "rust_analyzer",
                "tsserver",
                "bashls",
                "dockerls",
                "jsonls",
                "html",
            },
            handlers = {
                lsp_zero.default_setup,
            },
        })

        cmp.setup(
            {
                preselect = "none",
                completion = {
                    completeopt = "menu,menuone,noinsert,noselect"
                },
                settings = {
                    offset_encoding = "utf-8"
                },
                sources = {
                    {name = "nvim_lsp"},
                    {name = "luasnip"},
                    {name = "buffer"}
                },
                mapping = cmp.mapping.preset.insert(
                    {
                        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                        ["<C-f>"] = cmp.mapping.scroll_docs(4),
                        ["<C-Space>"] = cmp.mapping.complete(),
                        ["<C-e>"] = cmp.mapping.abort(),
                        ["<CR>"] = cmp.mapping.confirm({select = true})
                    }
                ),
                formatting = {
                    fields = {"abbr", "kind", "menu"}
                }
            }
        )

        -- `/` cmdline setup
        cmp.setup.cmdline(
            "/",
            {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    {name = "buffer"}
                }
            }
        )

        -- `:` cmdline setup
        cmp.setup.cmdline(
            ":",
            {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources(
                    {
                        {name = "path"},
                        {name = "cmdline"}
                    }
                )
            }
        )

        require("luasnip.loaders.from_vscode").load()
    end,
}

