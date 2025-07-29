-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.

-- Setup lazy.nvim
local lazy_config = {
    spec = {
        { import = "plugins" }, -- lua/plugins
    },
    install = { colorscheme = { "habamax" } },
    checker = { enabled = true },
}

-- 只有在 Neovim 環境中載入這些插件
if not vim.g.vscode then
    -- Add Neovim specific plugins here
    lazy_config.spec = vim.list_extend(lazy_config.spec, {
        { import = "plugins_for_nvim" }, -- 你的 Neovim 插件目錄
    })
end

-- Load plugins using lazy.nvim
require("lazy").setup(lazy_config)
