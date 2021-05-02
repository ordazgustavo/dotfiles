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
        -- {cmd = {"prettier -w"}},
        {cmd = {"./node_modules/.bin/eslint --fix"}}
    },
	typescriptreact = {
        -- {cmd = {"prettier -w"}},
        {cmd = {"./node_modules/.bin/eslint --fix"}}
    },
}
