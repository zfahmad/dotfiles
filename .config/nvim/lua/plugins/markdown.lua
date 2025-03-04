return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        --        ---@module 'render-markdown'
        --        ---@type render.md.UserConfig
        opts = {},
        config = function()
            require("render-markdown").setup({
                -- heading = {
                --     width = 'block',
                --     left_pad = 1,
                --     right_pad = 1,
                -- },
                indent = {
                    enabled = true,
                    per_level = 4,
                },
                latex = {
                    enabled = false,
                    -- win_options = { conceallevel = { rendered = 2 } },
                },
            })
        end,
    },
}
-- return {
--     "OXY2DEV/markview.nvim",
--     lazy = false,
--     config = function()
--         local presets = require("markview.presets")
--         require("markview").setup({
--             markdown = { headings = presets.headings.glow }
--         })
--     end,
-- }
