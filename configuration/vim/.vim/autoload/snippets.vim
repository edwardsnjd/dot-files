" Read and insert a snippet from my personal interactive `snippet` script
function! snippets#Insert() abort
  let l:tempname = tempname()
  try
    execute 'silent ! snippet ' . &filetype . ' > ' . fnameescape(l:tempname)
    " Insert text returned into file below cursor position
    execute 'read ' . l:tempname
    redraw!
  finally
    call delete(l:tempname)
  endtry
endfunction
