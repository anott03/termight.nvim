let g:term_buf_list = [0, 0, 0, 0]

:command -nargs=1 OpenTerm :call OpenTerm(<args>)
:command -nargs=1 RunShellCommand :call RunShellCommand(<args>)

fun! OpenTerm(idx)
  let g:idx = a:idx
  lua require("termight").openTerm();
endfun

fun! RunShellCommand(cmd)
  let g:termight_cmd = a:cmd
  lua require("termight").runShellCommand()
endfun

augroup YourFirstPlugin
  autocmd!
augroup END
