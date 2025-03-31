--lua/code_action_utils.lua
local M = {}

local lsp_util = vim.lsp.util

function M.code_action_listener()
  local context = { diagnostics = vim.diagnostic.get() }
  local params = lsp_util.make_range_params(0, "utf-8")
  params.context = context
  vim.lsp.buf_request(0, 'textDocument/codeAction', params, function(err, result, ctx, config)
    -- do something with result - e.g. check if empty and show some indication such as a sign
  end)
end

return M
