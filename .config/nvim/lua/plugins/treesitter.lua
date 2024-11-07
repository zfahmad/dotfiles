return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            highlight = {
                enable = true,
                disable = { "latex", "bib" },
            },
            indent = { enable = true },
            --     ensure_installed = {
            --         "python",
            --         "c",
            --         "cpp",
            --         "clojure",
            --         "vimdoc",
            --         "lua",
            --         "markdown",
            --         "vim",
            --     },
            auto_install = true,
        })
    end,
    dependencies = {
        { "nushell/tree-sitter-nu", build = ":TSUpdate nu" }
    }
}
