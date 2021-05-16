local actions = require'telescope.actions'
local map = require'utils'.map

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
map('n', '<C-p>', [[<cmd>lua require('telescope.builtin').find_files()<cr>]])
map('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<cr>]])
map('n', '<leader>l', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]])
map('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]])
map('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]])
map('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]])
map('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<cr>]])
map('n', '<leader>gp', [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]])
map('n', '<leader>fr', [[<cmd>lua require('telescope.builtin').lsp_references {shorten_path=true}<cr>]])
map('n', '<leader>fd', [[<cmd>lua require('telescope.builtin').lsp_diagnostics()<cr>]])
map('n', '<leader>wd', [[<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>]])
