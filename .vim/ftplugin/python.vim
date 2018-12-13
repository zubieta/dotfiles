setlocal colorcolumn=72,79
let b:ale_fixers = {'python': ['black', 'isort', 'remove_trailing_lines', 'trim_whitespace']}
let b:ale_linters = {'python': ['pylint', 'pycodestyle', 'pydocstyle', 'mypy']}
