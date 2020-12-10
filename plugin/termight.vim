let g:term_buf_list = [0, 0, 0, 0]

nnoremap <leader>1 :call OpenTerm(1)<CR>
nnoremap <leader>2 :call OpenTerm(2)<CR>
nnoremap <leader>3 :call OpenTerm(3)<CR>
nnoremap <leader>4 :call OpenTerm(4)<CR>

fun! CreateTerm()
  lua for k in pairs(package.loaded) do if k:match("^buf%-manager") then package.loaded[k] = nil end end
  lua require("termight").createTermBuffer();
endfun

fun! OpenTerm(idx)
  let g:idx = a:idx
  lua for k in pairs(package.loaded) do if k:match("^buf%-manager") then package.loaded[k] = nil end end
  lua require("termight").openTerm();
endfun

fun! CloseTerm()
  lua for k in pairs(package.loaded) do if k:match("^buf%-manager") then package.loaded[k] = nil end end
  lua require("termight").closeTerm();
endfun

augroup YourFirstPlugin
  autocmd!
augroup END
