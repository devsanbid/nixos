local opt = vim.opt

opt.guicursor = ""
opt.nu = true
opt.grepprg = "rg --vimgrep" -- Program to use for grep
opt.relativenumber = true
opt.spelllang = { -- Languages for spell checking
	"en",
}

opt.tabstop = 2
vim.cmd("set formatoptions-=cro")
opt.softtabstop = 2
opt.shiftwidth = 2
vim.o.autoindent = true -- Automatically indent new lines
vim.o.smartindent = true

opt.expandtab = true
opt.smartcase = true
opt.ignorecase = true
opt.showtabline = 0
opt.linebreak = true
opt.smartindent = true
opt.wrap = false
opt.showmode = false
opt.cursorline = true
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.undofile = true
opt.undolevels = 10000
opt.virtualedit = "block"
opt.hlsearch = false
opt.incsearch = true
opt.termguicolors = true
vim.opt.clipboard:append("unnamedplus") -- use system clipboard
vim.g.clipboard = {
  name = 'kitty',
  copy = {
    ['+'] = {'kitty', '+kitten', 'clipboard'},
    ['*'] = {'kitty', '+kitten', 'clipboard'},
  },
  paste = {
    ['+'] = {'kitty', '+kitten', 'clipboard', '--get-clipboard'},
    ['*'] = {'kitty', '+kitten', 'clipboard', '--get-clipboard'},
  },
  cache_enabled = 0,
}
opt.scrolloff = 16
opt.signcolumn = "no"
opt.isfname:append("@-@")
opt.pumheight = 8
opt.pumwidth = 5
opt.mouse = ""
opt.autowrite = true -- Enable auto write
opt.grepprg = "rg --vimgrep"
opt.pumblend = 10 -- Popup blend
opt.showmode = false
opt.sidescrolloff = 8 -- Columns of context
-- opt.updatetime = 50
opt.colorcolumn = "80"
