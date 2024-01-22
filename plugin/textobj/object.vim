if exists('g:loaded_textobj_object')
  finish
endif

let g:loaded_textobj_object = 1

call textobj#user#plugin('object', {
\   '*sfile*': expand('<sfile>:p'),
\	  'key': {
\     'select-i': 'ik',
\     'select-a': 'ak',
\     '*select-i-function*': 's:elect_key_i',
\     '*select-a-function*': 's:select_key_a',
\   },
\})
" const s:newRegex = '.*:[a-zA-Z0-9а-яА-ЯЁё\s{}]*[\s,]?\n/'

function! s:select_key_i()
"    let save_pos = getpos(".")
	" let save_line = getline(".")
    " normal! 0
    " let splitter = s:get_splitter()
    " let [lnum, column] = searchpos('/\v.*' .. splitter)

    " echo "lnum: " .. lnum
	" echo "col: " .. column



    " normal! l
    " let c = getpos('.')
    " if abs(c[1] - save_pos[1]) > 2
    "     call setpos('.', save_pos)
    "     normal! l
    "     return
    " endif
    " let [b, e] = [c, c]
    " call search('["' .. "']" .. "\\s*" .. splitter)
    " normal! h
    " let e = getpos('.')
  return ['v', 1, 2]
endfunction

function! s:select_key_a()  "{{{2
    let save_pos = getpos(".")
    normal! 0
    let splitter = s:get_splitter()
    call search('\S\+\s*' . splitter)
    let c = getpos('.')
    if abs(c[1] - save_pos[1]) > 2
        call setpos('.', save_pos)
        normal! l
        return
    endif
    let [b, e] = [c, c]
    call search('\S\s*' . splitter, '', line('.'))
    let e = getpos('.')
  return ['v', b, e]
endfunction

let s:splitter_map = {
\    'vim'        : ':',
\    'javascript' : ':',
\    'javascript.jsx' : ':',
\    'json'       : ':',
\    'coffee'     : ':',
\    'python'     : ':',
\    'perl'       : '=>',
\    'lua'        : '=',
\    'default'    : '='
\}

function! s:get_splitter()
    let ft = &filetype

    if has_key(s:splitter_map, ft)
        return s:splitter_map[ft]
    endif

    return s:splitter_map['default']
endfunction


