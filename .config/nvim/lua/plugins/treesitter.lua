return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            highlight = {
                enable = true,
                disable = { "latex", "bib" },
            },
            indent = { enable = true },
            auto_install = true,
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
    },
}
