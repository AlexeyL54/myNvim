local mappings = require('mappings')

local M = {}

function M.setup()

  -- Глобальные настройки LSP
  vim.lsp.config['*'] = {
    capabilities = {
      textDocument = {
        completion = {
          completionItem = {
            snippetSupport = true,
            documentationFormat = { 'markdown', 'plaintext' }
          }
        }
      }
    }
  }

  -- Сервер для C/C++
  vim.lsp.config.clangd = {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp' },
    root_markers = { 'compile_commands.json', '.git' },
    settings = { clangd = { arguments = { '--background-index' } } }
  }

  -- Python
  vim.lsp.config.pyright = {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'setup.py', '.git' },
    settings = {
      python = {
        analysis = { typeCheckingMode = 'basic' }
      }
    }
  }

  -- TypeScript/JavaScript
  vim.lsp.config.tsserver = {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
    root_markers = { 'tsconfig.json', 'package.json', '.git' }
  }

  -- Go
  vim.lsp.config.gopls = {
    cmd = { 'gopls' },
    filetypes = { 'go' },
    root_markers = { 'go.mod', '.git' },
    settings = {
      gopls = { analyses = { unusedparams = true } }
    }
  }

  -- Rust (rust-analyzer)
  vim.lsp.config.rust_analyzer = {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml', '.git' },
    settings = {
      ['rust-analyzer'] = {
        -- Автоматическое обновление зависимостей
        checkOnSave = false,
        -- Включить все функции
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
        },
        -- Автодополнение
        completion = {
          autoimport = { enable = true },
        },
        -- Диагностика
        diagnostics = {
          enable = true,
          experimental = { enable = true },
        },
      }
    }
  }

  -- Включаем серверы
    vim.lsp.enable('clangd')
    vim.lsp.enable('pyright')
    vim.lsp.enable('tsserver')
    vim.lsp.enable('gopls')
    vim.lsp.enable('rust_analyzer')

  -- Подключаем LSP-маппинги через autocommand
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      mappings.lsp_on_attach(client, args.buffer)
    end,
  })
end

return M
