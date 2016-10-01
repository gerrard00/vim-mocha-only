" if exists("g:loaded_mocha_only") || &cp || v:version < 700
"   finish
" endif
" let g:loaded_mocha_only = 1

let g:_mocha_only_targets = [ 'describe', 'it' ]

function! s:find_target( line, exp )

  for target in g:_mocha_only_targets
    let result = match(a:line, target . a:exp)
    if result != -1
      echom result
      return result + strlen(target)
    endif
  endfor

   return 0
endfunction

function! s:AddOnly()
  let line = getline('.')

  let result = s:find_target(line, '\s*(')
  if result
    let newline = strpart(line, 0, result)
      \ . '.only'
      \ . strpart(line, result)
    call setline('.', newline)
  endif
endfunction

command! MochaOnlyAdd call s:AddOnly()
