local telescope = require'telescope'
local actions = require'telescope.actions'

telescope.setup {
  defaults = {
    prompt_position = 'top',
    prompt_prefix = ' ',
    sorting_strategy = 'ascending',
    selection_caret = ' ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    layout_strategy = 'flex',
    scroll_strategy = 'cycle',
    winblend = 20,
    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    }
  },
}
