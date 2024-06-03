return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'windwp/nvim-ts-autotag',
  },
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'css',
      'gitcommit',
      'html',
      'javascript',
      'json',
      'jsonc',
      'json5',
      'lua',
      'markdown',
      'markdown_inline',
      'regex',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'yaml',
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']m'] = { query = '@function.outer', desc = 'Next function start' },
          [']c'] = { query = '@class.outer', desc = 'Next class start' },
        },
        goto_previous_start = {
          ['[m'] = { query = '@function.outer', desc = 'Prev function start' },
          ['[c'] = { query = '@class.outer', desc = 'Prev class start' },
        },
      },
      lsp_interop = {
        enable = true,
        border = 'none',
        floating_preview_opts = {},
        peek_definition_code = {
          ['<leader>df'] = '@function.outer',
          ['<leader>dF'] = '@class.outer',
        },
      },
    },
  },
  config = function(_, opts)
    require('nvim-ts-autotag').setup {
      opts = {
        enable_close = true,
        enable_rename = false,
        enable_close_on_slash = true, -- Auto close on trailing </
      },
    }
    require('nvim-treesitter.configs').setup(opts)
  end,
}
