let g:deoplete#enable_at_startup = 1

if exists('*deoplete#custom#option')
  call deoplete#custom#option({'auto_complete_popup': 'manual'})
endif

function! s:check_back_space() abort
  let l:col = col('.') - 1
  return !l:col || getline('.')[l:col - 1] =~# '\s'
endfunction

inoremap <silent><expr><TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#complete()
