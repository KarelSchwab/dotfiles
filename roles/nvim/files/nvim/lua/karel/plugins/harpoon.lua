return {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function ()
        local map = vim.keymap.set
        local opts = { noremap = true, silent = true }

        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")
        local term = require("harpoon.term")

        map("n", "<leader>a", mark.add_file, opts)
        map("n", "<leader>hh", ui.toggle_quick_menu, opts)
        map("n", "<leader>1", function() ui.nav_file(1) end, opts)
        map("n", "<leader>2", function() ui.nav_file(2) end, opts)
        map("n", "<leader>3", function() ui.nav_file(3) end, opts)
        map("n", "<leader>4", function() ui.nav_file(4) end, opts)

        map("n", "<leader>tt", function() term.gotoTerminal(1) end, opts)
        map("n", "<leader>t2", function() term.gotoTerminal(2) end, opts)
    end
}
