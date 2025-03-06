return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            pickers = {
                find_files = {
                    -- theme = "dropdown",
                },
                live_grep = {
                    -- theme = "dropdown",
                },
                buffers = {
                    theme = "dropdown",
                    mappings = {
                        i = {
                            ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
                        },
                    },
                    previewer = false,
                },
                help_tags = {
                    theme = "dropdown",
                    previewer = false,
                },
                grep_string = {
                    -- theme = "dropdown",
                },
                quickfix = {
                    theme = "dropdown",
                },
            },
        })
        local wk = require("which-key")
        wk.add({
            {
                { "<leader>f", group = "Find" },
                { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "List buffers" },
                { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
                { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
                { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Search help tags" },
                { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Grep string" },
                { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix list" },
                { "<leader>fnf", "<cmd>Telescope neorg find_norg_files<cr>", desc = "Find norg files" },
                { "<leader>fnl", "<cmd>Telescope neorg insert_file_link<cr>", desc = "Find file links" },
                { "<leader>fna", "<cmd>Telescope neorg find_linkable<cr>", desc = "Find all linkables" },
                { "<leader>fnh", "<cmd>Telescope neorg search_headings<cr>", desc = "Find all linkables" },
            },
        })
    end,
}
