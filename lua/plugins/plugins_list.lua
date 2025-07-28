return {
  -- fzf plugin
  fzf = {
    url = "https://github.com/ibhagwan/fzf-lua",
    callback = function()
      local fzf = require('fzf-lua')

      vim.keymap.set("n", "<leader>pf", fzf.files)
      vim.keymap.set("n", "<leader>pb", fzf.buffers)
      vim.keymap.set("n", "<leader>ps", fzf.live_grep)
      vim.keymap.set("n", "<leader>h", fzf.help_tags)

      fzf.setup({
        files = {
          actions = { ["ctrl-q"] = { fn = fzf.actions.file_sel_to_qf, prefix = "select-all" } },
          case_mode = 'smart',
        }
      })
    end
  },

  -- colorscheme
  rose_pine = {
    url = "https://github.com/rose-pine/neovim",
    opts = {
      styles = {
        transparency = true,
      },
    },
    callback = function(opts)
      require("rose-pine").setup(opts)
      vim.cmd("colorscheme rose-pine")
    end,
  },

  -- blink cmp
  blink_cmp = {
    url = "https://github.com/Saghen/blink.cmp",
    opts = {
      completion = {
        menu = { border = 'none' },
      },
    },
    callback = function(opts)
      require("blink.cmp").setup(opts)
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
      local ensure_installed = {
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
      }

      for server, config in pairs(ensure_installed) do
        local default = type(vim.lsp.config[server]) == "table" and vim.lsp.config[server] or {}
        local merged = vim.tbl_deep_extend("force", default, config)

        local capabilities = require('blink.cmp').get_lsp_capabilities()
        merged.capabilities = capabilities

        vim.lsp.config[server] = merged
        vim.lsp.enable(server)
      end
    end,
  }
}
