-- Attach Tree-sitter highlighting for bash buffers
local bufnr = vim.api.nvim_get_current_buf()
vim.treesitter.start(bufnr, "markdown")
