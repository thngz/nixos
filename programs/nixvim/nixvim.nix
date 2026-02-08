{ lib, pkgs, ... }:
{
  programs.nixvim = {
        enable = true;

        colorschemes.catppuccin.enable = true;
        plugins.lualine.enable = true;
  };
}
# let
#   compile-mode = pkgs.vimUtils.buildVimPlugin {
#     name = "compile-mode-nvim";
#     src = pkgs.fetchFromGitHub {
#       owner = "ej-shafran";
#       repo = "compile-mode.nvim";
#       rev = "6b41499bd782be2c213011072ce0f0eb9f7b78a2";
#       hash = "sha256-AoEuE+BLQwAHgvkanLUU6kd4HhAyn9Y53lRAYnoghz4=";
#     };
#   };

#   modus-theme = pkgs.vimUtils.buildVimPlugin {
#     name = "modus-theme-vim";
#     src = pkgs.fetchFromGitHub {
#       owner = "ishan9299";
#       repo = "modus-theme-vim";
#       rev = "4d827fbf1aad55f4d62225f7b999efc5023864a3";
#       hash = "sha256-7qb0c235YD5IiN3voaK1a/3B7Dl62RbgbmbZ/fzTVhU=";
#     };
#   };
# in {
#   enable = true;
#   withNodeJs = true;
#   withPython3 = true;

#   globals.mapleader = " ";

#   options = {
#     relativenumber = true;
#     number = true;
#     termguicolors = true;
#     hlsearch = false;
#     incsearch = true;
#     scrolloff = 8;
#     swapfile = false;
#     backup = false;
#     ignorecase = true;
#     autoindent = true;
#     tabstop = 4;
#     shiftwidth = 4;
#     expandtab = true;
#     clipboard = "unnamedplus";
#   };

#   # colorscheme = "modus-vivendi";

#   keymaps = [
#     {
#       mode = "v";
#       key = "J";
#       action = ":m '>+1<CR>gv=gv";
#     }
#     {
#       mode = "v";
#       key = "K";
#       action = ":m '<-2<CR>gv=gv";
#     }
#     {
#       mode = "n";
#       key = "J";
#       action = "mzJ`z";
#     }
#     {
#       mode = "n";
#       key = "<leader>gs";
#       action = "<cmd>Git<CR>";
#     }
#     {
#       mode = "n";
#       key = "<leader>sh";
#       action = "<cmd>split<CR>";
#     }
#     {
#       mode = "n";
#       key = "<leader>sv";
#       action = "<cmd>vsplit<CR>";
#     }
#     {
#       mode = "n";
#       key = "<leader>fe";
#       action = "<cmd>Oil .<CR>";
#     }
#     {
#       mode = "n";
#       key = "<leader>h";
#       action = "<C-w>h";
#     }
#     {
#       mode = "n";
#       key = "<leader>j";
#       action = "<C-w>j";
#     }
#     {
#       mode = "n";
#       key = "<leader>k";
#       action = "<C-w>k";
#     }
#     {
#       mode = "n";
#       key = "<leader>l";
#       action = "<C-w>l";
#     }
#     {
#       mode = "n";
#       key = "<leader>q";
#       action = "<cmd>q<CR>";
#     }
#     {
#       mode = "n";
#       key = "<leader>cc";
#       action = "<cmd>below Compile<CR>";
#     }
#     {
#       mode = "n";
#       key = "<leader>ci";
#       action = "<cmd>CompileInterrupt<CR>";
#     }
#     {
#       mode = "n";
#       key = "<leader>fd";
#       action = "<cmd>NvimTreeToggle<CR>";
#     }
#     {
#       mode = "n";
#       key = "<leader>u";
#       action = "<cmd>UndotreeToggle<CR>";
#     }
#     {
#       mode = "n";
#       key = "<leader>rc";
#       action = "<cmd>SlimeConfig<CR>";
#     }
#     {
#       mode = "v";
#       key = "<leader>rr";
#       action = ":<C-u>'<,'>SlimeSend<CR>";
#     }
#     {
#       mode = "n";
#       key = "<leader>fm";
#       action =
#         "<cmd>lua require('conform').format({ lsp_format = 'fallback' })<CR>";
#     }
#     {
#       mode = "n";
#       key = "<leader>ca";
#       action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
#     }
#     {
#       mode = "n";
#       key = "<leader>rn";
#       action = "<cmd>lua vim.lsp.buf.rename()<CR>";
#     }
#     {
#       mode = "n";
#       key = "<leader>vd";
#       action = "<cmd>lua vim.diagnostic.open_float()<CR>";
#     }
#   ];

#   extraPlugins = [
#     pkgs.vimPlugins."comment-nvim"
#     pkgs.vimPlugins."vim-fugitive"
#     pkgs.vimPlugins."autoclose-nvim"
#     pkgs.vimPlugins."nvim-lightbulb"
#     pkgs.vimPlugins."better-escape-nvim"
#     pkgs.vimPlugins."oil-nvim"
#     pkgs.vimPlugins."nvim-surround"
#     pkgs.vimPlugins."nvim-tree-lua"
#     pkgs.vimPlugins."vim-moonfly-colors"
#     pkgs.vimPlugins."gruber-darker-nvim"
#     pkgs.vimPlugins."Ionide-vim"
#     pkgs.vimPlugins."undotree"
#     pkgs.vimPlugins."vim-slime"
#     pkgs.vimPlugins."flash-nvim"
#     pkgs.vimPlugins.harpoon2
#     pkgs.vimPlugins."telescope-nvim"
#     pkgs.vimPlugins."plenary-nvim"
#     pkgs.vimPlugins."nvim-lspconfig"
#     pkgs.vimPlugins."nvim-cmp"
#     pkgs.vimPlugins."cmp-nvim-lsp"
#     pkgs.vimPlugins.luasnip
#     pkgs.vimPlugins."conform-nvim"
#     pkgs.vimPlugins."nvim-treesitter"
#     compile-mode
#     modus-theme
#   ];

