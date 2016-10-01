if exists("g:loaded_mocha_only")
  finish
endif
let g:loaded_mocha_only = 1

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

function! s:clearonlyfrombuffer()
  let lineNumber = line('^')
  let lastLineNumber = line('$')

  while lineNumber <  lastLineNumber
    let line = getline(lineNumber)
    let newline = substitute(line, g:only_string, '', '')

    if (line != newline)
      call setline(lineNumber, newline)
    endif

    let lineNumber += 1
  endwhile

endfunction

function! s:AddOnly()
  let line = getline('.')

  let result = s:find_target(line, '\s*(')
  if result
    " remove all other only statements in the file
    call s:clearonlyfrombuffer()
    let newline = strpart(line, 0, result)
      \ . g:only_string
      \ . strpart(line, result)
    call setline('.', newline)
    return 1
  endif

  return 0
endfunction

function! s:RemoveOnly()
  let line = getline('.')

  let result = s:find_target(line, g:only_string . '\s*(')
  if result
    let newline = strpart(line, 0, result)
      \ . strpart(line, result + strlen(g:only_string))
    call setline('.', newline)

    return 1
  endif

  return 0
endfunction

function! s:ToggleOnly()
  if s:AddOnly()
    return 1
  endif

  if s:RemoveOnly()
    return 1
  endif

  echo 'Not a mocha only target.'
  return 0
endfunction

command! MochaOnlyAdd call s:AddOnly()
command! MochaOnlyRemove call s:RemoveOnly()
command! MochaOnlyToggle call s:ToggleOnly()
