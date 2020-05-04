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
  "
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
  " Cmake completion
  " call minpac#add('richq/vim-cmake-completion')
  " Syntax highlighting
  call minpac#add('sheerun/vim-polyglot')
  " Editor settings
  call minpac#add('editorconfig/editorconfig-vim')

  """ Other Integrations
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
  " Killer sheep game
  call minpac#add('vim/killersheep', {'type': 'opt'})
endif

""" Plugin configuration
" Define minpac commands
command! PackUpdate packadd minpac | source $MYVIMRC |
      \ call minpac#update('', {
      \   'do': 'silent! helptags ALL | call minpac#status()'
      \ })
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()
