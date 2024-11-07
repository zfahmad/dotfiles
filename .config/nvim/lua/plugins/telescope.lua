return {
    'nvim-telescope/telescope.nvim',
    tag = "0.1.5",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local wk = require("which-key")
        wk.add({
            {
                { "<leader>f",  group = "Find" },
                { "<leader>fb", "<cmd>Telescope buffers<cr>",     desc = "List buffers" },
                { "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "Find files" },
                { "<leader>fg", "<cmd>Telescope live_grep<cr>",   desc = "Live grep" },
                { "<leader>fh", "<cmd>Telescope help_tags<cr>",   desc = "Search help tags" },
                { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Grep string" },
            }
        })
    end
}
