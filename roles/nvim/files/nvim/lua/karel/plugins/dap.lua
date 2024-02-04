return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "mfussenegger/nvim-dap-python",
        "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
        local opts = { noremap = true, silent = true }
        local map = vim.keymap.set

        require("nvim-dap-virtual-text").setup()
        require("dap-python").setup("~/.virtualenvs/debugpy/bin/python3")

        local dap, dapui = require("dap"), require("dapui")

        dap.adapters.cppdbg = {
            id = 'cppdbg',
            type = 'executable',
            command = '/home/karel/.local/bin/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
        }

        dap.configurations.cpp = {
            {
                name = 'Launch',
                type = 'cppdbg',
                request = 'launch',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},
                env = function()
                    local variables = {}
                    for k, v in pairs(vim.fn.environ()) do
                        table.insert(variables, string.format('%s=%s', k, v))
                    end
                    return variables
                end,
                -- externalConsole = true,
                MIMode = 'gdb',
                setupCommands = {
                    {
                        description = 'Enable pretty-printing for gdb',
                        text = '-enable-pretty-printing',
                        ignoreFailures = true,
                    },
                },
            },
            {
                name = 'Attach to gdbserver :1234',
                type = 'cppdbg',
                request = 'launch',
                MIMode = 'gdb',
                miDebuggerServerAddress = 'localhost:1234',
                miDebuggerPath = '/usr/bin/gdb',
                cwd = '${workspaceFolder}',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
            },
        }

        dap.configurations.rust = {
            {
                initCommands = function()
                    -- Find out where to look for the pretty printer Python module
                    local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

                    local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
                    local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

                    local commands = {}
                    local file = io.open(commands_file, 'r')

                    if file then
                        for line in file:lines() do
                            table.insert(commands, line)
                        end
                        file:close()
                    end

                    table.insert(commands, 1, script_import)

                    return commands
                end,
            }
        }

        dapui.setup()

        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()
        end

        map("n", "<leader>b", dap.toggle_breakpoint, opts)

        map("n", "<F5>", dap.continue, opts)
        map("n", "<F8>", dap.step_into, opts)
        map("n", "<F9>", dap.step_over, opts)
        map("n", "<F10>", dap.step_out, opts)
    end
}
