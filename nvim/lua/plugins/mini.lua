return {
  {
    'echasnovski/mini.nvim',
    config = function()
      local spec_treesitter = require('mini.ai').gen_spec.treesitter
      require('mini.ai').setup {
        custom_textobjects = {
          a = spec_treesitter { a = '@parameter.outer', i = '@parameter.inner' },
          F = spec_treesitter { a = '@function.outer', i = '@function.inner' },
          c = spec_treesitter { a = '@class.outer', i = '@class.inner' },
          o = spec_treesitter {
            a = { '@conditional.outer', '@loop.outer' },
            i = { '@conditional.inner', '@loop.inner' },
          },
        },
      }

      -- require('mini.completion').setup()
      require('mini.diff').setup {
        view = {
          style = 'sign',
        },
      }

      require('mini.git').setup()

      local statusline = require 'mini.statusline'
      statusline.setup()
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_fileinfo = function()
        return '%y %P'
      end
    end,
  },
}
