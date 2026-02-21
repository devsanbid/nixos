vim.g.mapleader = " "
require("lazy_manager")
require("config")

require('java').setup()
require('lspconfig').jdtls.setup({})

