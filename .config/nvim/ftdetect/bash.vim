augroup bash_filetype
  autocmd!
  autocmd BufNewFile,BufRead */.bash.d/** if expand('<afile>:e') == '' | set filetype=bash
augroup END
