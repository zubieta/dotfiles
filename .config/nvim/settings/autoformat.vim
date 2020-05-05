nnoremap <Leader>F :Autoformat<CR>
vnoremap <Leader>F :Autoformat<CR>
nnoremap <Leader>R :<C-u>RemoveTrailingSpaces<CR>
vnoremap <Leader>R :RemoveTrailingSpaces<CR>

augroup autoformat_on_save
  autocmd!
  " Only format known filetypes
  autocmd BufWrite * if !empty(&filetype) | :Autoformat | endif
augroup END
