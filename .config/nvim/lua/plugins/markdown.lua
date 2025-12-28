return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
            "lervag/vimtex",
        },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
        config = function()
            require("render-markdown").setup({
                completions = { lsp = { enabled = true } },
                -- checkbox = {
                --     unchecked = { icon = "✘ " },
                --     checked = { icon = "✔ " },
                --     custom = { todo = { rendered = "◯ " } },
                -- },
                heading = {
                    width = "block",
                    left_pad = 2,
                    right_pad = 4,
                },
                -- indent = {
                -- enabled = true,
                -- per_level = 4,
                -- },
                -- latex = {
                --     enabled = true,
                --     win_options = {
                --         conceallevel = { rendered = 2 },
                --         concealcursor = { rendered = "" },
                --     },
                --     converter = "none",
                --     inline = { "$", "$" },
                --     block = { "$$", "$$" },
                -- },
            })
        end,
    },
}
