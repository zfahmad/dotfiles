-- Attach Tree-sitter highlighting for bash buffers
local bufnr = vim.api.nvim_get_current_buf()
vim.treesitter.start(bufnr, "markdown")

-- vim.opt_local.wrap = true
-- vim.opt_local.linebreak = true
-- vim.opt_local.breakindent = true
-- vim.opt_local.formatoptions:remove("t")

