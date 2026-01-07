return {
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
        clangd = {},
        pyright = {},
        ruff = {},
      }

      for server, config in pairs(lsps) do
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end,
  }
}
