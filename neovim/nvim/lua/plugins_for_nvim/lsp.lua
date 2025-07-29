return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        -- Snippets
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
    },
    config = function()
        local autoformat_filetypes = {
            "lua", "python", "javascript", "typescript", "typescriptreact", "javascriptreact",
            "json", "yaml", "html", "css", "scss", "markdown", "bash", "sh", "c", "cpp",
            "rust", "toml", "dockerfile", "xml"
        }

        -- Configure diagnostics appearance
        vim.diagnostic.config({
            update_in_insert = false,
            virtual_text = true,
            severity_sort = true,
            signs = true,
            underline = true,
            float = {
                style = 'minimal',
                border = 'rounded',
                header = '',
                prefix = '',
            },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = '✘',
                    [vim.diagnostic.severity.WARN] = '▲',
                    [vim.diagnostic.severity.HINT] = '⚑',
                    [vim.diagnostic.severity.INFO] = '»',
                },
            },
        })

        -- Add cmp_nvim_lsp capabilities to lspconfig
        local lspconfig_defaults = require('lspconfig').util.default_config
        lspconfig_defaults.capabilities = vim.tbl_deep_extend(
            'force',
            lspconfig_defaults.capabilities,
            require('cmp_nvim_lsp').default_capabilities()
        )

        -- LSP attach autocommand - keymaps and features
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(event)
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if not client then return end

                local opts = { buffer = event.buf }

                -- Keymaps
                vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
                vim.keymap.set('n', 'rn', vim.lsp.buf.rename, opts)
                vim.keymap.set({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format({ async = true }) end, opts)
                vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)

                -- Document highlighting
                if client:supports_method('textDocument/documentHighlight') then
                    vim.api.nvim_create_autocmd('CursorHold', {
                        buffer = event.buf,
                        callback = vim.lsp.buf.document_highlight,
                    })
                    vim.api.nvim_create_autocmd('CursorMoved', {
                        buffer = event.buf,
                        callback = vim.lsp.buf.clear_references,
                    })
                end

                -- Auto-formatting on save
                if vim.tbl_contains(autoformat_filetypes, vim.bo[event.buf].filetype) then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = event.buf,
                        callback = function()
                            vim.lsp.buf.format({
                                formatting_options = { tabSize = 4, insertSpaces = true },
                                bufnr = event.buf,
                                id = client.id
                            })
                        end
                    })
                end
            end
        })

        -- Mason setup
        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {
                "lua_ls", "ts_ls", "eslint", "html", "cssls", "jsonls", "yamlls",
                "bashls", "marksman", "pyright", "clangd", "rust_analyzer",
                "dockerls", "lemminx", "taplo",
            },
            handlers = {
                -- Default handler
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,

                -- Lua language server with enhanced configuration
                lua_ls = function()
                    require('lspconfig').lua_ls.setup {
                        settings = {
                            Lua = {
                                runtime = {
                                    version = 'LuaJIT',
                                },
                                diagnostics = {
                                    globals = { 'vim', 'require' },
                                    disable = { 'missing-fields', 'undefined-global' },
                                },
                                workspace = {
                                    library = {
                                        vim.env.VIMRUNTIME,
                                        "${3rd}/luv/library",
                                        "${3rd}/busted/library",
                                    },
                                    checkThirdParty = false,
                                },
                                completion = {
                                    callSnippet = "Replace"
                                },
                                telemetry = {
                                    enable = false,
                                },
                            },
                        },
                    }
                end,
            },
        })

        -- Completion setup
        local cmp = require('cmp')
        require('luasnip.loaders.from_vscode').lazy_load()
        vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

        cmp.setup({
            preselect = 'item',
            completion = {
                completeopt = 'menu,menuone,noinsert'
            },
            window = {
                documentation = cmp.config.window.bordered(),
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip', keyword_length = 2 },
                { name = 'buffer',  keyword_length = 3 },
                { name = 'path' },
            },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            formatting = {
                fields = { 'abbr', 'menu', 'kind' },
                format = function(entry, item)
                    local source_names = {
                        nvim_lsp = '[LSP]',
                        luasnip = '[Snip]',
                        buffer = '[Buf]',
                        path = '[Path]',
                    }
                    item.menu = source_names[entry.source.name] or string.format('[%s]', entry.source.name)
                    return item
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
                ['<C-f>'] = cmp.mapping.scroll_docs(5),
                ['<C-u>'] = cmp.mapping.scroll_docs(-5),
                ['<C-e>'] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.abort()
                    else
                        cmp.complete()
                    end
                end),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.confirm({ select = true })
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<C-d>'] = cmp.mapping(function(fallback)
                    local luasnip = require('luasnip')
                    if luasnip.jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<C-b>'] = cmp.mapping(function(fallback)
                    local luasnip = require('luasnip')
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
        })

        -- Fix for vim global diagnostic issues
        vim.api.nvim_create_augroup("FixVimGlobalDiagnostic", { clear = true })

        -- Filter out vim global errors when switching from insert to normal mode
        vim.api.nvim_create_autocmd("ModeChanged", {
            group = "FixVimGlobalDiagnostic",
            pattern = "i:n",
            callback = function()
                vim.defer_fn(function()
                    local current_buf = vim.api.nvim_get_current_buf()
                    local diagnostics = vim.diagnostic.get(current_buf)
                    local has_vim_global_error = false

                    for _, diagnostic in ipairs(diagnostics) do
                        if diagnostic.message and diagnostic.message:match("undefined global.*vim") then
                            has_vim_global_error = true
                            break
                        end
                    end

                    if has_vim_global_error then
                        vim.diagnostic.reset(current_buf)
                    end
                end, 100)
            end,
        })
    end
}
