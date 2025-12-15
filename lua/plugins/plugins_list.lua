return {
  -- fzf plugin
  fzf = {
    url = "https://github.com/ibhagwan/fzf-lua",
    callback = function()
      local fzf = require('fzf-lua')

      vim.keymap.set("n", "<leader>pf", fzf.files)
      vim.keymap.set("n", "<leader>pb", fzf.buffers)
      vim.keymap.set("n", "<leader>ps", fzf.live_grep)
      vim.keymap.set("n", "<leader>pd", fzf.diagnostics_workspace)
      vim.keymap.set("n", "<leader>h", fzf.help_tags)

      fzf.setup()
    end
  },

  -- colorscheme
  -- rose_pine = {
  --   url = "https://github.com/rose-pine/neovim",
  --   opts = {
  --     styles = {
  --       transparency = true,
  --     },
  --   },
  --   callback = function(opts)
  --     require("rose-pine").setup(opts)
  --     vim.cmd("colorscheme rose-pine")
  --   end,
  -- },
  zen = {
    url = "https://github.com/nendix/zen.nvim",
    opts = {
      transparency = true,
    },
    callback = function(opts)
      require("zen").setup(opts)
      vim.cmd.colorscheme("zen")
    end,
  },

  -- blink cmp
  blink_cmp = {
    url = "https://github.com/Saghen/blink.cmp",
    build = "cargo build --release",
    opts = {
      completion = {
        menu = { border = 'none' },
      },
    },
    callback = function(opts)
      require("blink.cmp").setup(opts)
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lsps = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
        gopls = {},
        clangd = {},
        rust_analyzer = {},
        ts_ls = {},
        pyright = {},
        ruff = {},
      }

      for server, config in pairs(lsps) do
        config.capabilities = capabilities

        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end,
  },

  -- oil
  oil = {
    url = "https://github.com/stevearc/oil.nvim",
    opts = {
      columns = {
        "icon",
        "permissions",
        "size",
      },
      view_options = {
        show_hidden = true,
      }
    },
    callback = function(opts)
      require("oil").setup(opts)
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end
  },

  -- lsp_config
  lsp_config = {
    url = "https://github.com/neovim/nvim-lspconfig",
    callback = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lsps = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
        clangd = {},
        rust_analyzer = {},
        ts_ls = {},
        pyright = {},
        ruff = {},
        ansiblels = {
          cmd = { '/opt/homebrew/Cellar/node/24.9.0/lib/node_modules/@ansible/ansible-language-server/bin/ansible-language-server', '--stdio' }
        },
        gopls = {},
      }

      for server, config in pairs(lsps) do
        config.capabilities = capabilities

        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end,
  }
}
