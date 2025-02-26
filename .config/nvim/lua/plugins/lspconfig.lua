return {
    {
        "neovim/nvim-lspconfig",
        config = function()
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
                    require("config.code_action_utils").code_action_listener()
                end,
            })

            vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Open float diagnostic" })
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
            vim.keymap.set("n", "<space>l", vim.diagnostic.setloclist, { desc = "Location list" })

            local on_attach = function(client, bufnr)
                vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = bufnr })
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", buffer = bufnr })
                vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "", buffer = bufnr })
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation", buffer = bufnr })
                vim.keymap.set("n", "<space>k", vim.lsp.buf.signature_help, { desc = "Signature help", buffer = bufnr })
                vim.keymap.set(
                    "n",
                    "<space>wa",
                    vim.lsp.buf.add_workspace_folder,
                    { desc = "Add workspace folder", buffer = bufnr }
                )
                vim.keymap.set(
                    "n",
                    "<space>wr",
                    vim.lsp.buf.remove_workspace_folder,
                    { desc = "Remove workspace folder", buffer = bufnr }
                )
                vim.keymap.set("n", "<space>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, { desc = "List workspace folder", buffer = bufnr })
                vim.keymap.set(
                    "n",
                    "<space>D",
                    vim.lsp.buf.type_definition,
                    { desc = "Type definition", buffer = bufnr }
                )
                vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { desc = "Rename", buffer = bufnr })
                vim.keymap.set(
                    { "n", "v" },
                    "<space>ca",
                    vim.lsp.buf.code_action,
                    { desc = "Code actions", buffer = bufnr }
                )
                vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references", buffer = bufnr })
                vim.keymap.set("n", "<space>f", vim.lsp.buf.format, { desc = "Format file", buffer = bufnr })
                client.server_capabilities.document_formatting = true

                if client.server_capabilities.documentHighlightProvider then
                    vim.cmd([[
                        hi! LspReferenceRead cterm=bold ctermbg=Gray guibg=Gray
                        hi! LspReferenceText cterm=bold ctermbg=Gray guibg=Gray
                        hi! LspReferenceWrite cterm=bold ctermbg=Gray guibg=Gray
                        ]])
                    vim.api.nvim_create_augroup("lsp_document_highlight", {
                        clear = false,
                    })
                    vim.api.nvim_clear_autocmds({
                        buffer = bufnr,
                        group = "lsp_document_highlight",
                    })
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        group = "lsp_document_highlight",
                        buffer = bufnr,
                        callback = vim.lsp.buf.document_highlight,
                    })
                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        group = "lsp_document_highlight",
                        buffer = bufnr,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
            end

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local servers = {
                -- "lua_ls",
                "pyright",
                "jsonls",
                "bashls",
                "vimls",
                "texlab",
                "cmake",
                "markdown",
            }

            for _, lsp in pairs(servers) do
                require("lspconfig")[lsp].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end
            require("lspconfig").clangd.setup({
                cmd = {
                    "clangd",
                    "--fallback-style=webkit",
                    "--offset-encoding=utf-16",
                },
                capabilities = capabilities,
                on_attach = on_attach,
            })
            require("lspconfig").lua_ls.setup({

                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if
                            path ~= vim.fn.stdpath("config")
                            and (vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc"))
                        then
                            return
                        end
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                        runtime = {
                            -- Tell the language server which version of Lua you're using
                            -- (most likely LuaJIT in the case of Neovim)
                            version = "LuaJIT",
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME,
                                -- Depending on the usage, you might want to add additional paths here.
                                -- "${3rd}/luv/library"
                                -- "${3rd}/busted/library",
                            },
                            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                            -- library = vim.api.nvim_get_runtime_file("", true)
                        },
                    })
                end,
                settings = {
                    Lua = {},
                },
                capabilities = capabilities,
                on_attach = on_attach,
            })
        end,
    },
}
