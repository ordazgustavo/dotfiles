return {
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
      { 'hrsh7th/cmp-nvim-lsp', lazy = true },
      { 'hrsh7th/cmp-path', lazy = true },
      { 'hrsh7th/cmp-buffer', lazy = true },
      {
        'zbirenbaum/copilot-cmp',
        lazy = true,
        config = function()
          require('copilot_cmp').setup()
        end,
      },
      { 'onsails/lspkind.nvim', lazy = true },
    },
    config = function()
      -- register_cmp_source()

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
        -- view = { docs = { auto_open = false } },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(), -- Select the [n]ext item
          ['<C-p>'] = cmp.mapping.select_prev_item(), -- Select the [p]revious item
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
          { name = 'buffer' },
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
    'b0o/SchemaStore.nvim',
    lazy = true,
    version = false,
  },
}

-- local global_snippets = {
--   { trigger = 'shebang', body = '#!/bin sh' },
-- }
--
-- local snippets_by_filetype = {
--   lua = {
--     { trigger = 'function', body = 'function ${1:name}(${2:args})\n  $0\nend' },
--   },
--   javascript = {
--     { trigger = 'function', body = 'function ${1:name}(${2:arg}) {\n  $0\n}' },
--   },
--   javascriptreact = {
--     { trigger = 'function', body = 'function ${1:name}(${2:arg}) {\n  $0\n}' },
--   },
--   typescript = {
--     { trigger = 'function', body = 'function ${1:name}(${2:arg}:${3:type}) {\n  $0\n}' },
--   },
--   typescriptreact = {
--     { trigger = 'function', body = 'function ${1:name}(${2:arg}:${3:type}) {\n  $0\n}' },
--   },
-- }
--
-- local function get_buf_snips()
--   local ft = vim.bo.filetype
--   local snips = vim.list_slice(global_snippets)
--
--   if ft and snippets_by_filetype[ft] then
--     vim.list_extend(snips, snippets_by_filetype[ft])
--   end
--
--   return snips
-- end
--
-- -- cmp source for snippets to show up in completion menu
-- local function register_cmp_source()
--   local cmp_source = {}
--   local cache = {}
--   function cmp_source.complete(_, _, callback)
--     local bufnr = vim.api.nvim_get_current_buf()
--     if not cache[bufnr] then
--       local completion_items = vim.tbl_map(function(s)
--         ---@type lsp.CompletionItem
--         local item = {
--           word = s.trigger,
--           label = s.trigger,
--           kind = vim.lsp.protocol.CompletionItemKind.Snippet,
--           insertText = s.body,
--           insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
--           documentation = { kind = 'markdown', value = '*test*' },
--         }
--         return item
--       end, get_buf_snips())
--
--       cache[bufnr] = completion_items
--     end
--
--     callback(cache[bufnr])
--   end
--
--   require('cmp').register_source('snp', cmp_source)
-- end
