return {
    "lervag/vimtex",
    config = function()
        vim.cmd("syntax enable")
        vim.cmd("let g:vimtex_view_method='sioyek'")
        vim.cmd("let g:vimtex_quickfix_mode=1")
        vim.cmd("let g:vimtex_syntax_conceal={'math_super_sub': 0}")
        vim.cmd("set conceallevel=2")
        vim.cmd("hi! clear Conceal")
        vim.cmd("set textwidth=80")
    end,
}
