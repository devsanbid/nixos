vim.g.mapleader = " "
vim.g.big_file = { size = 1024 * 5000, lines = 50000 } -- Must be set before lazy_manager loads plugin specs
require("lazy_manager")
require("config")

