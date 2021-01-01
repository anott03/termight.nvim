let g:term_buf_list = [0, 0, 0, 0]

:command -nargs=1 OpenTerm :call OpenTerm(<args>)

fun! OpenTerm(idx)
  let g:idx = a:idx
  lua require("termight").openTerm();
endfun

augroup YourFirstPlugin
  autocmd!
augroup END
