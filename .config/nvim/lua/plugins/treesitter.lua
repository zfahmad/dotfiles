return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = {
        highlight = {
            enable = true,
            disable = { "latex", "bib" },
        },
        --     indent = { enable = true },
        --     auto_install = true,
        ensure_installed = {
            "python",
            --         "norg",
            --         -- highlight = { enable = true,}
        },
    },
}
