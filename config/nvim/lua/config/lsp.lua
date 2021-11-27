local lsp_installer = require("nvim-lsp-installer")

local sign_define = vim.fn.sign_define
sign_define('LspDiagnosticsSignError', {text = '', texthl = 'LspDiagnosticsDefaultError'})
sign_define('LspDiagnosticsSignWarning', {text = '', texthl = 'LspDiagnosticsDefaultWarning' })
sign_define('LspDiagnosticsSignInformation', {text = '', texthl = 'LspDiagnosticsDefaultInformation' })
sign_define('LspDiagnosticsSignHint', {text = '', texthl = 'LspDiagnosticsDefaultHint' })

-- Enable diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
    underline = true,
  }
)
vim.o.completeopt='menuone,noinsert,noselect'
vim.lsp.protocol.CompletionItemKind = {
  '   (Text) ',
  '   (Method)',
  '   (Function)',
  '   (Constructor)',
  ' ﴲ  (Field)',
  '[] (Variable)',
  '   (Class)',
  ' ﰮ  (Interface)',
  '   (Module)',
  ' 襁 (Property)',
  '   (Unit)',
  '   (Value)',
  ' 練 (Enum)',
  '   (Keyword)',
  ' ﬌  (Snippet)',
  '   (Color)',
  '   (File)',
  '   (Reference)',
  '   (Folder)',
  '   (EnumMember)',
  ' ﲀ  (Constant)',
  ' ﳤ  (Struct)',
  '   (Event)',
  '   (Operator)',
  '   (TypeParameter)'
}

local on_attach = function(client, bufnr)
  -- setup lsp completion
  require 'completion'.on_attach(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Mappings
  local opts = {noremap = true, silent = true}
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'g[', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', 'g]', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)

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
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local servers = {
  sumneko_lua = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  },
  -- diagnosticls = {
  --   filetypes = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact'},
  --   init_options = {
  --     linters = {
  --       eslint = {
  --         command = 'eslint_d',
  --         debounce = 100,
  --         args = {
  --           '--f',
  --           'unix',
  --           '--stdin',
  --           '--stdin-filename',
  --           '%filepath',
  --           '--format',
  --           'json'
  --         },
  --         sourceName = 'eslint',
  --         parseJson = {
  --           errorsRoot = '[0].messages',
  --           line = 'line',
  --           column = 'column',
  --           endLine = 'endLine',
  --           endColumn = 'endColumn',
  --           message = '${message} [${ruleId}]',
  --           security = 'severity'
  --         },
  --         securities = {
  --           [2] = 'error',
  --           [1] = 'warning',
  --         },
  --       },
  --     },
  --     filetypes = {
  --       javascript = 'eslint',
  --       javascriptreact = 'eslint',
  --       typescript = 'eslint',
  --       typescriptreact = 'eslint',
  --     },
  --   }
  -- }
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

-- Merges two tables
local function merge(left, right)
  for k,v in pairs(right) do left[k] = v end
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = make_config()

    -- (optional) Customize the options passed to the server
    if servers[server.name] then
        merge(opts, servers[server.name])
    end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)

