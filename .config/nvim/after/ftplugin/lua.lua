-- Attach Tree-sitter highlighting for lua buffers
local bufnr = vim.api.nvim_get_current_buf()
vim.treesitter.start(bufnr, "lua")
