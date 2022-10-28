" Display navigable file outline in new buffer (uses Redir)
function! outline#ShowOutline()
  let filetype = &ft

  " Default to vaguely sensible generic keywords
  let keywords = ['class', 'function']

  " Try to find language specific keywords
  if has_key(g:outline_filetype_keywords, &filetype)
    let keywords = g:outline_filetype_keywords[&filetype]
  endif

  let pattern = join(keywords, '\|')
  execute 'Redir global /\v\C<('.pattern.')>/'

  " Highlight selected lines as same filetype
  execute 'setfiletype' filetype
endfunction

" Display navigable file outline in local list
function! outline#ShowLocalOutline()
  " Default to vaguely sensible generic keywords
  let keywords = ['class', 'function']

  " Try to find language specific keywords
  if has_key(g:outline_filetype_keywords, &filetype)
    let keywords = g:outline_filetype_keywords[&filetype]
  endif

  let pattern = join(keywords, '\|')
  let query = '\C\<\('.pattern.'\)\>'

  let filepath = @%

  " Print lines in errorformat (with leading whitespace preserved via prefix)
  let linefmt = '%s:%d:1:%s'
  let invisibleSpace = '　'
  let Formattext = { lineno, val ->
        \ substitute( val, '^ *\ze[^ ]', invisibleSpace . repeat(' ', 5 - strlen(lineno)).'│ &', '' )
        \}
  let fmtexpr = 'printf(linefmt, filepath, v:key+1, Formattext(v:key+1, v:val))'

  " Use matching lines as local list
  let lines = getline(1, '$')
  let transform = 'v:val =~ query ? '.fmtexpr.' : ""'
  let filteredlines = filter(map(lines, transform), 'len(v:val)')

  " TODO: Try to update existing list if it exists
  call setloclist(0, [], 'r', {'lines' : filteredlines, 'title': 'File outline'})

  " Open the list (:lne, :lp, :lopen, :lcl to navigate and close the list)
  lopen
  setlocal nowrap  " Expect long lines, mainly the beginning is interesting
endfunction
