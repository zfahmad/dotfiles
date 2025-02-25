return {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    dependencies = { { "nvim-neorg/neorg-telescope" }, },
    config = function()
        require('neorg').setup {
            load = {
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                    },
                },
                ["core.syntax"] = {},
                ["core.defaults"] = {},  -- Loads default behaviour
                ["core.concealer"] = {}, -- Adds pretty icons to your documents
                ["core.dirman"] = {      -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            notes = "~/Documents/notes",
                        },
                        default_workspace = "notes",
                    },
                },
                ["core.integrations.telescope"] = {
                    config = {
                        insert_file_link = {
                            show_title_preview = true,
                            theme = "dropdown",
                        },
                    },
                },
            },
        }
    end
}
