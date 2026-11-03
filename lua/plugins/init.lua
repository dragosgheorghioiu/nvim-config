-- theme
vim.pack.add({ {
  src = 'https://github.com/zitrocode/carvion.nvim',
  name = 'carvion'
} })

vim.cmd.colorscheme('carvion')

-- lsp config
vim.pack.add({ {
  src = 'https://github.com/neovim/nvim-lspconfig',
  name = 'lsp-config'
} })

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
  -- c/c++
  ccls = {},
  --go
  gopls = {},
  -- bash
  bashls = {},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

for server, config in pairs(lsps) do
  config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end

-- oil
vim.pack.add({ {
  src = 'https://github.com/stevearc/oil.nvim',
  name = 'oil'
} })
local opts = {
  columns = {
    "icon",
    "permissions",
    "size",
  },
  view_options = {
    show_hidden = true,
  }
}
require('oil').setup(opts)
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })


-- completion
vim.pack.add({ {
  src = 'https://github.com/echasnovski/mini.completion',
} })

require('mini.completion').setup({
  lsp_completion = {
    source_func = 'omnifunc',
    auto_setup = true,
  }
})
vim.o.completeopt = "menu,menuone,noinsert,noselect"

-- fzf
vim.pack.add({ {
  src = 'https://github.com/ibhagwan/fzf-lua',
} })

vim.keymap.set("n", "<leader>pf", require('fzf-lua').files)
vim.keymap.set("n", "<leader>ps", require('fzf-lua').live_grep)
vim.keymap.set("n", "<leader>py", require('fzf-lua').lsp_live_workspace_symbols)

-- treesitter
vim.pack.add({ {
  src = 'https://github.com/nvim-treesitter/nvim-treesitter',
} })
require('nvim-treesitter').setup {
  install_dir = vim.fn.stdpath('data') .. '/site'
}
