local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "plugins" },
    { import = "plugins/language" }
}, {
    change_detection = {
        enabled = true,
        notify = false, -- get a notification when changes are found
    }
})


require("lspconfig").nixd.setup({
    cmd = { "nixd" },
    settings = {
        nixd = {
            nixpkgs = {
                expr = "import <nixpkgs> { }",
            },
            formatting = {
                command = { "alejandra" }, -- or nixfmt or nixpkgs-fmt
            },
            options = {
                nixos = {
                    expr = '(builtins.getFlake "/home/sanbid/.dotfiles/").nixosConfigurations.sanbid.options',
                },
                home_manager = {
                    expr = '(builtins.getFlake "/home/sanbid/.dotfiles/").homeConfigurations.sanbid.options',
                },
            },
        },
    },
})
