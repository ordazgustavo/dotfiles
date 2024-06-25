vim.cmd [[ hi clear ]]

vim.o.bg = 'dark'

local colors = {
  bg = '#18171B',
  fg = '#FFFFFF',
  invisibles = '#424D5B',
  border = '#000000',
  selection = '#343C4B',
  line = '#23252B',
  comment = '#6C7987',

  green0 = '#7CB554',
  orange0 = '#FC7467',
  orange1 = '#FD8F3F',
  yellow = '#D0BC56',
  pink = '#FC6BAA',
  blue = '#42B8E0',
  blue1 = '#5DD8FF',
  purple0 = '#C08AFF',
  purple1 = '#DEC1FF',
  teal = '#72BFAE',
  teal1 = '#A4FBE6',
}

--- @param name string Highlight group name, e.g. "ErrorMsg"
--- @param val vim.api.keyset.highlight Highlight definition map, accepts the following keys:
local function hi(name, val)
  vim.api.nvim_set_hl(0, name, val)
end

hi('Normal', { bg = colors.bg, fg = colors.fg })
hi('EndOfBuffer', { bg = colors.bg, fg = colors.invisibles })

-- Group names :h group-name
hi('Comment', { fg = colors.comment })

hi('Constant', { fg = colors.blue })
hi('String', { fg = colors.orange0 })
hi('Character', { fg = colors.yellow })
hi('Number', { fg = colors.yellow })
hi('Boolean', { fg = colors.pink })
hi('Number', { fg = colors.yellow })

hi('Identifier', { fg = colors.blue })
hi('Function', { fg = colors.blue })

hi('Statement', { fg = colors.pink, bold = true })

hi('Preproc', { fg = colors.orange1 })

hi('Type', { fg = colors.purple1 })
hi('Structure', { fg = colors.purple0 })

hi('Special', { fg = colors.purple1 })
hi('Delimiter', { fg = colors.fg })

-- UI :h highlight-groups
hi('Changed', { fg = colors.blue1 })
hi('CursorLine', { bg = colors.line })
hi('Directory', { fg = colors.purple1 })
hi('StatusLine', { bg = colors.bg })
hi('VertSplit', { fg = colors.border })
hi('Visual', { bg = colors.selection, bold = true })
hi('VisualNOS', { bg = colors.selection, bold = true })
hi('WinSeparator', { fg = colors.border, bold = true })
hi('IlluminatedWordText', { bg = colors.selection })
hi('IlluminatedWordWrite', { bg = colors.selection })
hi('IlluminatedWordRead', { bg = colors.selection })

-- Treesitter
hi('@constructor', { link = 'Statement' })

-- hi('@variable', { fg = colors.blue })
hi('@variable.builtin', { link = 'Statement' })
hi('@variable.parameter', { fg = colors.blue })
hi('@variable.member', { fg = colors.teal })

hi('@function.call', { fg = colors.teal })
-- hi('@function.method.call', { fg = colors.purple0 })

hi('@tag', { fg = colors.teal1 })
hi('@tag.builtin', { fg = colors.purple0 })
hi('@tag.attribute', { fg = colors.purple1 })
hi('@tag.delimiter', { fg = colors.fg })

-- LSP
-- hi('@lsp.type.property', { fg = colors.teal0 })
-- hi('@lsp.type.function', { fg = colors.teal0 })
-- hi('@lsp.typemod.function.readonly', { fg = colors.purple1 })
-- hi('@lsp.typemod.function.declaration', { fg = colors.blue })
-- hi('@lsp.type.property', { link = '@variable.member' })
-- hi('@lsp.typemod.property.declaration', { link = '@variable.member' })
hi('@lsp.type.enumMember', { link = '@variable.member' })
hi('@lsp.typemod.class.declaration', { fg = colors.blue1 })
