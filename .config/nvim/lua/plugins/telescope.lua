return {
    'nvim-telescope/telescope.nvim',
    tag = "0.1.8",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            pickers = {
                find_files = {
                    theme = "dropdown",
                },
                live_grep = {
                    theme = "dropdown",
                },
                buffers = {
                    theme = "dropdown",
                    mappings = {
                        i = {
                            ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
                        }
                    },
                },
                help_tags = {
                    theme = "dropdown",
                },
                grep_string = {
                    theme = "dropdown",
                },
            },
        })
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
