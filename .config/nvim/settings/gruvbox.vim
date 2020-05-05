" Set the color scheme
let g:gruvbox_contrast_dark = 'hard'
silent! colorscheme gruvbox
" Adjust QuickFixLine to match gruvbox
if exists('g:colors_name') && g:colors_name ==? 'gruvbox'
  highlight QuickFixLine term=reverse ctermbg=237 guibg=#3c3836
endif
