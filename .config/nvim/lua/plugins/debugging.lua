return {
    -- Core DAP plugin
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            -- Optional: UI and virtual text
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function()
            local dap = require("dap")

            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
            }

            -- Example Python adapter (adjust for your language)
            -- dap.adapters.python = {
            --     type = "executable",
            --     command = "python",
            --     args = { "-m", "debugpy.adapter" },
            -- }
            --
            -- dap.configurations.python = {
            --     {
            --         type = "python",
            --         request = "launch",
            --         name = "Launch file",
            --         program = "${file}",
            --     },
            -- }
            dap.configurations.c = {
                {
                    name = "Launch",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    args = {}, -- provide arguments if needed
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = false,
                },
                {
                    name = "Select and attach to process",
                    type = "gdb",
                    request = "attach",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    pid = function()
                        local name = vim.fn.input("Executable name (filter): ")
                        return require("dap.utils").pick_process({ filter = name })
                    end,
                    cwd = "${workspaceFolder}",
                },
                {
                    name = "Attach to gdbserver :1234",
                    type = "gdb",
                    request = "attach",
                    target = "localhost:1234",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                },
            }
            dap.configurations.cpp = dap.configurations.c

            -- Keymaps for debugging
            vim.keymap.set("n", "<leader>ds", function()
                dap.continue()
            end, { desc = "DAP Continue" })
            vim.keymap.set("n", "<F10>", function()
                dap.step_over()
            end, { desc = "DAP Step Over" })
            vim.keymap.set("n", "<F11>", function()
                dap.step_into()
            end, { desc = "DAP Step Into" })
            vim.keymap.set("n", "<F12>", function()
                dap.step_out()
            end, { desc = "DAP Step Out" })
            vim.keymap.set("n", "<leader>db", function()
                dap.toggle_breakpoint()
            end, { desc = "DAP Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>dB", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "DAP Conditional Breakpoint" })
            vim.keymap.set("n", "<leader>dr", function()
                dap.repl.toggle()
            end, { desc = "DAP Toggle REPL" })
            vim.keymap.set("n", "<leader>dl", function()
                dap.run_last()
            end, { desc = "DAP Run Last" })
        end,
    },

    -- UI for nvim-dap
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup({
                controls = { enabled = true },
                floating = { border = "rounded" },
                layouts = {
                    {
                        elements = {
                            { id = "scopes", size = 0.3 },
                            { id = "breakpoints", size = 0.2 },
                            { id = "stacks", size = 0.3 },
                            { id = "watches", size = 0.2 },
                        },
                        size = 0.33,
                        position = "left",
                    },
                    {
                        elements = { "repl", "console" },
                        size = 0.27,
                        position = "bottom",
                    },
                },
            })

            vim.api.nvim_set_hl(0, "blue", { fg = "#3d59a1" })
            local dap_breakpoint = {
                error = {
                    text = "",
                    texthl = "LspDiagnosticsSignError",
                    linehl = "",
                    numhl = "",
                },
                cond = {
                    text = "",
                    texthl = "LspDiagnosticsSignError",
                    linehl = "",
                    numhl = "",
                },
                rejected = {
                    text = "",
                    texthl = "LspDiagnosticsSignHint",
                    linehl = "",
                    numhl = "",
                },
                stopped = {
                    text = "󰜴",
                    texthl = "LspDiagnosticsSignInformation",
                    linehl = "DiagnosticUnderlineInfo",
                    numhl = "LspDiagnosticsSignInformation",
                },
            }

            vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
            vim.fn.sign_define("DapBreakpointCondition", dap_breakpoint.cond)
            vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
            vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

            -- Automatically open/close dap-ui
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- Optional keymaps
            vim.keymap.set("n", "<leader>du", function()
                dapui.toggle()
            end, { desc = "DAP UI Toggle" })
            vim.keymap.set("n", "<leader>dh", function()
                dapui.eval()
            end, { desc = "DAP Hover Evaluate" })
        end,
    },

    {
        "mfussenegger/nvim-dap-python",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
        },
        config = function()
            require("dap-python").setup("python3")
        end,
    },
    -- Inline virtual text (optional)
    {
        "theHamsta/nvim-dap-virtual-text",
        opts = {
            commented = true,
            virt_text_pos = "eol",
        },
    },
}
