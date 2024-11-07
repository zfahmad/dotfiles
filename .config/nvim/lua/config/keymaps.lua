-- [[ keys.lua ]]

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent =true }

map('n', '<Leader>ne', [[:Neotree toggle<CR>]], {})
map('n', '<Leader>ut', [[:UndotreeToggle<CR>]], {})
map('n', '<Leader>m', [[:make<CR>]], {})

map('n', '<M-j>', '<C-w>j', opts)
map('n', '<M-k>', '<C-w>k', opts)
map('n', '<M-h>', '<C-w>h', opts)
map('n', '<M-l>', '<C-w>l', opts)

map('n', '<C-u>', '<C-u>zz', {})
map('n', '<C-d>', '<C-d>zz', {})
map('n', 'n', 'nzz', {})
map('n', 'N', 'Nzz', {})

map('v', 'J', 'xp`[V`]', {})
map('v', 'K', 'xkP`[V`]', {})
