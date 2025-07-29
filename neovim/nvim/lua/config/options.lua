local set = vim.opt

set.number = true
set.relativenumber = true

-- indentation and tabs
set.tabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.autoindent = true

-- search settings
set.ignorecase = true
set.smartcase = true

-- appearance
set.termguicolors = true
set.background = "dark"
set.signcolumn = "yes"
set.cursorline = true

-- faster cursor hold
set.updatetime = 50

vim.g.border_chars = "rounded"

-- using Unix ending format (remove ^M characters)
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
    callback = function()
        -- If \r exists in current buffer
        if vim.fn.search("\r", "nw") ~= 0 then
            pcall(vim.cmd, [[%s/\r//g]])
            print("Removed ^M characters")
        end
    end,
})
