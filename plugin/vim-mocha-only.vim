" if exists("g:loaded_mocha_only") || &cp || v:version < 700
"   finish
" endif
" let g:loaded_mocha_only = 1

let g:mocha_only_targets = [ 'describe', 'it' ]
let g:only_string = '.only'

function! s:find_target( line, exp )

  for target in g:mocha_only_targets
    let result = match(a:line, target . a:exp)
    if result != -1
      return result + strlen(target)
    endif
  endfor

   return 0
endfunction

function! s:AddOnly()
  let line = getline('.')

  let result = s:find_target(line, '\s*(')
  if result
    " TODO: remove all other only statement in the file
    let newline = strpart(line, 0, result)
      \ . g:only_string
      \ . strpart(line, result)
    call setline('.', newline)
  endif
endfunction

function! s:RemoveOnly()
  let line = getline('.')

  let result = s:find_target(line, g:only_string . '\s*(')
  if result
    " magic number 5 == strlen('.only')
    let newline = strpart(line, 0, result)
      \ . strpart(line, result + strlen(g:only_string))
    call setline('.', newline)
  endif
endfunction

command! MochaOnlyAdd call s:AddOnly()
command! MochaOnlyRemove call s:RemoveOnly()
