local map = require'utils'.map

vim.g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy' }

-- Telescope mappings
map('n', '<C-p>', [[<cmd>Telescope find_files<cr>]])
map('n', '<leader><leader>', [[<cmd>Telescope buffers<cr>]])
map('n', '<leader>l', [[<cmd>Telescope current_buffer_fuzzy_find<cr>]])
map('n', '<leader>fg', [[<cmd>Telescope live_grep<cr>]])
map('n', '<leader>gc', [[<cmd>Telescope git_commits<cr>]])
map('n', '<leader>gb', [[<cmd>Telescope git_branches<cr>]])
map('n', '<leader>gs', [[<cmd>Telescope git_status<cr>]])
map('n', '<leader>gp', [[<cmd>Telescope git_bcommits<cr>]])
map('n', '<leader>fr', [[<cmd>Telescope lsp_references {shorten_path=true}<cr>]])
map('n', '<leader>fd', [[<cmd>Telescope lsp_diagnostics<cr>]])
map('n', '<leader>wd', [[<cmd>Telescope lsp_workspace_diagnostics<cr>]])
