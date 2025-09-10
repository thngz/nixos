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
            local servers = {
                'basedpyright',
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
            }

            local nvim_lsp = require('lspconfig')

            nvim_lsp.denols.setup {
                root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
            }

            nvim_lsp.lexical.setup {
                cmd = { 'lexical' }
            }

            local vue_language_server_path = vim.fn.exepath('vue-language-server')
            local vue_plugin = {
                name = '@vue/typescript-plugin',
                location = vue_language_server_path,
                languages = { 'vue' },
                configNamespace = 'typescript',
            }

            local ts_ls_config = {
                root_dir = nvim_lsp.util.root_pattern("package.json"),
                init_options = {
                    plugins = {
                        vue_plugin,
                    },
                },
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
                single_file_support = false
            }

            -- vim.lsp.config('vue_ls', {})
            -- vim.lsp.config('ts_ls', ts_ls_config)
            -- vim.lsp.enable('vue_ls')
            -- vim.lsp.enable('ts_ls')

            nvim_lsp.volar.setup({})
            nvim_lsp.ts_ls.setup(ts_ls_config)

            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local orig_notify = vim.notify

            vim.notify = function(msg, ...)
                if msg:find("Spawning language server") then return end
                orig_notify(msg, ...)
            end

            for _, server in ipairs(servers) do
                nvim_lsp[server].setup { capabilities = capabilities }
            end

            vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
            vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
            vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
            vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
            vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
            vim.keymap.set('n', 'gne', '<cmd>lua vim.diagnostic.goto_next()<cr>')
            vim.keymap.set('n', 'gpe', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

            vim.keymap.set("n", "<leader>fm", function() require("conform").format({ lsp_format = "fallback" }) end)
            vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end)
            vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end)
        end
    },

}
