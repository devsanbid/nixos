local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- keybinding

keymap("v", "<S-j>", "<Nop>")
keymap("n", "<S-j>", "<Nop>")
keymap("n", "U", "g+")

keymap("n", "p", "p=`]", { silent = true })
keymap("v", "y", "ygv<esc>")

keymap({ "n", "x" }, "j", "gj", opts)
keymap({ "n", "x" }, "k", "gk", opts)

keymap("n", "<C-n>", ":keepjumps normal! mi*`i<CR>") -- " Use * to add w/out jumping
keymap("n", "gx", ":silent! execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>")

-- up and down
keymap("n", "<M-S-j>", "10jzz")
keymap("n", "<M-S-k>", "10kzz")

-- center while searching
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

keymap("n", "<leader>lm", ":Mason<cr>", opts)




