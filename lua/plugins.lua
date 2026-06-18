local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    rocks = { hererocks = false },

    -- Catppuccin цветовая схема
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                background = {
                    light = "latte",
                    dark = "mocha",
                },
                transparent_background = false,
                show_end_of_buffer = false,
                term_colors = false,
                dim_inactive = {
                    enabled = false,
                    shade = "dark",
                    percentage = 0.15,
                },
                no_italic = false,
                no_bold = false,
                no_underline = false,
                styles = {
                    comments = { "italic" },
                    conditionals = { "italic" },
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                },
                color_overrides = {},
                custom_highlights = {},
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    telescope = true,
                    treesitter = true,
                    markdown = true,
                    lsp_trouble = false,
                },
            })
        end,
    },

    -- Which-key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
            win = { border = "single" },
        },
        keys = {
            { "<leader>?", function() require("which-key").show() end, desc = "Show all keymaps" },
        },
    },


    -- Управление LSP серверами
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
        end,
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({ defaults = { layout_strategy = "horizontal" } })
        end,
    },

    -- Автодополнение
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                }),
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                },
                window = {
                    completion = {
                        -- Ограничиваем высоту списка
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                        max_height = 15,    -- Ограничение высоты
                        max_width = 80,     -- Ограничение ширины
                        scrollbar = false,  -- Прокрутка при достижении лимита
                    },
                    documentation = {
                        max_height = 20,
                        max_width = 60,
                        border = "single",  -- Рамка вокруг окна документации
                    },
                },
            })
        end,
    },

    -- Автоматическое закрытие скобок, кавычек и т.д.
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({
                -- Основные настройки (можно оставить по умолчанию)
                check_ts = true,  -- Использовать treesitter для проверки контекста
                ts_config = {
                    lua = { "string" },  -- Не добавлять пары в строках Lua
                    javascript = { "template_string" },
                    java = { false },
                },
                fast_wrap = {
                    map = "<M-e>",  -- Клавиша для быстрого переноса в скобках
                    chars = { "{", "[", "(", '"', "'" },
                    pattern = [=[[%'%"%>%]%)%}%,]]=],
                    offset = 0,
                    end_key = "$",
                    keys = "qwertyuiopzxcvbnmasdfghjkl",
                    check_comma = true,
                    highlight = "PmenuSel",
                    highlight_grey = "LineNr",
                },
            })

            -- Интеграция с nvim-cmp (автодополнение)
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },

    -- Табы
    {
        'romgrk/barbar.nvim',
        dependencies = {
          -- 'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
          'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
          auto_hide = true,
          tabpages = false,
          animation = false,
          -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
          -- animation = true,
          -- insert_at_start = true,
          -- …etc.
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },

  -- Дашбоард
  {
      'MeanderingProgrammer/dashboard.nvim',
      event = 'VimEnter',
      config = function()
          -- Импортируем ASCII арт из отдельного файла
          local ascii = require('ascii.dashboard')
          
          require('dashboard').setup({
              bo = {
                  bufhidden = 'wipe',
                  buflisted = false,
                  filetype = 'dashboard',
                  swapfile = false,
              },
              wo = {
                  cursorcolumn = false,
                  cursorline = false,
                  number = false,
                  relativenumber = false,
                  spell = false,
                  statuscolumn = '',
                  wrap = false,
                  foldcolumn = '0',
                  signcolumn = 'no',
                  colorcolumn = '0',
              },
              directories = {},
              header = ascii.dashboard2,  -- Используем импортированный ASCII арт
              date_format = '%Y-%m-%d %H:%M',
              footer = { 'version', 'startuptime' },
              highlight_groups = {
                  header = 'Constant',
                  icon = 'Type',
                  directory = 'Delimiter',
                  hotkey = 'Statement',
              },
              on_load = function(path)
                  vim.cmd('bdelete!')
              end,
          })
      end,
  },

})
