local actions = require'telescope.actions'
local u = require'utils'

require'telescope'.setup {
	defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
		initial_mode = "insert",
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		}
	},
}

vim.g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy' }

-- Telescope mappings
u.remap('n', '<C-p>', [[<cmd>lua require('telescope.builtin').find_files()<cr>]])
u.remap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<cr>]])
u.remap('n', '<leader>l', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]])
u.remap('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]])
u.remap('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]])
u.remap('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]])
u.remap('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<cr>]])
u.remap('n', '<leader>gp', [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]])
u.remap('n', '<leader>fr', [[<cmd>lua require('telescope.builtin').lsp_references {shorten_path=true}<cr>]])
u.remap('n', '<leader>fd', [[<cmd>lua require('telescope.builtin').lsp_diagnostics()<cr>]])
