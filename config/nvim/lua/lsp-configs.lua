local on_attach = function(client, bufnr)
	-- setup lsp completion
	require'completion'.on_attach(client, bufnr)

	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	-- Mappings
	local opts = { noremap=true, silent=true }
	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'g[', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', 'g]', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	elseif client.resolved_capabilities.document_range_formatting then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end

	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec([[
		augroup lsp_document_highlight
		autocmd! * <buffer>
		autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
		autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
		augroup END
		]], false)
	end

	-- Add customm signs
	vim.cmd [[ sign define LspDiagnosticsSignError text= texthl=LspTroubleError linehl= numhl= ]]
	vim.cmd [[ sign define LspDiagnosticsSignWarning text= texthl=LspTroubleSignWarning linehl= numhl= ]]
	vim.cmd [[ sign define LspDiagnosticsSignInformation text= texthl=LspTroubleSignInformation linehl= numhl= ]]
	vim.cmd [[ sign define LspDiagnosticsSignHint text= texthl=LspTroubleSignHint linehl= numhl= ]]
end

-- Configure lua language server for neovim development
local lua_settings = {
	Lua = {
		runtime = {
			-- LuaJIT in the case of Neovim
			version = 'LuaJIT',
			path = vim.split(package.path, ';'),
		},
		diagnostics = {
			-- Get the language server to recognize the `vim` global
			globals = {'vim'},
		},
		workspace = {
			-- Make the server aware of Neovim runtime files
			library = {
				[vim.fn.expand('$VIMRUNTIME/lua')] = true,
				[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
			},
		},
	}
}

local eslint_settings = {
	filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
	init_options = {
		linters = {
			eslint = {
				command = './node_modules/.bin/eslint',
				rootPatterns = { '.git' },
				debounce = 100,
				args = {
					'--stdin',
					'--stdin-filename',
					'%filepath',
					'--format',
					'json'
				},
				sourceName = 'eslint',
				parseJson = {
					errorsRoot = '[0].messages',
					line = 'line',
					column = 'column',
					endLine = 'endLine',
					endColumn = 'endColumn',
					message = '${message} [${ruleId}]',
					security = 'severity'
				},
				securities = {
					[2] = 'error',
					[1] = 'warning',
				},
			},
		},
		filetypes = {
			javascript = 'eslint',
			javascriptreact = 'eslint',
			typescript = 'eslint',
			typescriptreact = 'eslint',
		},
	}
}

-- config that activates keymaps and enables snippet support
local function make_config()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	return {
		-- enable snippet support
		capabilities = capabilities,
		-- map buffer local keybindings when the language server attaches
		on_attach = on_attach,
	}
end

-- lsp-install
local function setup_servers()
	local lspinstall = require'lspinstall'
	lspinstall.setup()

	-- get all installed servers
	local servers = lspinstall.installed_servers()

	for _, server in pairs(servers) do
		local config = make_config()

		-- language specific config
		if server == "lua" then
			config.settings = lua_settings
		end

		if server == "diagnosticls" then
			config.filetypes = eslint_settings.filetypes
			config.init_options = eslint_settings.init_options
		end

		require'lspconfig'[server].setup(config)
	end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
	setup_servers() -- reload installed servers
	vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

vim.o.completeopt="menuone,noinsert,noselect"

vim.lsp.protocol.CompletionItemKind = {
	"   (Text) ",
	"   (Method)",
	"   (Function)",
	"   (Constructor)",
	" ﴲ  (Field)",
	"[] (Variable)",
	"   (Class)",
	" ﰮ  (Interface)",
	"   (Module)",
	" 襁 (Property)",
	"   (Unit)",
	"   (Value)",
	" 練 (Enum)",
	"   (Keyword)",
	" ﬌  (Snippet)",
	"   (Color)",
	"   (File)",
	"   (Reference)",
	"   (Folder)",
	"   (EnumMember)",
	" ﲀ  (Constant)",
	" ﳤ  (Struct)",
	"   (Event)",
	"   (Operator)",
	"   (TypeParameter)"
}

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = true,
		signs = true,
		update_in_insert = true,
	}
)
