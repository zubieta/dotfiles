augroup gitignore_filetype
  autocmd!
  autocmd BufNewFile,BufRead .gitignore set filetype=gitignore
  autocmd BufNewFile,BufRead */.config/git/ignore,*/.gitignore.d/** if expand('<afile>:e') == '' | set filetype=gitignore
augroup END
