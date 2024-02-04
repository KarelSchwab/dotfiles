return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() 
        local builtin = require("telescope.builtin")
        local opts = { noremap = true, silent = true }
        local map = vim.keymap.set

        map("n", "<leader>gf", builtin.git_files, opts)
        map("n", "<leader>ff", builtin.find_files, opts)
        map("n", "<leader>lg", builtin.live_grep, opts)
        map("n", "<leader>q", builtin.quickfix, opts)

        -- Telescope LSP Mappings
        map("n", "gr", builtin.lsp_references, opts)
        map("n", "gs", builtin.lsp_document_symbols, opts)
    end,
    sorting_strategy = "ascending",
    windblend = 10,
}
