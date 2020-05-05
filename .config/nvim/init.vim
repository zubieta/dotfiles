"""" General settings

" Disable modelines for security reasons
" https://security.stackexchange.com/questions/36001/vim-modeline-vulnerabilities
set nomodeline
set modelines=0

""" Commands
" <Leader>
let mapleader=','
" Change LocalLeader key to ;
let maplocalleader=';'
" Disable Help with F1 key
noremap  <F1> <Esc>
inoremap <F1> <Esc>

""" UI config
" Show syntax highlighting
syntax on
" Dark background
set background=dark
" Enable 256 color support
set t_Co=256
" Enable true colors
if has('termguicolors')
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
" Always show status line
set laststatus=2
" Turn off bell
set novisualbell t_vb=0
" Show "@@@" at the end of the last line cannot be displayed completely
"display+=lastline
" Show colored columns
set colorcolumn=60,80
" Show numbers ruler
set number
" Make numbers relative to current line
set relativenumber
" Show spaces, tabs, newlines
set list


""" Search config
" Highlight all matches for a search
set hlsearch
" Temporarily show the next match interactively as the search is done
set incsearch


""" System integration
" clipboard
set clipboard=unnamedplus


""" Spaces, tabs, newlines and indentation
" Convert tabs to spaces
set expandtab
" Make tabs 4 spaces wide
set tabstop=4
set softtabstop=4
set shiftwidth=4
" Insert only one space after a sentence when joining (J)
set nojoinspaces
" Apply same indentation when newline is inserted
set autoindent


"" Spell checking
" Enable spell checking
set spell
" Make english the default language
set spelllang=en_us


""" NeoVim plugin providers
" Disable Ruby and NodeJS provider
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0


""" Enable filetype detection and specific plugins and indentation rules
filetype plugin indent on

""" Miscellaneous
" Tmux theme from airline
let g:tmuxline_preset = {
      \ 'a'       : '#S',
      \ 'win'     : ['#I', '#W'],
      \ 'cwin'    : ['#I', '#W#F'],
      \ 'x'       : '#{prefix_highlight}',
      \ 'y'       : ['%R', '%Y-%m-%d'],
      \ 'z'       : '#h',
      \ 'options' : {'status-justify': 'left'},
      \}
let g:tmuxline_theme = {
      \ 'a'     : [ 234, 190, 'none' ],
      \ 'b'     : [ 085, 234, 'none' ],
      \ 'c'     : [ 085, 234, 'none' ],
      \ 'win'   : [ 085, 234, 'none' ],
      \ 'cwin'  : [ 255, 238, 'bold' ],
      \ 'x'     : [ 234, 234, 'none' ],
      \ 'y'     : [ 255, 238, 'none' ],
      \ 'z'     : [ 234, 190, 'none' ],
      \ 'bg'    : [ 234, 234, 'none' ],
      \ 'pane'  : [ 240, 240, 'none' ],
      \ 'cpane' : [ 190, 190, 'none' ],
      \}

" Load plugin settings
for s:fpath in split(globpath('~/.config/nvim/settings', '*.vim'), '\n')
  exe 'source' s:fpath
endfor
" Load system specific configurations
silent! source ~/.config/nvim/local.vim
