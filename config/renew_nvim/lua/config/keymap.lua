local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local snacks = require("snacks")


keymap("v", "<S-j>", "<Nop>")
keymap("n", "<S-j>", "<Nop>")
keymap("n", "U", "g+")


keymap("n", "p", "p=`]", { silent = true })
keymap("v", "y", "ygv<esc>")

keymap({ "n", "x" }, "j", "gj", opts)
keymap({ "n", "x" }, "k", "gk", opts)

keymap("n", "<C-n>", ":keepjumps normal! mi*`i<CR>") -- " Use * to add w/out jumping
keymap("n", "gx", ":silent! execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>")


-- buffer
keymap("n", "<leader>c",function () snacks.bufdelete() end, opts)

-- file action
keymap("n", "<leader>w", ":w<cr>", opts)

-- up and down
keymap("n", "<M-S-j>", "10jzz")
keymap("n", "<M-S-k>", "10kzz")

-- search in middle
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

--telescope
keymap("n", "<leader>ff", function() snacks.picker.files() end, opts)
keymap("n", "<leader><leader>",function () snacks.picker.files() end, opts)
keymap("n", "<leader>fw",function() snacks.grep() end, opts)

keymap("n", "<leader>lf", function() vim.lsp.buf.format() end, opts)
keymap("n", "<leader>lr", function() vim.lsp.buf.rename() end, opts)
keymap("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
keymap("n", "<leader>lm", ":Mason<cr>", opts)

vim.cmd("vnoremap im aBoV")
vim.cmd('nnoremap "" vi"')
vim.cmd("vnoremap am aBjoV")


keymap("n", "<leader>e", function() snacks.explorer() end, opts)









