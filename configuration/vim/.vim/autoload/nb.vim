" Insert link from nb
function! nb#InsertLink() abort
  let l:tempname = tempname()
  try
    execute 'silent ! nb-pick-link > ' . fnameescape(l:tempname)
    " Insert text returned into file below cursor position
    execute 'read ' . l:tempname
    redraw!
  finally
    call delete(l:tempname)
  endtry
endfunction
