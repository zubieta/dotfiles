" Command to return the right virtual/conda env if exists
let s:venv = '$([ -n "${VIRTUAL_ENV+set}" ] && (_TMP="${VIRTUAL_ENV##*/}" && printf "(${_TMP%%-*})") || ([ -n "${CONDA_DEFAULT_ENV+set}" ] && printf "(${CONDA_DEFAULT_ENV})"))'

" Load the custom preset only after promptline plugin is sourced
" so it works with optional packages
augroup promptline
  autocmd!
  autocmd SourcePost */plugin/promptline.vim let g:promptline_preset = {
        \'a' : [s:venv, promptline#slices#host({ 'only_if_ssh': 1 })],
        \'b' : [promptline#slices#user()],
        \'c' : [promptline#slices#cwd({'dir_limit': '${PROMPT_DIRTRIM:-2}'})],
        \'y' : [promptline#slices#git_status(), promptline#slices#vcs_branch()],
        \'warn' : [promptline#slices#last_exit_code()],
        \'options': {
        \'left_sections' : ['a', 'b', 'c', 'y', 'warn'],
        \'right_sections' : [],
        \'left_only_sections' : ['a', 'b', 'c', 'y', 'warn']},
        \}
augroup END
