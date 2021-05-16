local telescope = require'telescope'
local actions = require'telescope.actions'

telescope.setup {
	defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
		initial_mode = "insert",
		layout_strategy = 'flex',
		scroll_strategy = 'cycle',
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		}
	},
}
