vim.opt.clipboard = "unnamedplus" -- подключить буффер к системе
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.luasnip_disable_jsregexp_warning = 1

-- Загрузка модулей
require('plugins')

-- Цветовая схема
-- Установка цветовой схемы после загрузки lazy.nvim, 
-- но до отображения интерфейса
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        pcall(vim.cmd.colorscheme, "catppuccin-mocha")
    end,
})

-- Загрузка модулей
require('mappings').setup()
require('lsp').setup()
