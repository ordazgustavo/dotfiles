" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time("Luarocks path setup", true)
local package_path_str = "/Users/gustavoordaz/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/gustavoordaz/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/gustavoordaz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/gustavoordaz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/gustavoordaz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time("Luarocks path setup", false)
time("try_loadstring definition", true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

time("try_loadstring definition", false)
time("Defining packer_plugins", true)
_G.packer_plugins = {
  ["barbar.nvim"] = {
    loaded = true,
    path = "/Users/gustavoordaz/.local/share/nvim/site/pack/packer/start/barbar.nvim"
  },
  ["completion-nvim"] = {
    loaded = true,
    path = "/Users/gustavoordaz/.local/share/nvim/site/pack/packer/start/completion-nvim"
  },
  ["format.nvim"] = {
    commands = { "Format", "FormatWrite" },
    config = { "require'config.formatters'" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/gustavoordaz/.local/share/nvim/site/pack/packer/opt/format.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "require'config.gitsigns'" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/gustavoordaz/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim"
  },
  ["lsp-trouble.nvim"] = {
    commands = { "LspTroubleToggle" },
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\ftrouble\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/gustavoordaz/.local/share/nvim/site/pack/packer/opt/lsp-trouble.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/Users/gustavoordaz/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim"
  },
  ["lualine.nvim"] = {
    config = { "require'config/lualine'" },
    loaded = true,
    path = "/Users/gustavoordaz/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["nvim-lspconfig"] = {
    config = { "require'config.lsp'" },
    loaded = true,
    path = "/Users/gustavoordaz/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/Users/gustavoordaz/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/Users/gustavoordaz/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "require'config.treesitter'" },
    loaded = true,
    path = "/Users/gustavoordaz/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/gustavoordaz/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/gustavoordaz/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/gustavoordaz/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/gustavoordaz/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["rust.vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/gustavoordaz/.local/share/nvim/site/pack/packer/opt/rust.vim"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    config = { "require'config.telescope'" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/gustavoordaz/.local/share/nvim/site/pack/packer/opt/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/Users/gustavoordaz/.local/share/nvim/site/pack/packer/start/tokyonight.nvim"
  },
  ["typescript-vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/gustavoordaz/.local/share/nvim/site/pack/packer/opt/typescript-vim"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/gustavoordaz/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-fugitive"] = {
    commands = { "Git", "G" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/gustavoordaz/.local/share/nvim/site/pack/packer/opt/vim-fugitive"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/gustavoordaz/.local/share/nvim/site/pack/packer/start/vim-surround"
  }
}

time("Defining packer_plugins", false)
-- Setup for: telescope.nvim
time("Setup for telescope.nvim", true)
require'config.telescope_setup'
time("Setup for telescope.nvim", false)
-- Config for: nvim-treesitter
time("Config for nvim-treesitter", true)
require'config.treesitter'
time("Config for nvim-treesitter", false)
-- Config for: nvim-lspconfig
time("Config for nvim-lspconfig", true)
require'config.lsp'
time("Config for nvim-lspconfig", false)
-- Config for: lualine.nvim
time("Config for lualine.nvim", true)
require'config/lualine'
time("Config for lualine.nvim", false)

-- Command lazy-loads
time("Defining lazy-load commands", true)
vim.cmd [[command! -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file LspTroubleToggle lua require("packer.load")({'lsp-trouble.nvim'}, { cmd = "LspTroubleToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Git lua require("packer.load")({'vim-fugitive'}, { cmd = "Git", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file G lua require("packer.load")({'vim-fugitive'}, { cmd = "G", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Format lua require("packer.load")({'format.nvim'}, { cmd = "Format", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file FormatWrite lua require("packer.load")({'format.nvim'}, { cmd = "FormatWrite", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
time("Defining lazy-load commands", false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time("Defining lazy-load filetype autocommands", true)
vim.cmd [[au FileType toml ++once lua require("packer.load")({'rust.vim'}, { ft = "toml" }, _G.packer_plugins)]]
vim.cmd [[au FileType rust ++once lua require("packer.load")({'rust.vim'}, { ft = "rust" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript ++once lua require("packer.load")({'typescript-vim'}, { ft = "typescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescriptreact ++once lua require("packer.load")({'typescript-vim'}, { ft = "typescriptreact" }, _G.packer_plugins)]]
time("Defining lazy-load filetype autocommands", false)
  -- Event lazy-loads
time("Defining lazy-load event autocommands", true)
vim.cmd [[au BufEnter * ++once lua require("packer.load")({'gitsigns.nvim'}, { event = "BufEnter *" }, _G.packer_plugins)]]
time("Defining lazy-load event autocommands", false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time("Sourcing ftdetect script at: /Users/gustavoordaz/.local/share/nvim/site/pack/packer/opt/typescript-vim/ftdetect/typescript.vim", true)
vim.cmd [[source /Users/gustavoordaz/.local/share/nvim/site/pack/packer/opt/typescript-vim/ftdetect/typescript.vim]]
time("Sourcing ftdetect script at: /Users/gustavoordaz/.local/share/nvim/site/pack/packer/opt/typescript-vim/ftdetect/typescript.vim", false)
time("Sourcing ftdetect script at: /Users/gustavoordaz/.local/share/nvim/site/pack/packer/opt/rust.vim/ftdetect/rust.vim", true)
vim.cmd [[source /Users/gustavoordaz/.local/share/nvim/site/pack/packer/opt/rust.vim/ftdetect/rust.vim]]
time("Sourcing ftdetect script at: /Users/gustavoordaz/.local/share/nvim/site/pack/packer/opt/rust.vim/ftdetect/rust.vim", false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
