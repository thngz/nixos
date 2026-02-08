{ lib, pkgs, ... }:

let
  compile-mode = pkgs.vimUtils.buildVimPlugin {
    name = "compile-mode-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "ej-shafran";
      repo = "compile-mode.nvim";
      rev = "6b41499bd782be2c213011072ce0f0eb9f7b78a2";
      hash = "sha256-AoEuE+BLQwAHgvkanLUU6kd4HhAyn9Y53lRAYnoghz4=";
    };
  };

in {
  programs.nixvim = {

    enable = true;

    globals = { mapleader = " "; };

    opts = {
      relativenumber = true;
      number = true;
      termguicolors = true;
      hlsearch = false;
      incsearch = true;
      scrolloff = 8;
      swapfile = false;
      backup = false;
      ignorecase = true;
      autoindent = true;
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      clipboard = "unnamedplus";
    };
    plugins = {
      lsp = {
        enable = true;
        servers = {
          gopls.enable = true;
          tailwindcss.enable = true;
          emmet_ls.enable = true;
          ts_ls.enable = true;
          vue_ls.enable = true;
        };
      };
      lualine.enable = true;
      comment.enable = true;
      fugitive.enable = true;
      autoclose.enable = true;
      nvim-lighbulb.enable = true;
      better-escape.enable = true;
      oil.enable = true;
      nvim-surround.enable = true;
      nvim-tree-lua.enable = true;
      undotree.enable = true;
      telescope = {
        enable = true;
        extensions = { file-browser.enable = true; };
        settings = {
          file_ignore_patterns =
            [ "^node_modules/" ".wwwroot/" ".bin/" ".obj/" ];
        };
      };
      harpoon.enable = true;
      flash.enable = true;
      blink-cmp = { enable = true; };
      slime.enable = true;
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            nix = [ "nixfmt" ];
            ocaml = [ "ocamlformat" ];
            python = [ "black" ];
            typescript = [ "prettier" ];
            vue = [ "prettier" ];
          };
        };
      };
      treesitter = {
        enable = true;

        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          json
          lua
          make
          markdown
          nix
          regex
          toml
          vim
          vimdoc
          xml
          yaml
          go
          typescript
          javascript
          rust
        ];
      };

    };
    dependencies.tree-sitter.enable = true;
    colorschemes.modus.enable = true;
    extraPlugins = [ pkgs.vimPlugins.plenary-nvim ];

    keymaps = [
      {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
      }
      {
        mode = "n";
        key = "J";
        action = "mzJ`z";
      }
      {
        mode = "n";
        key = "<leader>gs";
        action = "<cmd>Git<CR>";
      }
      {
        mode = "n";
        key = "<leader>sh";
        action = "<cmd>split<CR>";
      }
      {
        mode = "n";
        key = "<leader>sv";
        action = "<cmd>vsplit<CR>";
      }
      {
        mode = "n";
        key = "<leader>fe";
        action = "<cmd>Oil .<CR>";
      }
      {
        mode = "n";
        key = "<leader>h";
        action = "<C-w>h";
      }
      {
        mode = "n";
        key = "<leader>j";
        action = "<C-w>j";
      }
      {
        mode = "n";
        key = "<leader>k";
        action = "<C-w>k";
      }
      {
        mode = "n";
        key = "<leader>l";
        action = "<C-w>l";
      }
      {
        mode = "n";
        key = "<leader>q";
        action = "<cmd>q<CR>";
      }
      {
        mode = "n";
        key = "<leader>cc";
        action = "<cmd>below Compile<CR>";
      }
      {
        mode = "n";
        key = "<leader>ci";
        action = "<cmd>CompileInterrupt<CR>";
      }
      {
        mode = "n";
        key = "<leader>fd";
        action = "<cmd>NvimTreeToggle<CR>";
      }
      {
        mode = "n";
        key = "<leader>a";
        action = "<cmd>lua require('harpoon'):list():add()<CR>";
      }
      {
        mode = "n";
        key = "<leader>e";
        action =
          "<cmd>lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<CR>";
      }
      {
        mode = "n";
        key = "<leader>1";
        action = "<cmd>lua require('harpoon'):list():select(1)<CR>";
      }
      {
        mode = "n";
        key = "<leader>2";
        action = "<cmd>lua require('harpoon'):list():select(2)<CR>";
      }
      {
        mode = "n";
        key = "<leader>3";
        action = "<cmd>lua require('harpoon'):list():select(3)<CR>";
      }
      {
        mode = "n";
        key = "<leader>4";
        action = "<cmd>lua require('harpoon'):list():select(4)<CR>";
      }
      {
        mode = "n";
        key = "<leader>5";
        action = "<cmd>lua require('harpoon'):list():select(5)<CR>";
      }
      {
        mode = "n";
        key = "<leader>p";
        action = "<cmd>lua require('harpoon'):list():prev()<CR>";
      }
      {
        mode = "n";
        key = "<leader>n";
        action = "<cmd>lua require('harpoon'):list():next()<CR>";
      }
      {
        mode = "n";
        key = "<leader>u";
        action = "<cmd>UndotreeToggle<CR>";
      }
      {
        mode = "n";
        key = "<leader>rc";
        action = "<cmd>SlimeConfig<CR>";
      }
      {
        mode = "v";
        key = "<leader>rr";
        action = ":<C-u>'<,'>SlimeSend<CR>";
      }
      {
        mode = "n";
        key = "<leader>fm";
        action =
          "<cmd>lua require('conform').format({ lsp_format = 'fallback' })<CR>";
      }
      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      }
      {
        mode = "n";
        key = "<leader>rn";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
      }
      {
        mode = "n";
        key = "<leader>vd";
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
      }

      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
      }
      {
        mode = "n";
        key = "<leader>fo";
        action = "<cmd>Telescope current_buffer_fuzzy_find<CR>";
      }
      {
        mode = "n";
        key = "<leader>rr";
        action = "<cmd>Telescope lsp_references<CR>";
      }
      {
        mode = "n";
        key = "<leader>dd";
        action = "<cmd>Telescope diagnostics<CR>";
      }
      {
        mode = "n";
        key = "<leader>gc";
        action = "<cmd>Telescope git_commits<CR>";
      }
      {
        mode = "n";
        key = "<leader>gb";
        action = "<cmd>Telescope git_branches<CR>";
      }
      {
        mode = "n";
        key = "<leader>gd";
        action = "<cmd>Telescope git_status<CR>";
      }
      {
        mode = "n";
        key = "s";
        action = "<cmd>lua require('flash'):jump()<CR>";
      }
    ];
  };
}

