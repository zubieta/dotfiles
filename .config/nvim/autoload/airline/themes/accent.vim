" Theme   : Accent
" Version : 1.0.0
" License : MIT
" Author  : Carlos Zubieta
" URL     : https://github.com/zubieta/dotfiles/blob/vim/.config/nvim/autoload/airline/themes/accent.vim
"
" Originally based on the 'term' theme by Yauhen Kirylau
" (github.com/actionless)

" Merge two dictionaries, also recursively merging nested keys.
" Function from: https://vi.stackexchange.com/a/20843
fun! s:merge(defaults, override) abort
  let l:new = copy(a:defaults)
  for [l:k, l:v] in items(a:override)
    let l:new[l:k] = (type(l:v) is v:t_dict && type(get(l:new, l:k)) is v:t_dict)
          \ ? s:merge(l:new[l:k], l:v)
          \ : l:v
  endfor
  return l:new
endfun

let s:default_colors = {
      \ 'normal':  {'gui_light': '#8CE10B', 'gui': '#ABE15B', 'term_light': 2, 'term': 10},
      \ 'insert':  {'gui_light': '#FFB900', 'gui': '#FFD242', 'term_light': 3, 'term': 11},
      \ 'visual':  {'gui_light': '#008DF8', 'gui': '#0092FF', 'term_light': 4, 'term': 12},
      \ 'replace': {'gui_light': '#FF000F', 'gui': '#FF2740', 'term_light': 1, 'term': 9},
      \ 'paste':   {'gui': '#444444', 'term': 6},
      \ 'info':    {'gui': '#FFFFFF', 'term': 7},
      \}

function! airline#themes#accent#refresh()
  let l:colors = s:merge(deepcopy(s:default_colors), get(g:, 'airline_accent_colors', {}))

  let l:palette = {}

  " Normal mode
  let l:normal = l:colors.normal
  " [ guifg, guibg, ctermfg, ctermbg, opts ]
  let l:N1 = ['#141413', l:normal.gui_light, 232, l:normal.term_light]   " mode
  let l:N2 = [l:normal.gui_light, 'black', l:normal.term_light, 'black'] " info
  let l:N3 = [l:normal.gui_light, '#242424', l:normal.term_light, 233]   " statusline
  let l:N4 = [l:normal.gui, l:normal.term]                               " mode modified

  " Insert mode
  let l:insert = l:colors.insert
  let l:I1 = ['#141413', l:insert.gui_light, 232, l:insert.term_light]
  let l:I2 = [l:insert.gui_light, 'black', l:insert.term_light, 'black']
  let l:I3 = [l:insert.gui_light, '#242424', l:insert.term_light, 233]
  let l:I4 = [l:insert.gui, l:insert.term]

  " Visual mode
  let l:visual = l:colors.visual
  let l:V1 = ['#141413', l:visual.gui_light, 232, l:visual.term_light]
  let l:V2 = [l:visual.gui_light, 'black', l:visual.term_light, 'black']
  let l:V3 = [l:visual.gui_light, '#242424', l:visual.term_light, 233]
  let l:V4 = [l:visual.gui, l:visual.term]

  " Replace mode
  let l:replace = l:colors.replace
  let l:R1 = ['#141413', l:replace.gui_light, 232, l:replace.term_light]
  let l:R2 = [l:replace.gui_light, 'black', l:replace.term_light, 'black']
  let l:R3 = [l:replace.gui_light, '#242424', l:replace.term_light, 233]
  let l:R4 = [l:replace.gui, l:replace.term]

  " Paste mode
  let l:PA = [l:colors.paste.gui, l:colors.paste.term]

  " Info modified
  let l:IM = [l:colors.info.gui, l:colors.info.term]

  " Inactive mode
  let l:IA = [ '#767676', l:N3[1], 243, l:N3[3], '' ]

  let l:palette.accents = {
        \ 'red': [ '#E5786D', '', 203 , '', '' ],
        \ }

  let l:palette.normal = airline#themes#generate_color_map(l:N1, l:N2, l:N3)
  let l:palette.normal_modified = {
        \ 'airline_a': [ l:N1[0], l:N4[0], l:N1[2], l:N4[1], '' ],
        \ 'airline_b': [ l:N4[0], l:IM[0], l:N4[1], l:IM[1], '' ],
        \ 'airline_c': [ l:N4[0], l:N3[1], l:N4[1], l:N3[3], '' ],
        \ }


  let l:palette.insert = airline#themes#generate_color_map(l:I1, l:I2, l:I3)
  let l:palette.insert_modified = {
        \ 'airline_a': [ l:I1[0], l:I4[0], l:I1[2], l:I4[1], '' ],
        \ 'airline_b': [ l:I4[0], l:IM[0], l:I4[1], l:IM[1], '' ],
        \ 'airline_c': [ l:I4[0], l:N3[1], l:I4[1], l:N3[3], '' ],
        \ }


  let l:palette.visual = airline#themes#generate_color_map(l:V1, l:V2, l:V3)
  let l:palette.visual_modified = {
        \ 'airline_a': [ l:V1[0], l:V4[0], l:V1[2], l:V4[1], '' ],
        \ 'airline_b': [ l:V4[0], l:IM[0], l:V4[1], l:IM[1], '' ],
        \ 'airline_c': [ l:V4[0], l:N3[1], l:V4[1], l:N3[3], '' ],
        \ }


  let l:palette.replace = airline#themes#generate_color_map(l:R1, l:R2, l:R3)
  let l:palette.replace_modified = {
        \ 'airline_a': [ l:R1[0], l:R4[0], l:R1[2], l:R4[1], '' ],
        \ 'airline_b': [ l:R4[0], l:IM[0], l:R4[1], l:IM[1], '' ],
        \ 'airline_c': [ l:R4[0], l:N3[1], l:R4[1], l:N3[3], '' ],
        \ }


  let l:palette.insert_paste = {
        \ 'airline_a': [ l:I1[0], l:PA[0], l:I1[2], l:PA[1], '' ],
        \ 'airline_b': [ l:PA[0], l:IM[0], l:PA[1], l:IM[1], '' ],
        \ 'airline_c': [ l:PA[0], l:N3[1], l:PA[1], l:N3[3], '' ],
        \ }


  let l:palette.inactive = airline#themes#generate_color_map(l:IA, l:IA, l:IA)
  let l:palette.inactive_modified = {
        \ 'airline_c': [ l:N4[0], '', l:N4[1], '', '' ],
        \ }


  if get(g:, 'loaded_ctrlp', 0)
    let palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
          \ [ '#DADADA' , '#242424' , 253 , 234 , ''     ] ,
          \ [ '#DADADA' , '#40403C' , 253 , 238 , ''     ] ,
          \ [ '#141413' , '#DADADA' , 232 , 253 , 'bold' ] )
  endif

  let g:airline#themes#accent#palette = l:palette
endfunction

call airline#themes#accent#refresh()
