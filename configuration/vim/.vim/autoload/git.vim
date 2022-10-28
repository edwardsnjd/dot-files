function! git#ReplaceWithPerson() abort
  let l:selected = git#Contributor()
  execute "normal! gvc\<C-r>=l:selected\<cr>"
endfunction

" Select person from git
function! git#Contributor() abort
  let l:tempname = tempname()
  try
    execute 'silent ! git contributor > ' . fnameescape(l:tempname)
    " Return any person selected (without new line)
    let l:output = readfile(l:tempname, '', 1)
    return len(l:output) > 0 ? l:output[0] : v:null
  finally
    call delete(l:tempname)
    redraw!
  endtry
endfunction
