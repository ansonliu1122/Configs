-- Standalone plugins with less than 10 lines of config go here
return {
    { -- autoclose tags
        'windwp/nvim-ts-autotag',
    },
    { -- detect tabstop and shiftwidth automatically
        'tpope/vim-sleuth',
    },
    { -- Powerful Git integration for Vim
        'tpope/vim-fugitive',
    },
    { -- GitHub integration for vim-fugitive
        'tpope/vim-rhubarb',
    },
    { -- Hints keybinds
        'folke/which-key.nvim',
        opts = {
            win = {
                no_overlap = true,
                border = {
                    { '┌', 'FloatBorder' },
                    { '─', 'FloatBorder' },
                    { '┐', 'FloatBorder' },
                    { '│', 'FloatBorder' },
                    { '┘', 'FloatBorder' },
                    { '─', 'FloatBorder' },
                    { '└', 'FloatBorder' },
                    { '│', 'FloatBorder' },
                },
                height = { min = 4, max = 15 },
            },
        },
    },
    { -- Autoclose parentheses, brackets, quotes, etc.
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
        opts = {},
    },
    { -- Highlight todo, notes, etc in comments
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = false },
    },
    { -- high-performance color highlighter
        'NvChad/nvim-colorizer.lua',
        config = function()
            require("colorizer").setup {
                filetypes = { "*" },
                user_default_options = {
                    names = false, -- 不高亮 CSS 名稱 (like 'red', 'blue')
                },
            }
        end
    },
    { -- This generates docblocks
        'kkoomen/vim-doge',
        build = ':call doge#install()'
    },
    { -- Imporve UI
        "stevearc/dressing.nvim",
        event = "VeryLazy"
    },
    { -- This helps with ssh tunneling and copying to clipboard
        'ojroques/vim-oscyank',
    },
    { -- Git plugin
        'tpope/vim-fugitive',
    },
    { -- Show historical versions of the file locally
        'mbbill/undotree',
    },
}
