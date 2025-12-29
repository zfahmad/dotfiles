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
                indent = {
                    enabled = true,
                    per_level = 2,
                },
                heading = {
                    width = "block",
                    left_pad = 2,
                    right_pad = 4,
                },
            })
        end,
    },
}
