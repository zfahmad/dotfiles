return {
    {
        "nvimtools/none-ls.nvim",
        event = "VeryLazy",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.isort,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.cmake_format.with({
                        extra_args = {
                            "-style=file:" .. vim.fn.expand(".clang-format"),
                        }
                    }),
                    -- null_ls.builtins.diagnostics.textidote,
                    null_ls.builtins.diagnostics.cmake_lint,
                    null_ls.builtins.diagnostics.pylint.with({
                        only_local = true,
                    }),
                    null_ls.builtins.code_actions.gitsigns,
                    null_ls.builtins.formatting.clang_format,
                },
            })
        end,
        requires = { "nvim-lua/plenary.nvim" },
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        config = function()
            require("mason-null-ls").setup({})
        end
    }
}
