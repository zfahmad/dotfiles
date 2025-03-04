-- For `plugins/helpview.lua` users.
return {
    "OXY2DEV/helpview.nvim",
    lazy = false,
    config = function()
        require("helpview").setup({
            preview = {
                icon_provider = "devicons",
            },
        })
    end
}
