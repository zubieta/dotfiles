let g:ale_open_list = 1
let g:ale_list_window_size = 5
" Disable ale completion
let g:ale_completion_enabled = 0

nmap <silent> ]l <Plug>(ale_next_wrap)
nmap <silent> [l <Plug>(ale_previous_wrap)

augroup ale_autocommands
  autocmd!
  " Close loclist on buffer close
  autocmd QuitPre * if empty(&buftype) | lclose | endif
  " Disable linting for read-only unless changed
  autocmd BufReadPost * if &readonly || !&modifiable | :ALEDisableBuffer | endif
  autocmd FileChangedRO * :ALEEnableBuffer
augroup END
