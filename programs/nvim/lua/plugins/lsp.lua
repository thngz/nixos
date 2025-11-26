return {
    -- Formatting
    {
        'stevearc/conform.nvim',
        opts = {
            formatters_by_ft = {
                nix = { "nixfmt" },
                ocaml = { "ocamlformat" },
                python = { "black" },
                typescript = { "prettier" },
                vue = { "prettier" },
            }
        },
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            { 'L3MON4D3/LuaSnip' },
            { 'hrsh7th/cmp-nvim-lsp' }
        },
        config = function()
            local cmp = require('cmp')

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }),
                {
                    { name = 'buffer' }
                }
            })
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            vim.lsp.enable({
                'html',
                'cssls',
                'eslint',
                'clangd',
                'dockerls',
                'docker_compose_language_service',
                'ocamllsp',
                'hls',
                'jdtls',
                'lua_ls',
                'gopls',
                'svelte',
                'tailwindcss',
            })

            local function find_nix_paths()
                local server = vim.fn.exepath('vue-language-server')
                local store = server:match('^(/nix/store/[^/]+)')

                return store
            end

            vim.lsp.config('basedpyright', {
                settings = {
                    basedpyright = {
                        analysis = {
                            diagnosticSeverityOverrides = {
                                reportUnknownVariableType = "none",
                                reportUnknownParameterType = "none",
                                reportMissingParameterType = "none",
                                reportUnknownMemberType = "none",
                                reportUnusedCallResult = "none",
                                reportUnannotatedClassAttribute = "none",
                                reportMissingTypeStubs = "none",
                                reportUnknownArgumentType = "none",
                                reportAny = "none",
                            },
                        },
                    },
                },
            })

            vim.lsp.enable('basedpyright')

            vim.lsp.config('vue_ls', {})
            vim.lsp.config('ts_ls', {
                -- root_dir = vim.lsp.util.root_pattern("package.json"),
                init_options = {
                    plugins = {
                        {
                            name = '@vue/typescript-plugin',
                            location = find_nix_paths(),
                            languages = { 'vue' },
                        }
                    },
                },
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
                single_file_support = true
            })
            vim.lsp.enable({ 'ts_ls', 'vue_ls' })

            vim.lsp.config('rust_analyzer', {})
            vim.lsp.enable({'rust_analyzer'})

            local orig_notify = vim.notify

            vim.notify = function(msg, ...)
                if msg:find("Spawning language server") then return end
                orig_notify(msg, ...)
            end


            vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
            vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
            vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
            vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
            vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

            vim.keymap.set("n", "<leader>fm", function() require("conform").format({ lsp_format = "fallback" }) end)
            vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end)
            vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end)

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "fsharp",
                callback = function()
                    vim.treesitter.stop()
                end,
            })
        end

    },

}
