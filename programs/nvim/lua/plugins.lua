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
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- Colorschemes
        { 'bluz71/vim-moonfly-colors' },
        { "blazkowolf/gruber-darker.nvim" },
        { "rafi/awesome-vim-colorschemes" },

    }
}
