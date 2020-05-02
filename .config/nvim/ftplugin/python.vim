setlocal colorcolumn=72,79
let b:ale_fixers = [
      \'black',
      \'isort',
      \'remove_trailing_lines',
      \'trim_whitespace'
      \]
let b:ale_linters = [
      \'pylint',
      \'pycodestyle',
      \'pydocstyle',
      \'mypy',
      \'vulture'
      \]
let b:ale_python_auto_pipenv = 1
let pipenv_venv_path = system('pipenv --venv')
let b:ale_python_black_use_global = 1
let b:ale_python_isort_use_global = 1
let b:ale_python_mypy_use_global = 1
