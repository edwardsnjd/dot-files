" Protect against multiple loading
if exists('g:loaded_redir')
  finish
endif
let g:loaded_redir = 1

" Redirect the output of a Vim or external command into a scratch buffer
" https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7

" Update the function and command from the gist
" NOTE: This looks for the start and end sentinels so only makes sense to run
" from inside this buffer.
function! UpdateRedirFromWeb()
  /\v^" -+ Redir::Start/+1;/\v^" -+ Redir::End/-1 ! curl
        \ --silent
        \ --location "https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7/raw/ce546f5cdbb954fecc4b0120e3431b64f68d0373/redir.vim"
        \ | sed -E '/command\!/ { /-bar/ \! s/^/" /; }'
  '[,'] retab
endfunction

" ----- Redir::Start
function! Redir(cmd, rng, start, end)
  for win in range(1, winnr('$'))
    if getwinvar(win, 'scratch')
      execute win . 'windo close'
    endif
  endfor
  if a:cmd =~ '^!'
    let cmd = a:cmd =~' %'
      \ ? matchstr(substitute(a:cmd, ' %', ' ' . shellescape(escape(expand('%:p'), '\')), ''), '^!\zs.*')
      \ : matchstr(a:cmd, '^!\zs.*')
    if a:rng == 0
      let output = systemlist(cmd)
    else
      let joined_lines = join(getline(a:start, a:end), '\n')
      let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
      let output = systemlist(cmd . " <<< $" . cleaned_lines)
    endif
  else
    redir => output
    execute a:cmd
    redir END
    let output = split(output, "\n")
  endif
  vnew
  let w:scratch = 1
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
  call setline(1, output)
endfunction

" This command definition includes -bar, so that it is possible to "chain" Vim commands.
" Side effect: double quotes can't be used in external commands
command! -nargs=1 -complete=command -bar -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)

" This command definition doesn't include -bar, so that it is possible to use double quotes in external commands.
" Side effect: Vim commands can't be "chained".
" command! -nargs=1 -complete=command -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)
" ----- Redir::End
