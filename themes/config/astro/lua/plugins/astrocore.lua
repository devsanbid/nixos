---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 1, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = false, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = false,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "no", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        guicursor = "",
        tabstop = 2,
        softtabstop = 2,
        shiftwidth = 2,
        expandtab = true,
        smartcase = true,
        incsearch = true,
        scrolloff = 16,
        mouse = "",
        colorcolumn = "80",
      },
      g = {},
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      n = {
        ["<Leader><Leader>"] = {
          function()
            require("snacks").picker.files {
              hidden = vim.tbl_get((vim.uv or vim.loop).fs_stat ".git" or {}, "type") == "directory",
            }
          end,
          desc = "open files",
        },

        ["<Leader>e"] = {
          function()
            local oil = require "oil"
            if vim.bo.filetype == "oil" then
              oil.close()
            else
              oil.open()
            end
          end,
        },
      },
    },
  },
}
