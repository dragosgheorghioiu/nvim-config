return {
    mini_completion = {
        url = "https://github.com/echasnovski/mini.completion",
        callback = function()
            require("mini.completion").setup({
                lsp_completion = {
                    source_func = 'omnifunc',
                    auto_setup = true,
                }
            })

            vim.o.completeopt = "menu,menuone,noinsert,noselect"

            vim.keymap.set("i", "<C-Space>", function()
                require("mini.completion").complete()
            end, { desc = "Mini completion manual trigger" })
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
                -- typescript
                ts_ls = {},
                -- python
                pyright = {},
                ruff = {},
                -- c/c++
                clangd = {},
                -- go
                gopls = {},
                -- typst
                tinymist = {},
                -- bash
                bashls = {},
                -- elixir
                dexter = {},
            }

            for server, config in pairs(lsps) do
                vim.lsp.config(server, config)
                vim.lsp.enable(server)
            end
        end,
    }
}