#   extraConfigLua = ''
#     require('Comment').setup({})
#     require('autoclose').setup({})
#     require('nvim-lightbulb').setup({ autocmd = { enabled = true } })
#     require('better_escape').setup({})
#     require('oil').setup({})
#     require('nvim-surround').setup({})
#     require('nvim-tree').setup()
#     require('flash').setup({})

#     vim.g.compile_mode = {
#       baleia_setup = true,
#     }

#     vim.g.slime_target = "tmux"
#     vim.g.slime_cell_delimiter = "# %%"
#     vim.g.slime_bracketed_paste = 1

#     require('telescope').setup({
#       defaults = {
#         file_ignore_patterns = { '^node_modules/', '.wwwroot/', '.bin/', '.obj/' },
#       }
#     })

#     local builtin = require('telescope.builtin')
#     vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
#     vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
#     vim.keymap.set('n', '<leader>fo', builtin.current_buffer_fuzzy_find, {})
#     vim.keymap.set('n', '<leader>rr', builtin.lsp_references, {})
#     vim.keymap.set('n', '<leader>dd', builtin.diagnostics, {})
#     vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
#     vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
#     vim.keymap.set('n', '<leader>gd', builtin.git_status, {})

#     local harpoon = require("harpoon")
#     harpoon:setup()
#     vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
#     vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
#     vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
#     vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
#     vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
#     vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
#     vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end)
#     vim.keymap.set("n", "<leader>p", function() harpoon:list():prev() end)
#     vim.keymap.set("n", "<leader>n", function() harpoon:list():next() end)

#     local cmp = require('cmp')
#     cmp.setup({
#       mapping = cmp.mapping.preset.insert({
#         ['<C-Space>'] = cmp.mapping.complete(),
#         ['<C-u>'] = cmp.mapping.scroll_docs(-4),
#         ['<C-d>'] = cmp.mapping.scroll_docs(4),
#         ['<Tab>'] = cmp.mapping.confirm({ select = true }),
#       }),
#       sources = cmp.config.sources({
#         { name = 'nvim_lsp' },
#         { name = 'luasnip' },
#       }, {
#         { name = 'buffer' },
#       })
#     })

#     require('conform').setup({
#       formatters_by_ft = {
#         nix = { "nixfmt" },
#         ocaml = { "ocamlformat" },
#         python = { "black" },
#         typescript = { "prettier" },
#         vue = { "prettier" },
#       }
#     })

#     vim.lsp.enable({
#       'html',
#       'cssls',
#       'eslint',
#       'clangd',
#       'dockerls',
#       'docker_compose_language_service',
#       'ocamllsp',
#       'hls',
#       'jdtls',
#       'lua_ls',
#       'gopls',
#       'svelte',
#       'tailwindcss',
#     })

#     local function find_nix_paths()
#       local server = vim.fn.exepath('vue-language-server')
#       local store = server:match('^(/nix/store/[^/]+)')
#       return store
#     end

#     vim.lsp.config('basedpyright', {
#       settings = {
#         basedpyright = {
#           analysis = {
#             diagnosticSeverityOverrides = {
#               reportUnknownVariableType = "none",
#               reportUnknownParameterType = "none",
#               reportMissingParameterType = "none",
#               reportUnknownMemberType = "none",
#               reportUnusedCallResult = "none",
#               reportUnannotatedClassAttribute = "none",
#               reportMissingTypeStubs = "none",
#               reportUnknownArgumentType = "none",
#               reportAny = "none",
#             },
#           },
#         },
#       },
#     })

#     vim.lsp.enable('basedpyright')

#     vim.lsp.config('vue_ls', {})
#     vim.lsp.config('ts_ls', {
#       init_options = {
#         plugins = {
#           {
#             name = '@vue/typescript-plugin',
#             location = find_nix_paths(),
#             languages = { 'vue' },
#           }
#         },
#       },
#       filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
#       single_file_support = true
#     })
#     vim.lsp.enable({ 'ts_ls', 'vue_ls' })

#     vim.lsp.config('rust_analyzer', {})
#     vim.lsp.enable({ 'rust_analyzer' })

#     local orig_notify = vim.notify
#     vim.notify = function(msg, ...)
#       if msg:find("Spawning language server") then
#         return
#       end
#       orig_notify(msg, ...)
#     end

#     vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
#     vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
#     vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
#     vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
#     vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

#     vim.api.nvim_create_autocmd("FileType", {
#       pattern = "fsharp",
#       callback = function()
#         vim.treesitter.stop()
#       end,
#     })

#     local ts = require('nvim-treesitter.configs')
#     ts.setup({
#       indent = { enable = true },
#       highlight = { enable = true },
#       ensure_installed = {
#         "bash",
#         "c",
#         "diff",
#         "html",
#         "javascript",
#         "jsdoc",
#         "json",
#         "jsonc",
#         "lua",
#         "luadoc",
#         "luap",
#         "markdown",
#         "markdown_inline",
#         "printf",
#         "python",
#         "query",
#         "regex",
#         "toml",
#         "tsx",
#         "typescript",
#         "vim",
#         "vimdoc",
#         "xml",
#         "yaml",
#       },
#     })

#     require("nvim-treesitter").install({ 'go', 'svelte', 'vue' })
#   '';
}
