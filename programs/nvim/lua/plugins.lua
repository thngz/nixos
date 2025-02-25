return {
    {
        'numToStr/Comment.nvim',
        opts = {},
        lazy = false,
    },

    { 'tpope/vim-fugitive' },

    {
        'm4xshen/autoclose.nvim',
        config = function()
            require('autoclose').setup({})
        end
    },

    {
        'kosayoda/nvim-lightbulb',
        config = function()
            require("nvim-lightbulb").setup({
                autocmd = { enabled = true }
            })
        end
    },

    {
        "max397574/better-escape.nvim",
        config = function()
            require("better_escape").setup({})
        end
    },

    {
        'stevearc/oil.nvim',
        opts = {},
    },

    {
        "ej-shafran/compile-mode.nvim",
        branch = "latest",
        dependencies = { "nvim-lua/plenary.nvim", },
        config = function()
            vim.g.compile_mode = {
                -- to add ANSI escape code support, add:
                -- baleia_setup = true,
            }
        end

    },

    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },

    { 'bluz71/vim-moonfly-colors' },
    { "blazkowolf/gruber-darker.nvim" },
    { "ishan9299/modus-theme-vim" }
}
