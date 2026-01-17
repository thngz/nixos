-- return {
--
--     'nvim-treesitter/nvim-treesitter',
--     build = ':TSUpdate',
--     opts = {
--         ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'golang', 'svelte'},
--         auto_install = true,
--         highlight = {
--             enable = true,
--         },
--         indent = { enable = true, disable = { 'ruby' } },
--     },
--
-- }
--
return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    opts_extend = { "ensure_installed" },
    opts = {
        indent = { enable = true },
        highlight = { enable = true },
        folds = { enable = true },
        ensure_installed = {
            "bash",
            "c",
            "diff",
            "html",
            "javascript",
            "jsdoc",
            "json",
            "jsonc",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "printf",
            "python",
            "query",
            "regex",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
        },
    },
    config = function(_, opts)
        local TS = require("nvim-treesitter")
        TS.setup(opts)
        local function attach(buf, language)
            -- check if parser exists before starting highlighter
            if not vim.treesitter.language.add(language) then
                return
            end
            vim.treesitter.start(buf, language)
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end

        local available = require('nvim-treesitter').get_available()
        vim.api.nvim_create_autocmd('FileType', {
            callback = function(args)
                local buf, filetype = args.buf, args.match
                local language = vim.treesitter.language.get_lang(filetype)
                if not language then
                    return
                end
                local installed = require('nvim-treesitter').get_installed('parsers')
                if vim.tbl_contains(installed, language) then
                    -- parser is already installed attach
                    attach(buf, language)
                elseif vim.tbl_contains(available, language) then
                    -- parser is not installed but available install it first then attach
                    require('nvim-treesitter').install(language):await(function()
                        attach(buf, language)
                    end)
                end
            end,
        })
        -- vim.api.nvim_create_autocmd("FileType", {
        --     callback = function(ev)
        --         pcall(vim.treesitter.start, ev.buf)
        --     end
        -- })
    end
}
