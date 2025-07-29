return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {
                    "lua",        -- Lua
                    "typescript", -- TypeScript
                    "javascript", -- JavaScript
                    "tsx",
                    "bash",       -- Bash
                    "json",       -- JSON
                    "html",       -- HTML
                    "css",        -- CSS
                    "yaml",       -- YAML
                    "markdown",   -- Markdown
                    "markdown_inline",
                    "python",
                    "bash", -- Bash
                    "c",
                    "cpp",
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
                    "elixir",
                    "heex",
                    "dockerfile",
                    "gitignore",
                },
                highlight = {
                    enable = true,
                },
                indent = { enable = true },
                autotag = { enable = true },
            })
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        lazy = true,
        event = "BufReadPost",
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require("nvim-treesitter.configs").setup {
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- 自動跳至下一個符合的 textobject
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]f"] = "@function.outer",
                            ["]c"] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[f"] = "@function.outer",
                            ["[c"] = "@class.outer",
                        },
                    },
                },
            }
        end,
    },
}
