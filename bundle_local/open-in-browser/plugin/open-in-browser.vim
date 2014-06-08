if exists('g:loaded_openinbrowser') && g:loaded_openinbrowser
    finish
endif
let g:loaded_openinbrowser = 1
let s:save_cpo = &cpo
set cpo&vim

function! OpenInBrowser()
  let url = expand('<cWORD>')
  let url = substitute(url, '<\(.*\)>',   '\1', '')
  let url = substitute(url, '"\(.*\)"',   '\1', '')
  let url = substitute(url, '''\(.*\)''', '\1', '')
  let url = substitute(url, '\(.*\),$',   '\1', '')

  " Easy to open neobundle urls
  if url =~# '^\w*\/[a-zA-Z][a-zA-Z0-9_.-]*$'
    let url = 'https://github.com/' . url
  endif

  " Check if url is valid
  if url =~#     '\(\(https\?\|ftp\|git\)://\)\?'
             \ . '[a-zA-Z0-9][a-zA-Z0-9_-]*'
             \ . '\(\.[a-zA-Z0-9][a-zA-Z0-9_-]*\)\+\(:\d\+\)\?'
             \ . '\(/[a-zA-Z0-9_/.+%#?&=;@$,!''*~-]*\)\?'
    silent execute '!xdg-open ' . shellescape(url,1) . '&'
  endif
endfunction

nnoremap <silent> <Plug>(open-in-browser) :call OpenInBrowser()<cr>

let &cpo = s:save_cpo
