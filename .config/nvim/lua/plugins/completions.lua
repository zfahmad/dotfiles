return {
    "hrsh7th/nvim-cmp",
    dependencies = { "xzbdmw/colorful-menu.nvim" },
    config = function()
        local cmp = require("cmp")
        require("luasnip.loaders.from_vscode").lazy_load()
        local kind_icons = {
            Text = "",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰇽",
            Variable = "󰂡",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "󰅲",
        }

        cmp.setup({
            ---@diagnostic disable-next-line: missing-fields
            formatting = {
                expandable_indicator = true,
                format = function(entry, vim_item)
                    local highlights_info = require("colorful-menu").cmp_highlights(entry)
                    -- highlight_info is nil means we are missing the ts parser, it's
                    -- better to fallback to use default `vim_item.abbr`. What this plugin
                    -- offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
                    if highlights_info ~= nil then
                        vim_item.abbr_hl_group = highlights_info.highlights
                        vim_item.abbr = highlights_info.text
                    end
                    -- Kind icons
                    vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
                    -- Source
                    vim_item.menu = ({
                        buffer = "[Buffer]",
                        nvim_lsp = "[LSP]",
                        luasnip = "[LuaSnip]",
                        nvim_lua = "[Lua]",
                        latex_symbols = "[LaTeX]",
                    })[entry.source.name]
                    return vim_item
                end,
            },
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                    -- vim.snippet.expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered({
                    winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
                }),
                documentation = cmp.config.window.bordered({
                    winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
                }),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" }, -- For luasnip users.
                { name = "buffer", option = { get_bufnrs = vim.api.nvim_list_bufs } },
                { name = "path" },
                { name = "vimtex", priority = 10 },
                { name = "render-markdown" },
                { name = "neorg" },
                { name = "latex_symbols" },
                { name = "omni", filetypes = { "tex" } },
            }),
        })
        -- autocmd FileType tex setlocal omnifunc=vimtex#complete#omnifunc
    end,
}
