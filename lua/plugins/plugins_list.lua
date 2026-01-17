return {
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
        ts_ls = {},
        graphql = {},
      }

      for server, config in pairs(lsps) do
        config.capabilities = capabilities

        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end,
  },


  zen = {
    url = "https://github.com/nendix/zen.nvim",
    opts = {
      transparent = true,
    },
    callback = function(opts)
      require("zen").setup(opts)
      vim.cmd.colorscheme("zen")
    end,
  },

  oil = {
    url = "https://github.com/stevearc/oil.nvim",
    opts = {
      view_options = {
        show_hidden = true,
      }
    },
    callback = function(opts)
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
      require("oil").setup(opts)
    end,
  },

  -- fzf lua
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

  -- lsp_config
  lsp_config = {
    url = "https://github.com/neovim/nvim-lspconfig",
    callback = function()
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
        rust_analyzer = {},
        ts_ls = {},
        pyright = {},
        ruff = {},
        graphql = {},
        clangd = {},
      }

      for server, config in pairs(lsps) do
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end,
  }
}
