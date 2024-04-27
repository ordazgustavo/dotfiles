local icons = {
  Array = ' ',
  Boolean = ' ',
  Class = ' ',
  Color = ' ',
  Constant = ' ',
  Constructor = ' ',
  Copilot = ' ',
  Enum = ' ',
  EnumMember = ' ',
  Event = ' ',
  Field = ' ',
  File = ' ',
  Folder = ' ',
  Function = ' ',
  Interface = ' ',
  Key = ' ',
  Keyword = ' ',
  Method = ' ',
  Module = ' ',
  Namespace = ' ',
  Null = 'ﳠ ',
  Number = ' ',
  Object = ' ',
  Operator = ' ',
  Package = ' ',
  Property = ' ',
  Reference = ' ',
  Snippet = ' ',
  String = ' ',
  Struct = ' ',
  Text = ' ',
  TypeParameter = ' ',
  Unit = ' ',
  Value = ' ',
  Variable = ' ',
}

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
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                -- Tells lua_ls where to find all the Lua files that you have loaded
                -- for your neovim configuration.
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
                -- If lua_ls is really slow on your computer, you can try this instead:
                -- library = { vim.env.VIMRUNTIME },
              },
              completion = {
                callSnippet = 'Replace',
              },
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

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
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
      { 'folke/neodev.nvim', opts = {} },
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

          -- Fuzzy find all the symbols in your current workspace
          --  Similar to document symbols, except searches over your whole project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

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
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      {
        'zbirenbaum/copilot-cmp',
        config = function()
          require('copilot_cmp').setup()
        end,
      },
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        window = {
          completion = {
            side_padding = 0,
            col_offset = -3,
          },
        },
        view = {
          docs = {
            auto_open = false,
          },
        },

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
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
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
          { name = 'luasnip' },
          { name = 'path' },
        },
        formatting = {
          expandable_indicator = true,
          fields = { 'kind', 'abbr', 'menu' },
          format = function(_, item)
            local kind = string.format('%s %s', icons[item.kind], item.kind)

            -- Move the icon to be on the left side
            local strings = vim.split(kind, '%s', { trimempty = true })
            item.kind = ' ' .. strings[1] .. ' '

            return item
          end,
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
