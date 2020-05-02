setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal nofoldenable
setlocal foldmethod=syntax
let b:formatdef_jq = '"jq --indent " . &shiftwidth'
let b:formatters_json = [
      \'jq',
      \'js_beautify_json',
      \'fixjson',
      \'prettier',
      \]
