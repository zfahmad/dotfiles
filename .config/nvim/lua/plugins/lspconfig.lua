return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            -- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
            -- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            --     opts = opts or {}
            --     opts.border = opts.border or "double"
            --     return orig_util_open_floating_preview(contents, syntax, opts, ...)
            -- end

            -- Changing gutter signs for diagnostics
            local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            vim.diagnostic.config({
                virtual_text = true,
                float = {
                    border = "rounded",
                    focusable = true,
                },
            })

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                group = vim.api.nvim_create_augroup(".code_action_sign", { clear = true }),
                callback = function()
                    require('config.code_action_utils').code_action_listener()
                end,
            })

            vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Open float diagnostic" })
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
            vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Location list" })

            local on_attach = function(client, bufnr)
                vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })

                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = bufnr })
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", buffer = bufnr })
                vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "", buffer = bufnr })
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
                    { desc = "Go to implementation", buffer = bufnr })
                vim.keymap.set("n", "<space>k", vim.lsp.buf.signature_help,
                    { desc = "Signature help", buffer = bufnr })
                vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder,
                    { desc = "Add workspace folder", buffer = bufnr })
                vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder,
                    { desc = "Remove workspace folder", buffer = bufnr })
                vim.keymap.set("n", "<space>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
                    { desc = "List workspace folder", buffer = bufnr })
                vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition,
                    { desc = "Type definition", buffer = bufnr })
                vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { desc = "Rename", buffer = bufnr })
                vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action,
                    { desc = "Code actions", buffer = bufnr })
                vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references", buffer = bufnr })
                vim.keymap.set("n", "<space>f", vim.lsp.buf.format, { desc = "Format file", buffer = bufnr })
                client.server_capabilities.document_formatting = true

                if client.server_capabilities.documentHighlightProvider then
                    vim.cmd [[
                        hi! LspReferenceRead cterm=bold ctermbg=Gray guibg=Gray
                        hi! LspReferenceText cterm=bold ctermbg=Gray guibg=Gray
                        hi! LspReferenceWrite cterm=bold ctermbg=Gray guibg=Gray
                    ]]
                    vim.api.nvim_create_augroup('lsp_document_highlight', {
                        clear = false
                    })
                    vim.api.nvim_clear_autocmds({
                        buffer = bufnr,
                        group = 'lsp_document_highlight',
                    })
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        group = 'lsp_document_highlight',
                        buffer = bufnr,
                        callback = vim.lsp.buf.document_highlight,
                    })
                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        group = 'lsp_document_highlight',
                        buffer = bufnr,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
            end

            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local servers = {
                "lua_ls",
                "pyright",
                "clangd",
                "jsonls",
                "bashls",
                "vimls",
                "texlab",
            }

            for _, lsp in pairs(servers) do
                require("lspconfig")[lsp].setup({
                    -- handlers = handlers,
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end
        end,
    },
}
