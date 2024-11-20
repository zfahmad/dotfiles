return {
    "folke/trouble.nvim",
    opts = { },
    cmd = "Trouble",
    -- local wk = require("which-key")
    -- wk.add({
    --     {
    --         { "<leader>t",  group = "Trouble",                                  nowait = false,                        remap = false, },
    --         { "<leader>tr", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics (Trouble)",        nowait = false, remap = false },
    --         { "<leader>tR", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)", nowait = false, remap = false },
    --         { "<leader>tl", "<cmd>Trouble loclist toggle<cr>",                  desc = "Location List (Trouble)",      nowait = false, remap = false },
    --         { "<leader>tq", "<cmd>Trouble qflist toggle<cr>",                   desc = "Quickfix List (Trouble)",      nowait = false, remap = false },
    --     }
    -- })
    keys = {
        {
            "<leader>tr",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>tR",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>tl",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>tq",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
    },
}
