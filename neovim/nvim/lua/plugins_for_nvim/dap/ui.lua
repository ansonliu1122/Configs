local dap, dapui = require("dap"), require("dapui")

dapui.setup({
    expand_lines = true,
    icons = { expanded = "", collapsed = "", circular = "" },
    mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    layouts = {
        {
            elements = {
                { id = "scopes",  size = 0.50 },
                { id = "stacks",  size = 0.20 },
                { id = "watches", size = 0.30 },
            },
            size = 0.33,
            position = "left",
        },
        {
            elements = {
                { id = "repl",    size = 0.30 },
                { id = "console", size = 0.70 },
            },
            size = 0.27,
            position = "bottom",
        },
    },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
end
