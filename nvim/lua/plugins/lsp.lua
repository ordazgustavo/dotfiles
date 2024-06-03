local global_snippets = {
  { trigger = 'shebang', body = '#!/bin sh' },
}

local snippets_by_filetype = {
  lua = {
    { trigger = 'function', body = 'function ${1:name}(${2:args})\n  $0\nend' },
  },
  javascript = {
    { trigger = 'function', body = 'function ${1:name}(${2:arg}) {\n  $0\n}' },
  },
  javascriptreact = {
    { trigger = 'function', body = 'function ${1:name}(${2:arg}) {\n  $0\n}' },
  },
  typescript = {
    { trigger = 'function', body = 'function ${1:name}(${2:arg}:${3:type}) {\n  $0\n}' },
  },
  typescriptreact = {
    { trigger = 'function', body = 'function ${1:name}(${2:arg}:${3:type}) {\n  $0\n}' },
  },
}

local function get_buf_snips()
  local ft = vim.bo.filetype
  local snips = vim.list_slice(global_snippets)

  if ft and snippets_by_filetype[ft] then
    vim.list_extend(snips, snippets_by_filetype[ft])
  end

  return snips
end

-- cmp source for snippets to show up in completion menu
local function register_cmp_source()
  local cmp_source = {}
  local cache = {}
  function cmp_source.complete(_, _, callback)
    local bufnr = vim.api.nvim_get_current_buf()
    if not cache[bufnr] then
      local completion_items = vim.tbl_map(function(s)
        ---@type lsp.CompletionItem
        local item = {
          word = s.trigger,
          label = s.trigger,
          kind = vim.lsp.protocol.CompletionItemKind.Snippet,
          insertText = s.body,
          insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
          documentation = { kind = 'markdown', value = '*test*' },
        }
        return item
      end, get_buf_snips())

      cache[bufnr] = completion_items
    end

    callback(cache[bufnr])
  end

  require('cmp').register_source('snp', cmp_source)
end

return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {},
  },
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = false,
    dependencies = {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        tsserver = {
          settings = {
            completions = {
              completeFunctionCalls = true,
            },
          },
        },
        jsonls = {
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require('schemastore').json.schemas())
          end,
          settings = {
            json = {
              format = { enable = false },
              validate = { enable = true },
            },
          },
        },
        eslint = {
          settings = {
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            workingDirectories = { mode = 'auto' },
          },
        },

        lua_ls = {
          -- cmd = {...},
          -- filetypes { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'prettierd',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('lspconfig').sourcekit.setup { capabilities = capabilities }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-T>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          map('<leader>dh', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, '[D]ocument [H]ints')

          -- Fuzzy find all the symbols in your current workspace
          --  Similar to document symbols, except searches over your whole project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        end,
      })
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- {
      --   'rafamadriz/friendly-snippets',
      --   config = function()
      --     require('luasnip.loaders.from_vscode').lazy_load()
      --   end,
      -- },
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      {
        'zbirenbaum/copilot-cmp',
        config = function()
          require('copilot_cmp').setup()
        end,
      },
      'onsails/lspkind.nvim',
    },
    config = function()
      register_cmp_source()

      local cmp = require 'cmp'

      cmp.setup {
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        window = {
          completion = {
            side_padding = 0,
            col_offset = -3,
          },
        },
        -- view = {
        --   docs = {
        --     auto_open = false,
        --   },
        -- },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if vim.snippet.active { direction = 1 } then
              vim.snippet.jump(1)
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if vim.snippet.active { direction = -1 } then
              vim.snippet.jump(-1)
            end
          end, { 'i', 's' }),
          ['<C-g>'] = function()
            if cmp.visible_docs() then
              cmp.close_docs()
            else
              cmp.open_docs()
            end
          end,
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'copilot' },
          { name = 'snp' },
          { name = 'path' },
        },
        formatting = {
          format = require('lspkind').cmp_format {
            mode = 'symbol',
            maxwidth = 40,
            ellipsis_char = '...',
            show_labelDetails = true,
          },
        },
      }
    end,
  },

  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>cf',
        mode = 'n',
        function()
          require('conform').format { async = true }
        end,
        desc = '[C]ode [F]ormat',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = {
          c = true,
          cpp = true,
          javascript = true,
          javascriptreact = true,
          typescript = true,
          typescriptreact = true,
        }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        css = { 'prettierd' },
        handlebars = { 'prettierd' },
        html = { 'prettierd' },
        graphql = { 'prettierd' },
        javascript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        json = { 'prettierd' },
        json5 = { 'prettierd' },
        jsonc = { 'prettierd' },
        less = { 'prettierd' },
        lua = { 'stylua' },
        markdown = { 'prettierd' },
        ['markdown.mdx'] = { 'prettierd' },
        sass = { 'prettierd' },
        scss = { 'prettierd' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        vue = { 'prettierd' },
        yaml = { 'prettierd' },
      },
    },
  },

  {
    'b0o/SchemaStore.nvim',
    lazy = true,
    version = false,
  },

  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      filetypes_denylist = { 'oil' },
    },
    config = function(_, opts)
      require('illuminate').configure(opts)

      vim.keymap.set('n', ']r', function()
        require('illuminate').goto_next_reference(false)
      end, { desc = 'Go to next [R]eference' })
      vim.keymap.set('n', '[r', function()
        require('illuminate').goto_prev_reference(false)
      end, { desc = 'Go to prev [R]eference' })
    end,
  },
}
