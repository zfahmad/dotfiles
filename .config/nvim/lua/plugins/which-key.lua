return {
    {
        "folke/which-key.nvim",
        dependencies = {
            "echasnovski/mini.nvim"
        },
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            win = {
                border = "double"
            }
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    {
        "echasnovski/mini.nvim",
        config = function()
            require('mini.icons').setup()
        end
    }
}
