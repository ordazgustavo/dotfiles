local map = require'utils'.map

require 'format'.setup {
	['*'] = {
		{cmd = {"sed -i 's/[ \t]*$//'"}} -- remove trailing whitespace
	},
	javascript = {
        {cmd = {"prettier -w"}}
    },
	javascriptreact = {
        {cmd = {"prettier -w"}}
    },
	typescript = {
        {cmd = {"prettier -w"}},
    },
	typescriptreact = {
        {cmd = {"prettier -w"}},
    },
}

map('n', '<leader>f', '<Cmd>Format<CR>')
