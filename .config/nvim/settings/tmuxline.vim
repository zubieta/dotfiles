let g:tmuxline_preset = {
      \ 'a'       : '#S',
      \ 'win'     : ['#I', '#W'],
      \ 'cwin'    : ['#I', '#W#F'],
      \ 'x'       : '#{prefix_highlight}',
      \ 'y'       : ['%R', '%Y-%m-%d'],
      \ 'z'       : '#h',
      \ 'options' : {'status-justify': 'left'},
      \}
let g:tmuxline_theme = {
      \ 'a'     : [ 234, 190, 'none' ],
      \ 'b'     : [ 085, 234, 'none' ],
      \ 'c'     : [ 085, 234, 'none' ],
      \ 'win'   : [ 085, 234, 'none' ],
      \ 'cwin'  : [ 255, 238, 'bold' ],
      \ 'x'     : [ 234, 234, 'none' ],
      \ 'y'     : [ 255, 238, 'none' ],
      \ 'z'     : [ 234, 190, 'none' ],
      \ 'bg'    : [ 234, 234, 'none' ],
      \ 'pane'  : [ 240, 240, 'none' ],
      \ 'cpane' : [ 190, 190, 'none' ],
      \}
