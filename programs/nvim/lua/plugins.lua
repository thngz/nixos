return {
    { 'vim-airline/vim-airline' },

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

    { 'bluz71/vim-moonfly-colors' },

    { "blazkowolf/gruber-darker.nvim" },

    {
        'stevearc/oil.nvim',
        opts = {},
    },

}
