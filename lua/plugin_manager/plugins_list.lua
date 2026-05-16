return {
  mini_cmp = {
    url = "https://github.com/nvim-mini/mini.completion",
    callback = function(opts)
      require("mini.completion").setup(opts)
    end,
  },

  vscode = {
    url = "https://github.com/mofiqul/vscode.nvim",
    opts = {
      transparent = true,
    },
    callback = function(opts)
      require("vscode").setup(opts)
      vim.cmd.colorscheme("vscode")
    end,
  },

  oil = {
    url = "https://github.com/stevearc/oil.nvim",
    opts = {
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = {},
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = { "actions.close", mode = "n" },
        ["<C-l>"] = {},
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
      },
    },
    callback = function(opts)
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
      require("oil").setup(opts)
    end,
  },

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
        -- rust
        rust_analyzer = {},
        -- typescript
        ts_ls = {},
        -- python
        pyright = {},
        ruff = {},
        -- c/c++
        clangd = {},
      }

      for server, config in pairs(lsps) do
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end,
  }
}
