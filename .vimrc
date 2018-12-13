"""" General settings

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
let g:loaded_ruby_provider = 1
let g:loaded_node_provider = 1


""" Enable filetype detection and specific plugins and indentation rules
filetype plugin indent on


""" Plugin installation
" Install minpac if not available
if has('nvim')
  let s:cfgdir = exists($XDG_CONFIG_HOME) ? $XDG_CONFIG_HOME : $HOME . '/.config'
  let s:optdir = s:cfgdir . '/nvim/pack/minpac/opt'
else
  let s:optdir = $HOME . '/.vim/pack/minpac/opt'
endif
if !isdirectory(s:optdir)
  call mkdir(s:optdir, 'p', 0700)
  execute '!git clone https://github.com/k-takata/minpac.git ' . s:optdir . '/minpac'
endif

" No minpac, no plugins installation
if exists('*minpac#init')
  " start minpac
  call minpac#init()

  """ General packages
  " Manage minpac itself
  call minpac#add('k-takata/minpac', {'type': 'opt'})
  " Sensible Vim configuration
  call minpac#add('tpope/vim-sensible')
  " Allow plugins to use the . command
  call minpac#add('tpope/vim-repeat')
  " Replace 'surroundings' pairs (),"",[],etc.
  call minpac#add('tpope/vim-surround')

  """ UI
  " Color theme
  call minpac#add('morhetz/gruvbox')
  " Rulers themes
  call minpac#add('vim-airline/vim-airline')
  call minpac#add('vim-airline/vim-airline-themes')
  " Show indentation guides
  call minpac#add('nathanaelkane/vim-indent-guides')

  """ Code editing
  " Code autoformatter
  call minpac#add('Chiel92/vim-autoformat')
  " Alignemnet
  call minpac#add('godlygeek/tabular')
  " Comment out code
  call minpac#add('tpope/vim-commentary')
  " Language Server Client
  call minpac#add('w0rp/ale')
  " Completion
  call minpac#add('Shougo/deoplete.nvim')
  if !has('nvim')
    " Extra packages required to work on vim
    call minpac#add('roxma/nvim-yarp')
    call minpac#add('roxma/vim-hug-neovim-rpc')
  endif
  " Python completion
  call minpac#add('zchee/deoplete-jedi')
  call minpac#add('richq/vim-cmake-completion')

  """ Integrations
  " Direnv integration
  call minpac#add('direnv/direnv.vim')
  " Git interaction
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('airblade/vim-gitgutter')

  """ Miscellaneous
  " Prompt theme from airline
  call minpac#add('edkolev/promptline.vim', {'type': 'opt'})
  " Tmux theme from airline
  call minpac#add('edkolev/tmuxline.vim', {'type': 'opt'})
endif

""" Plugin configuration
" Define minpac commands
command! PackUpdate packadd minpac | source $MYVIMRC |
      \ call minpac#update('', {
      \   'do': 'silent! helptags ALL | call minpac#status()'
      \ })
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()

" Load sensible only for vim
if has('nvim')
  let g:loaded_sensible=0
endif

" Set the color scheme
let g:gruvbox_contrast_dark = 'hard'
silent! colorscheme gruvbox
" Adjust QuickFixLine to match gruvbox
if exists('g:colors_name') && g:colors_name ==? 'gruvbox'
  highlight QuickFixLine term=reverse ctermbg=237 guibg=#3c3836
endif

" Rulers config
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#ale#enabled = 1

" Indentation guidelines
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1

"" Code editing
" Auto-formatting
nnoremap <Leader>F :Autoformat<CR>
vnoremap <Leader>F :Autoformat<CR>
nnoremap <Leader>R :<C-u>RemoveTrailingSpaces<CR>
vnoremap <Leader>R :RemoveTrailingSpaces<CR>
augroup writehooks
  autocmd!
  autocmd BufWrite * :Autoformat
  autocmd BufWritePre * :RemoveTrailingSpaces
augroup END
command! SkipWriteHooks noautocmd w

"" Code linting
let g:ale_open_list = 1
let g:ale_list_window_size = 5
nmap <silent> ]l <Plug>(ale_next_wrap)
nmap <silent> [l <Plug>(ale_previous_wrap)
augroup ale_close_loclist
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

" Completion
let g:ale_completion_enabled = 0
let g:deoplete#enable_at_startup = 1
" Enable tab completion for deoplete
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~? '\s'
endfunction"}}}
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()

" Load system specific configurations
silent! source .vimrc_local
