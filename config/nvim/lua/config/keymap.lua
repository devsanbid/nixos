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

vim.keymap.set("n", "<C-n>", ":keepjumps normal! mi*`i<CR>") -- " Use * to add w/out jumping
vim.keymap.set("n", "gx", ":silent! execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>")

vim.keymap.set("n", "c", '"_c', { noremap = true })
vim.keymap.set("n", "C", '"_C', { noremap = true })
vim.keymap.set("n", "cc", '"_cc', { noremap = true })
vim.keymap.set("v", "c", '"_c', { noremap = true })

-- buffer
keymap("n", "<leader>c", ":bdelete<cr>", opts)

-- file action
keymap("n", "<leader>w", ":w<cr>", opts)

-- up and down
keymap("n", "<M-S-j>", "8jzz")
keymap("n", "<M-S-k>", "8kzz")

-- center while searching
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "<leader>x", "gg_dG")

--telescope
keymap("n", "<leader>ff", function()
	require("snacks").picker.files()
end, opts)

keymap("n", "<leader><leader>", function()
	require("snacks").picker.files()
end, opts)

keymap("n", "<leader>fH", ":Telescope help_tags<cr>", opts)
keymap("n", "<leader>fr", ":Telescope oldfiles<cr>", opts)
keymap("n", "<leader>fh", ":Telescope highlights<cr>", opts)
keymap("n", "<leader>fp", ":Telescope yank_history<cr>")

keymap("n", "<leader>lf", function()
	vim.lsp.buf.format()
end, opts)

keymap("n", "<leader>lr", function()
	vim.lsp.buf.rename()
end, opts)

keymap("n", "<leader>la", function()
	vim.lsp.buf.code_action()
end, opts)
keymap("n", "<leader>li", ":LspInfo<cr>", opts)
keymap("n", "<leader>lI", ":LspInstall<cr>", opts)
keymap("n", "<leader>lm", ":Mason<cr>", opts)

vim.cmd("vnoremap im aBoV")
vim.cmd('nnoremap "" vi"')
vim.cmd("vnoremap am aBjoV")

keymap("n", "<leader>lr", function()
	vim.lsp.buf.rename()
end, opts)

keymap("n", "<leader>w", ":w<cr>")
keymap("n", "<leader>E", function()
	local oil = require("oil")
	if vim.bo.filetype == "oil" then
		oil.close()
	else
		oil.open()
	end
end)
