function! loci#GetLocation()
  return expand('%') . ':' . line('.') . ':' . col('.') . ':' . '['.input('Label (optional): ').'] '. getline('.')
endfunction

" See: https://www.reddit.com/r/vim/comments/9iwr41/store_quickfix_list_as_a_file_and_load_it/
function! loci#ReadLociFile(file) abort
  let l:efm = &l:efm
  let &l:errorformat = "%-G%f:%l: All of '%#%.depend'%.%#,%f%.%l col %c%. %m"
  execute 'cfile '.a:file
  let &l:efm = l:efm
endfunction

function! loci#WriteLociFile(file) abort
  copen
  execute 'write! '.a:file
endfunction
