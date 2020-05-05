augroup gitignore_filetype
  autocmd!
  autocmd BufNewFile,BufRead .gitignore,*/.config/git/ignore,.gitignore.d/** set filetype=gitignore
augroup END
