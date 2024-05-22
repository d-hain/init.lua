return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
            "williamboman/mason.nvim",
        },
        config = function()
            local dap = require("dap")
            local ui = require("dapui")

            require("dapui").setup()

            local codelldb = vim.fn.exepath("codelldb")
            if codelldb ~= "" then
                dap.adapters.codelldb = {
                    type = "server",
                    port = "${port}",
                    executable = {
                        command = codelldb,
                        args = { "--port", "${port}" },
                    }
                }

                dap.configurations.rust = {
                    {
                        name = "Launch file",
                        type = "codelldb", -- Same as the adapter name
                        request = "launch",
                        program = function()
                            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                        end,
                        cwd = "${workspaceFolder}",
                        stopOnEntry = false,
                    },
                }
            end

            -- Evaluate expression under cursor
            vim.keymap.set("n", "<leader>?", function()
                require("dapui").eval(nil, { enter = true })
            end)

            -- Keymaps
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
            vim.keymap.set("n", "<F5>", dap.restart)
            vim.keymap.set("n", "<F9>", dap.step_out)
            vim.keymap.set("n", "<F10>", dap.continue)
            vim.keymap.set("n", "<F11>", dap.step_into)
            vim.keymap.set("n", "<F12>", dap.step_over)

            -- Open and close DAP UI
            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                ui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                ui.close()
            end
        end,
    },
}
