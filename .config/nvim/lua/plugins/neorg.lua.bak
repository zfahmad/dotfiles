return {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    dependencies = { { "nvim-neorg/neorg-telescope" } },
    config = function()
        require("neorg").setup({
            load = {
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                    },
                },
                ["core.syntax"] = {},
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.concealer"] = {
                    config = {
                        icon_preset = "varied",
                        conceals = {
                            delimiters = true,
                        },
                    },
                }, -- Adds pretty icons to your documents
                ["core.dirman"] = { -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            notes = "~/Documents/notes",
                        },
                        default_workspace = "notes",
                    },
                },
                ["core.integrations.telescope"] = {},
                -- ["core.integrations.nvim-cmp"] = {},
                ["core.export"] = {},
            },
        })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "norg",
            callback = function()
                vim.b.vimtex_filetype = "tex" -- Treat buffer as LaTeX
                vim.cmd("syntax include @tex syntax/tex.vim") -- Include LaTeX syntax
                vim.cmd("syntax region texMath start='\\$' end='\\$' contains=@tex keepend concealends") -- Conceal inline math
                vim.cmd("syntax region texMath start='\\$\\$' end='\\$\\$' contains=@tex keepend concealends") -- Conceal display math
                vim.cmd("syntax region texMathBlock start='@math' end='@end' contains=@tex keepend concealends") -- Conceal display math
                vim.cmd("call vimtex#init()") -- Initialize VimTeX
            end,
        })
    end,
}
