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
                bullet = {
                    icons = { "‣", "•", "⁃", "◦", "◆", "◇" },
                },
                indent = {
                    enabled = true,
                    per_level = 2,
                },
                heading = {
                    width = "block",
                    left_pad = 2,
                    right_pad = 4,
                },
                latex = {
                    enabled = true, -- Set to false if you only want VimTeX's conceal
                    converter = "latex2text", -- Requires 'utftex' or 'latex2text' installed
                    -- highlight = "RenderMarkdownMath",
                    -- position = "below", -- Options: 'above', 'below', 'center'
                },
                highlight = {
                    enabled = true,
                },
            })
        end,
    },
}
