return {
  "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "php", "javascript", "typescript", "html", "svelte"},
            
          sync_install = false,
          highlight = { 
            enable = true,
            additional_vim_regex_highlighting = true,
          },
          auto_install = true,
          indent = { enable = true },  
        })
        
        local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
        parser_config.fsharp = {
          install_info = {
            url = "https://github.com/ionide/tree-sitter-fsharp",
            branch = "main",
            files = {"src/scanner.c", "src/parser.c" },
          },
          filetype = "fsharp",
        }
    end
}

