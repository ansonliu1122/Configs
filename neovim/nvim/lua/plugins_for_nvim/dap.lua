return {
    'mfussenegger/nvim-dap',
    dependencies = {
        -- Creates a beautiful debugger UI
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        'theHamsta/nvim-dap-virtual-text',

        -- Installs the debug adapters for you
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',

        -- Add your own debuggers here
        'leoluz/nvim-dap-go',
        'mfussenegger/nvim-dap-python',
    },
    config = function()
        require("plugins_for_nvim.dap.configure")
        require("plugins_for_nvim.dap.ui")
        require("plugins_for_nvim.dap.python")
        require("plugins_for_nvim.dap.cpp")
    end,
}
