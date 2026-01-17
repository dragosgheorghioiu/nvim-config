-- basic
vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.clipboard:append("unnamedplus")


-- tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true


-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- looks
vim.opt.termguicolors = true
vim.opt.synmaxcol = 300
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "100"
vim.opt.guicursor = "n-i-v-c:block"
vim.opt.winborder = 'rounded'
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 300
vim.opt.completeopt = { "menu", "menuone", "popup" }


-- file handling
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0
vim.opt.autoread = true
vim.opt.autowrite = false


-- behaviour
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
vim.opt.iskeyword:append("-")
vim.opt.mouse = "a"
vim.opt.modifiable = true
vim.opt.path:append('**')
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.exrc = true
vim.opt.secure = true

-- load local project config
vim.opt.exrc = true
vim.opt.secure = true

local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end


-- windows
if vim.fn.has("win32") == 1 then
  vim.o.shell = "cmd.exe"
  vim.o.shellcmdflag = "/c"
  vim.o.shellpipe = ">%s 2>&1"
end


-- window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })


-- performance
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

vim.opt.wildmenu = true
vim.opt.wildmode = { "longest", "full" }
vim.opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })


-- stop highlights
vim.keymap.set("n", "<Esc>", ":nohl<CR>", { silent = true })


-- config
vim.keymap.set("n", "<leader>rc", ":e $MYVIMRC<CR>", { desc = "Edit config" })
vim.keymap.set("n", "<leader>rl", ":so $MYVIMRC<CR>", { desc = "Reload config" })


-- build command
vim.keymap.set("n", "<leader>b", ":make<CR>", { desc = "Build project" })

-- autocommands configs
require("autocommands")


-- terminal
require("terminal").setup()


-- plugins
require("plugins").setup()
