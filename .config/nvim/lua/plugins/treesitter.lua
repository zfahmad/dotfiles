return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                highlight = {
                    enable = true,
                    disable = { "latex", "bib" },
                },
                indent = { enable = true },
                auto_install = true,
                refactor = {
                    highlight_definitions = {
                        enable = true,
                        clear_on_cursor_move = true,
                    },
                }
            })
        end,
        dependencies = {
            { "nushell/tree-sitter-nu", build = ":TSUpdate nu" },
        }
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        requires = "nvim-treesitter/nvim-treesitter"
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
    },
    {
        "nvim-treesitter/nvim-treesitter-refactor",
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                refactor = {
                    highlight_definitions = {
                        enable = true,
                        clear_on_cursor_move = true,
                    },
                }
            })
        end,
    }
}
