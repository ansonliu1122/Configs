vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)

-- J/K to move the current line down/up
vim.keymap.set("n", "J", ":m .+1<CR>==", { desc = "move line down", noremap = true, silent = true })
vim.keymap.set("n", "K", ":m .-2<CR>==", { desc = "move line up", noremap = true, silent = true })
vim.keymap.set("v", "J", ":m .+1<CR>==", { desc = "move line down", noremap = true, silent = true })
vim.keymap.set("v", "K", ":m .-2<CR>==", { desc = "move line up", noremap = true, silent = true })

-- Explicitly yank ot paste to system clipboard (highlighted and entire row)
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])
vim.keymap.set({ 'n', 'v' }, '<leader>p', [["+p]])
vim.keymap.set('n', '<leader>P', [["+P]])

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

-- Center the cursor when scrolling
vim.keymap.set("n", "<C-d>", function()
    vim.cmd("normal! <C-d>zz")
end, { noremap = true, silent = true })

vim.keymap.set("n", "<C-u>", function()
    vim.cmd("normal! <C-u>zz")
end, { noremap = true, silent = true })

-- for clearing highlight on search
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "clear search highlights" })

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

if not vim.g.vscode then
    -- Window management
    vim.keymap.set('n', '<leader>v', '<C-w>v', opts)        -- split window vertically
    vim.keymap.set('n', '<leader>h', '<C-w>s', opts)        -- split window horizontally
    vim.keymap.set('n', '<leader>se', '<C-w>=', opts)       -- make split windows equal width & height
    vim.keymap.set('n', '<leader>sx', ':close<CR>', opts)   -- close current split window
    vim.keymap.set('n', '<leader>o', '<cmd>only<CR>', opts) -- close other windows

    -- Navigate between splits
    vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
    vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
    vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
    vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)

    -- Tabs
    vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts)                           -- open new tab
    vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts)                         -- close current tab
    vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts)                             --  go to next tab
    vim.keymap.set('n', '<leader>tp', ':tabp<CR>', { desc = "Close other windows" }) --  go to previous tab

    -- Save file
    vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)

    -- Open terminal
    vim.keymap.set("n", "<C-t>", function()
        vim.cmd("belowright 10split | terminal")
        vim.cmd("startinsert")
    end, { desc = "Open terminal below current window" })
end
