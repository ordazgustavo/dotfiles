syntax on

set exrc
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set relativenumber
set noerrorbells
set nohlsearch
set hidden
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set clipboard=unnamed
set scrolloff=8
set completeopt=menuone,noinsert,noselect
set termguicolors
set signcolumn=yes
set colorcolumn=80
set cmdheight=2

set updatetime=50

highlight ColorColum ctermbg=0 guibg=lightgray
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guifg=NONE ctermfg=NONE

filetype plugin indent on

call plug#begin(stdpath('data') . './plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'

Plug 'folke/tokyonight.nvim'
" Plug 'ghifarit53/tokyonight-vim'
" Plug 'gruvbox-community/gruvbox'
" Plug 'joshdick/onedark.vim'

Plug 'sheerun/vim-polyglot'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'leafgarland/typescript-vim'
Plug 'mbbill/undotree'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

Plug 'rust-lang/rust.vim'

" Plug 'itchyny/lightline.vim'
Plug 'hoob3rt/lualine.nvim'

Plug 'ryanoasis/vim-devicons'

call plug#end()


if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" let g:tokyonight_style = 'storm' " available: night, storm
" let g:tokyonight_enable_italic = 0
" let g:tokyonight_transparent_background = 0
" let g:lightline = {'colorscheme' : 'tokyonight'}
" colorscheme tokyonight

" set background=dark
" let g:gruvbox_contrast_dark = 'hard'
" let g:lightline = {'colorscheme' : 'gruvbox'}
" colorscheme gruvbox

if executable('rg')
    let g:rg_derive_root='true'
endif

let mapleader = " "
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

"" Usefull window mappings
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>

nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>

"" Git fugitive mappings
nmap <leader>gs :G<CR>
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>

"" LSP mappings
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0 <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

"" Telescope mappings
nnoremap <c-p> :lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').lsp_references{ shorten_path = true }<cr>
nnoremap <leader>fd <cmd>lua require('telescope.builtin').lsp_document_diagnostics()<cr>

"" Rust config
let g:rustfmt_autosave = 1

augroup cleanup
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

lua <<EOF
vim.g.tokyonight_style = "storm"
vim.cmd[[colorscheme tokyonight]]

require('lualine').setup {
    options = {
        theme = 'tokyonight'
    }
}

local lspconfig = require'lspconfig'

local on_attach = require'completion'.on_attach

lspconfig.vimls.setup { on_attach=on_attach }
lspconfig.tsserver.setup { on_attach=on_attach }
lspconfig.rls.setup {
    on_attach=on_attach,
    settings = {
        rust = {
            unstable_features = true,
            build_on_save = false,
            all_features = true,
        },
    },
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
  indent = {
    enabled = true,
  }
}

require('telescope').setup {
  defaults = {
    shorten_path = true -- currently the default value is true
  }
}
EOF

