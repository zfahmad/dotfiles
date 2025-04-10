return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "debugloop/telescope-undo.nvim",
        "nvim-telescope/telescope-bibtex.nvim",
    },
    config = function()
        local actions = require("telescope.actions")
        require("telescope").load_extension("bibtex")
        require("telescope").setup({
            defaults = {
                file_ignore_patterns = { "**/*.png" },
            },
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
            extensions = {
                undo = {},
                bibtex = {
                    theme = "dropdown",
                    previewer = false,
                },
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
            },
        })
        require("telescope").load_extension("undo")
        require("telescope").load_extension("fzf")
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
                { "<leader>fc", "<cmd>Telescope bibtex<cr>", desc = "Bibtex list" },
                { "<leader>fnf", "<cmd>Telescope neorg find_norg_files<cr>", desc = "Find norg files" },
                { "<leader>fnl", "<cmd>Telescope neorg insert_file_link<cr>", desc = "Find file links" },
                { "<leader>fna", "<cmd>Telescope neorg find_linkable<cr>", desc = "Find all linkables" },
                { "<leader>fnh", "<cmd>Telescope neorg search_headings<cr>", desc = "Find all linkables" },
            },
        })
    end,
}
