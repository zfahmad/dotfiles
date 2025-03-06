return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({})
        local wk = require("which-key")
        wk.add({
            {
                "<leader>ne",
                "<cmd>Neotree toggle<cr>",
                desc = "List buffers",
            },
        })
    end,
}
