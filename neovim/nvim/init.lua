require('config.options')
require('config.keybinds')
require('config.lazy')
vim.g.NVIM_TUI_ENABLE_TRUE_COLOR = 1
vim.opt.clipboard:append("unnamedplus")

-- 判斷是否在 WSL
local function is_wsl()
    local uname = vim.loop.os_uname()
    if uname and uname.release:lower():find("microsoft") then
        return true
    end
    return false
end

if is_wsl() then
    vim.g.clipboard = {
        name = 'xclip',
        copy = {
            ['+'] = 'xclip -selection clipboard',
            ['*'] = 'xclip -selection clipboard',
        },
        paste = {
            ['+'] = 'xclip -selection clipboard -o',
            ['*'] = 'xclip -selection clipboard -o',
        },
    }
else
    vim.g.clipboard = {
        name = 'win32yank',
        copy = {
            ['+'] = 'win32yank.exe -i --crlf',
            ['*'] = 'win32yank.exe -i --crlf',
        },
        paste = {
            ['+'] = 'win32yank.exe -o --lf',
            ['*'] = 'win32yank.exe -o --lf',
        },
    }
end

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local argv = vim.fn.argv()
        if #argv > 0 then
            -- Open Neotree
            vim.defer_fn(function()
                vim.cmd("Neotree show left")
            end, 100)
        end
    end,
})
vim.opt.guicursor = {
    "n-v-c:block", -- normal/visual/cmd 模式為 block
    "i-ci:ver25",  -- insert 模式為垂直線（25%高度）
    "r-cr:hor20",  -- replace 模式為水平線（20%高度）
    "o:hor50",     -- operator pending 模式
    "a:blinkon0",  -- 不閃爍
}
