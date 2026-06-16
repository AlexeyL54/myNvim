local M = {}

-- Главная функция, которая применяет все маппинги
function M.setup()
  local opts = { silent = true }

  -- Глобальный лидер (можете сменить на пробел)
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  -- Базовые навигационные маппинги (без LSP-специфики)
  vim.keymap.set('n', '<C-h>', '<C-w>h', opts)  -- Перемещение между окнами
  vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
  vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
  vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

  -- Поиск и замена
  vim.keymap.set('n', '<leader>sr', ':%s//g<left><left>', opts)  -- Поиск-замена
  vim.keymap.set('n', '<leader>sc', ':nohlsearch<CR>', opts)     -- Снять подсветку

  -- Буферы
  vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', opts)        -- Закрыть буфер
  vim.keymap.set('n', '<leader>bn', ':bnext<CR>', opts)          -- Следующий буфер
  vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', opts)      -- Предыдущий буфер

  -- Файлы
  vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', opts)
  vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
  
  -- Сохранение и выход
  vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
  -- vim.keymap.set('n', '<leader>w', ':write<CR>', opts)
  vim.keymap.set('n', '<leader>q', ':quit<CR>', opts)
  
  -- Term mode (если используете встроенный терминал)
  vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', opts)

  -- Диагностика (показ ошибок)
vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { desc = 'Show diagnostic in float' })
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic' })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Show diagnostics in location list' })

end

-- Функция для LSP-специфичных маппингов (вызывается из lsp.lua)
function M.lsp_on_attach(client, buffer)
  local opts = { buffer = buffer, silent = true }

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
  
  -- Форматирование
  vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format({ async = true })
  end, opts)
end

return M
