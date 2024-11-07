-- [[ opts.lua ]]
local opt = vim.opt

-- [[ Context ]]
opt.number = true                -- bool: Show line numbers
opt.relativenumber = true        -- bool: Show relative line numbers
opt.scrolloff = 12               -- int:  Min num lines of context
opt.signcolumn = "yes"           -- str:  Show the sign column
vim.bo.filetype = "ON"
opt.wrap = false
opt.breakindent = true
opt.foldlevel = 999

-- [[ Filetypes ]]
opt.encoding = 'utf8'            -- str:  String encoding to use
opt.fileencoding = 'utf8'        -- str:  File encoding to use

-- [[ Theme ]]
vim.cmd.colorscheme('gruvbox')
opt.colorcolumn = '80'          -- str:  Show col for max line length
opt.syntax = "ON"                -- str:  Allow syntax highlighting
opt.termguicolors = true         -- bool: If term supports ui color then enable
opt.cursorline =  true
vim.g.cursorline_timeout = '0'
-- vim.g.tex_subscripts = "[0-9aehijklmnoprsuvx,+-/().]"
vim.g.tex_conceal = "abdmg"

-- [[ Search ]]
opt.ignorecase = true            -- bool: Ignore case in search patterns
opt.smartcase = true             -- bool: Override ignorecase if search contains capitals
opt.incsearch = true             -- bool: Use incremental search
opt.hlsearch = true             -- bool: Highlight search matches

-- [[ Whitespace ]]
opt.expandtab = true             -- bool: Use spaces instead of tabs
opt.shiftwidth = 4               -- num:  Size of an indent
opt.softtabstop = 4              -- num:  Number of spaces tabs count for in insert mode
opt.tabstop = 4                  -- num:  Number of spaces tabs count for

-- [[ Splits ]]
opt.splitright = true            -- bool: Place new window to right of current one
opt.splitbelow = true            -- bool: Place new window below the current one

-- [[ Misc ]]
opt.hidden = true
opt.list = true
opt.listchars = {
    tab = " ▶",
    trail = "┈",
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
