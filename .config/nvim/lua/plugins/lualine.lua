return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require("lualine").setup({
            options = {
                theme = "auto",
                -- component_separators = {
                --     right = "",
                --     left = ""
                -- },
            },
            sections = {
                lualine_c = {
                    "filename",
                    {
                        require("noice").api.status.mode.get,
                        cond = require("noice").api.status.mode.has,
                        color = { fg = "#ff9e64" },
                    }
                },
            }
        })
    end
}
