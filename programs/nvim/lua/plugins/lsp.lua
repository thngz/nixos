return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },

    -- -- Autocompletion
    -- {
    --     'hrsh7th/nvim-cmp',
    --     event = 'InsertEnter',
    --     dependencies = {
    --         { 'L3MON4D3/LuaSnip' },
    --     },
    --     config = function()
    --         -- Here is where you configure the autocompletion settings.
    --         local lsp_zero = require('lsp-zero')
    --         lsp_zero.extend_cmp()
    --
    --         -- And you can configure cmp even more, if you want to.
    --         local cmp = require('cmp')
    --         local cmp_action = lsp_zero.cmp_action()
    --
    --         cmp.setup({
    --             formatting = lsp_zero.cmp_format(),
    --             mapping = cmp.mapping.preset.insert({
    --                 ['<C-Space>'] = cmp.mapping.complete(),
    --                 ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    --                 ['<C-d>'] = cmp.mapping.scroll_docs(4),
    --                 ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    --                 ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    --             })
    --         })
    --     end
    -- },

    -- Formatting
    {
        'stevearc/conform.nvim',
        opts = {
            formatters_by_ft = {
                nix = { "nixfmt" },
                ocaml = { "ocamlformat" }
            }
        },
    },


    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        -- dependencies = {
        --     { 'hrsh7th/cmp-nvim-lsp' },
        -- },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            local on_attach = function(_, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
            end

            lsp_zero.on_attach(on_attach)

            require('lspconfig').nil_ls.setup {
                settings = {
                    nil_ls = {
                        formatter = { command = { "nixfmt" } }
                    }
                }
            };

            require('lspconfig').pylsp.setup {}

            require('lspconfig').tsserver.setup {}

            require('lspconfig').html.setup {}

            require('lspconfig').cssls.setup {}

            require('lspconfig').eslint.setup {}

            require('lspconfig').clangd.setup {}

            require('lspconfig').dockerls.setup {}

            require('lspconfig').docker_compose_language_service.setup {}

            require('lspconfig').ocamllsp.setup {}
            require('lspconfig').hls.setup {}
            require('lspconfig').jdtls.setup {}

            -- Copypasta from the recommended neovim lua setup
            require 'lspconfig'.lua_ls.setup {
                on_init = function(client)
                    local path = client.workspace_folders[1].name
                    if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                        return
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = {
                            version = 'LuaJIT'
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME
                            }
                        }
                    })
                end,
                settings = {
                    Lua = {}
                }
            }


            vim.keymap.set("n", "<leader>fm", function() require("conform").format({ lsp_format = "fallback" }) end)
            vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end)
            vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end)
        end
    },

}
