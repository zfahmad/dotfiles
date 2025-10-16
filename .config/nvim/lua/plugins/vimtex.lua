return {
    "lervag/vimtex",
    config = function()
        vim.cmd("syntax enable")
        vim.cmd("let g:vimtex_view_method='sioyek'")
        vim.cmd("let g:vimtex_quickfix_mode=1")
        vim.cmd("set conceallevel=2")
        vim.cmd("set textwidth=80")
        vim.cmd("let g:vimtex_complete_enabled=1")
        vim.cmd("let g:vimtex_view_sioyek_options='--reuse-window'")
        -- vim.cmd("let g:vimtex_compiler_latexmk={ 'options': [ '--shell-escape'], }")
        vim.g.vimtex_compiler_latexmk = {
            backend = "jobs",
            build_dir = "",
            options = {
                "-pdflatex=lualatex --synctex=1 --interaction=nonstopmode",
                "-file-line-error",
                "-interaction=nonstopmode",
                "-synctex=1",
                "-shell-escape",
            },
        }
    end,
}
