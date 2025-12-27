return {
    "nvim-telescope/telescope.nvim",
    -- tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",

        "debugloop/telescope-undo.nvim",
        "nvim-telescope/telescope-bibtex.nvim",

        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build",
        },
    },

    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                file_ignore_patterns = { "%.png$" },
            },

            pickers = {
                buffers = {
                    theme = "dropdown",
                    previewer = false,
                    mappings = {
                        i = {
                            ["<C-d>"] = actions.delete_buffer + actions.move_to_top,
                        },
                    },
                },
                help_tags = {
                    theme = "dropdown",
                    previewer = false,
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
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        })

        -- Load extensions safely
        pcall(telescope.load_extension, "undo")
        pcall(telescope.load_extension, "bibtex")
        pcall(telescope.load_extension, "fzf")

        -- which-key mappings
        local wk = require("which-key")
        wk.add({
            { "<leader>f",  group = "Find" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>",     desc = "List buffers" },
            { "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "Find files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>",   desc = "Live grep" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>",   desc = "Search help tags" },
            { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Grep string" },
            { "<leader>fq", "<cmd>Telescope quickfix<cr>",    desc = "Quickfix list" },
            { "<leader>fc", "<cmd>Telescope bibtex<cr>",      desc = "Bibtex list" },
        })
    end,
}
