return {
  {
    'neanias/everforest-nvim',
    -- lazy = false,
    -- priority = 1000,
    enabled = false,
    config = function()
      require('everforest').setup {
        background = 'hard',
        diagnostic_virtual_text = 'grey',
        on_highlights = function(hl, palette)
          hl.Red = { fg = palette.red, bold = true }
          hl.TSInclude = { fg = palette.red, bold = true }
          hl.javascriptTSInclude = { fg = palette.red, bold = true }
          hl.typescriptTSInclude = { fg = palette.red, bold = true }
          hl.goTSInclude = { fg = palette.red, bold = true }
          hl.TSFunction = { fg = palette.green, bold = true }
          hl.TSFunctionCall = { fg = palette.green, bold = true }
          hl.TSMethodCall = { fg = palette.green, bold = true }
          hl.CurrentWord = { underline = true }
        end,
        -- transparent_background_level = 1,
      }
      -- vim.cmd.colorscheme 'everforest'
    end,
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
      flavour = 'macchiato',
      background = {
        light = 'latte',
        dark = 'macchiato',
      },
      styles = {
        functions = { 'bold' },
        keywords = { 'bold' },
      },
      integrations = {
        mason = true,
        mini = {
          enabled = true,
        },
      },
      highlight_overrides = {
        all = function(colors)
          return {
            MiniStatuslineFileinfo = { bg = colors.surface0 },
            MiniStatuslineDevinfo = { bg = colors.surface0 },
          }
        end,
      },
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  {
    'olimorris/onedarkpro.nvim',
    -- lazy = false,
    -- priority = 1000,
    enabled = false,
    config = function()
      require('onedarkpro').setup {}
      -- vim.cmd.colorscheme 'onedark'
    end,
  },
}
