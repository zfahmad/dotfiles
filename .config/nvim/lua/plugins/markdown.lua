return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    config = function()
    require('render-markdown').setup({
            -- heading = {
            --     width = 'block',
            --     left_pad = 1,
            --     right_pad = 1,
            -- },
            indent = { enabled = true },
    })
    end,
}
