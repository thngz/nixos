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

in
{
  programs.nixvim = {

    enable = true;

    globals = {
      mapleader = " ";
    };

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
          html.enable = true;
          htmx.enable = true;
          templ.enable = true;
          tinymist.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
            settings = {
              check = {
                command = "clippy";
              };
            };
          };
          basedpyright = {
            enable = true;
            settings = {
              basedpyright = {

                analysis = {
                  diagnosticSeverityOverrides = {
                    reportUnknownVariableType = "none";
                    reportUnknownParameterType = "none";
                    reportMissingParameterType = "none";
                    reportUnknownMemberType = "none";
                    reportUnusedCallResult = "none";
                    reportUnannotatedClassAttribute = "none";
                    reportMissingTypeStubs = "none";
                    reportUnknownArgumentType = "none";
                    reportAny = "none";
                  };
                };
              };
            };
          };
        };
      };
      lualine.enable = true;
      comment.enable = true;
      fugitive.enable = true;
      lazygit.enable = true;
      autoclose.enable = true;
      nvim-lighbulb.enable = true;
      better-escape.enable = true;
      oil.enable = true;
      nvim-surround.enable = true;
      nvim-tree-lua.enable = true;
      undotree.enable = true;
      telescope = {
        enable = true;
        extensions = {
          file-browser.enable = true;
          media-files = {
            enable = true;
            settings = {
              filetypes = [
                "png"
                "webp"
                "jpg"
                "jpeg"
              ];

            };
          };
        };
        settings = {
          file_ignore_patterns = [
            "^node_modules/"
            ".wwwroot/"
            ".bin/"
            ".obj/"
          ];
        };
      };
      web-devicons.enable = true;
      harpoon.enable = true;
      flash.enable = true;
      blink-cmp = {
        enable = true;
        settings = {
          keymap = {
            preset = "super-tab";
            appearance.kind_icons = {
              Class = "󱡠";
              Color = "󰏘";
              Constant = "󰏿";
              Constructor = "󰒓";
              Enum = "󰦨";
              EnumMember = "󰦨";
              Event = "󱐋";
              Field = "󰜢";
              File = "󰈔";
              Folder = "󰉋";
              Function = "󰊕";
              Interface = "󱡠";
              Keyword = "󰻾";
              Method = "󰊕";
              Module = "󰅩";
              Operator = "󰪚";
              Property = "󰖷";
              Reference = "󰬲";
              Snippet = "󱄽";
              Struct = "󱡠";
              Text = "󰉿";
              TypeParameter = "󰬛";
              Unit = "󰪚";
              Value = "󰦨";
              Variable = "󰆦";
            };
          };
        };
      };
      vim-slime = {
        enable = true;
        settings = {
          target = "zellij";
          bracketed_paste = 1;
        };

      };
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

        highlight.enable = true;
        indent.enable = true;
      };
      jupytext.enable = true;
      typst-preview.enable = true;
      grug-far = {
        enable = true;
        settings = {
          keymaps = {
            replace = {
              n = "<leader>re";
            };
          };
        };
      };
      treesitter-textobjects = {
        enable = true;
        settings = {
          select = {
            enable = true;
            lookahead = true;
          };
        };
      };
    };
    dependencies.tree-sitter.enable = true;
    colorschemes.modus.enable = true;
    extraPlugins = [
      pkgs.vimPlugins.plenary-nvim
      (pkgs.vimUtils.buildVimPlugin {
        name = "99";
        src = pkgs.fetchFromGitHub {
          owner = "ThePrimeagen";
          repo = "99";
          rev = "96f3682ea890a3f2037aafa253c92d0dd3b82161";
          hash = "sha256-ZfaDC6je7UodCRcpDMGzWsEPaL7qYyOyNftRawr4Qss=";
        };
      })
    ];

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
        mode = "x";
        key = "af";
        action = "<cmd>lua require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')<CR>";
      }
      {
        mode = "o";
        key = "af";
        action = "<cmd>lua require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')<CR>";
      }
      {
        mode = "x";
        key = "if";
        action = "<cmd>lua require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')<CR>";
      }
      {
        mode = "o";
        key = "if";
        action = "<cmd>lua require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')<CR>";
      }
      {
        mode = "x";
        key = "ac";
        action = "<cmd>lua require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects')<CR>";
      }
      {
        mode = "o";
        key = "ac";
        action = "<cmd>lua require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects')<CR>";
      }
      {
        mode = "x";
        key = "ic";
        action = "<cmd>lua require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects')<CR>";
      }
      {
        mode = "o";
        key = "ic";
        action = "<cmd>lua require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects')<CR>";
      }
      {
        mode = "x";
        key = "as";
        action = "<cmd>lua require('nvim-treesitter-textobjects.select').select_textobject('@local.scope', 'locals')<CR>";
      }
      {
        mode = "o";
        key = "as";
        action = "<cmd>lua require('nvim-treesitter-textobjects.select').select_textobject('@local.scope', 'locals')<CR>";
      }
      {
        mode = "n";
        key = "J";
        action = "mzJ`z";
      }
      {
        mode = "n";
        key = "<leader>gs";
        action = "<cmd>LazyGit<CR>";
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
        action = "<cmd>lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<CR>";
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
        action = "<cmd>lua require('conform').format({ lsp_format = 'fallback' })<CR>";
      }
      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      }
      {
        mode = "n";
        key = "gd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
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
        key = "<leader>vm";
        action = "<cmd>Telescope media_files<CR>";
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
      {
        mode = "v";
        key = "<leader>ai";
        action = "<cmd>lua require('99').visual()<CR>";
      }
      {
        mode = "v";
        key = "<leader>ac";
        action = "<cmd>lua require('99').stop_all_requests()<CR>";
      }
      {
        mode = "v";
        key = "<leader>as";
        action = "<cmd>lua require('99').search()<CR>";
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>GrugFar<CR>";
      }
      {
        mode = "v";
        key = "<leader>fr";
        action = ":<C-u>lua require('grug-far').with_visual_selection()<CR>";
      }
    ];
    extraConfigLua = ''
      vim.lsp.set_log_level("off")
      local _99 = require("99")
      local cwd = vim.uv.cwd()
      local basename = vim.fs.basename(cwd)
      _99.setup({
        provider = _99.OpenCodeProvider,
        model = "openai/gpt-5.2-codex",
        logger = {
          level = _99.DEBUG,
          path = "/tmp/" .. basename .. ".99.debug",
          print_on_error = true,
        },
        completion = {
          custom_rules = {
            "scratch/custom_rules/",
          },
          files = {
          },
          source = "blink",
        },
        md_files = {
          "AGENT.md",
        },
      })
    '';
  };
}
