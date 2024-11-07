return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "clangd",
                    "jsonls",
                    "bashls",
                    "vimls",
                    "texlab",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]])
            vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]])

            local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
            function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
                opts = opts or {}
                opts.border = opts.border or "rounded"
                return orig_util_open_floating_preview(contents, syntax, opts, ...)
            end

            local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            vim.diagnostic.config({
                virtual_text = true,
                float = {
                    header = false,
                    border = "rounded",
                    focusable = true,
                },
            })

            -- Mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            local handlers = vim.lsp.handlers
            local pop_opts = { border = "rounded" } --, max_width = 80 }
            handlers["textDocument/hover"] = vim.lsp.with(handlers.hover, pop_opts)
            handlers["textDocument/signature_help"] = vim.lsp.with(handlers.signature_help, pop_opts)

            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Open float diagnostic" })
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
            vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Location list" })

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = ev.buf })
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", buffer = ev.buf })
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "", buffer = ev.buf })
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
                        { desc = "Go to implementation", buffer = ev.buf })
                    vim.keymap.set("n", "<space>k", vim.lsp.buf.signature_help,
                        { desc = "Signature help", buffer = ev.buf })
                    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder,
                        { desc = "Add workspace folder", buffer = ev.buf })
                    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder,
                        { desc = "Remove workspace folder", buffer = ev.buf })
                    vim.keymap.set("n", "<space>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, { desc = "List workspace folder", buffer = ev.buf })
                    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition,
                        { desc = "Type definition", buffer = ev.buf })
                    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { desc = "Rename", buffer = ev.buf })
                    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action,
                        { desc = "Code actions", buffer = ev.buf })
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references", buffer = ev.buf })
                    vim.keymap.set("n", "<space>f", vim.lsp.buf.format, { desc = "Format file", buffer = ev.buf })
                end,
            })


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
                    handlers = handlers,
                    capabilities = capabilities,
                    -- on_attach = on_attach,
                })
            end
        end,
    },
}
