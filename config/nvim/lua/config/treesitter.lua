require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'bash',
    'css',
    'html',
    'graphql',
    'javascript',
    'jsdoc',
    'json',
    'jsonc',
    'lua',
    'python',
    'regex',
    'rust',
    'toml',
    'tsx',
    'typescript',
    'yaml',
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
}
