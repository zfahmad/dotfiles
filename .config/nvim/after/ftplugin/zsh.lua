-- Attach Tree-sitter highlighting for zsh buffers
local bufnr = vim.api.nvim_get_current_buf()
vim.treesitter.start(bufnr, "zsh")
