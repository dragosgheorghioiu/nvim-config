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
