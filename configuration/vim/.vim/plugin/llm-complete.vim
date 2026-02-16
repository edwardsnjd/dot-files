" Name:
"  llm-complete.vim - Minimal completion plugin
"
" Description:
"  - Produces a suggested completion from the current cursor
"  position by sending it through an external command.
"  - Displays suggestion as virtual text.
"
" Dependencies:
" - Vim 8.0+ with +textprop feature.
" - Shell command for a completion (default: llm-completions).

if exists('g:loaded_llm_complete')
  finish
endif
let g:loaded_llm_complete = 1

" ----------------------
" External configuration
" ----------------------

let g:llm_complete_script = get(g:, 'llm_complete_script', 'llm-completions')
let g:llm_complete_model = get(g:, 'llm_complete_model', 'codellama:7b-code')

" -------------------------
" Enable/disable per buffer
" -------------------------

function! s:EnableCurrentBuffer()
  let b:llm_complete_enabled = 1

  augroup VimAIComplete
    autocmd! * <buffer>
    autocmd InsertLeave <buffer> call s:ClearSuggestion()
    autocmd TextChangedI <buffer> call s:ClearSuggestion()
  augroup END

  call s:EnsureGhostTextProperty()

  echo "AI autocomplete enabled"
endfunction

function! s:DisableCurrentBuffer()
  let b:llm_complete_enabled = 0
  echo "AI autocomplete disabled"
endfunction

function! s:ToggleCurrentBuffer()
  if get(b:, 'llm_complete_enabled', 0)
    call s:DisableCurrentBuffer()
  else
    call s:EnableCurrentBuffer()
  endif
endfunction

" ---------------------
" Ghost text management
" ---------------------

let s:prop_type_defined = 0
let s:prop_type_name = 'llm_complete_ghost_text'

function! s:EnsureGhostTextProperty()
  if s:prop_type_defined
    return
  endif

  if !has('textprop')
    echohl WarningMsg
    echo "vim-ai-complete requires +textprop feature"
    echohl None
    return
  endif

  try
    call prop_type_add(s:prop_type_name, {
          \ 'highlight': 'Comment',
          \ 'priority': 100,
          \ })
  catch /E969/
    " Property type already exists
  endtry

  let s:prop_type_defined = 1
endfunction

function! s:DisplayInlineGhostText(suggestion)
  call prop_add(a:suggestion.line, a:suggestion.col, {
        \ 'type': s:prop_type_name,
        \ 'bufnr': a:suggestion.bufnr,
        \ 'text': a:suggestion.lines[0],
        \ })

  for i in range(1, len(a:suggestion.lines) - 1)
    call prop_add(a:suggestion.line, 0, {
          \ 'type': s:prop_type_name,
          \ 'bufnr': a:suggestion.bufnr,
          \ 'text': a:suggestion.lines[i],
          \ 'text_align': 'below',
          \ })
  endfor
endfunction

function! s:RemoveGhostText(suggestion)
  call prop_remove({
        \ 'type': s:prop_type_name,
        \ 'bufnr': a:suggestion.bufnr,
        \ 'all': 1,
        \ })
endfunction

" -------------------
" AI completion state
" -------------------

function! s:NextSuggestion()
  call s:ClearSuggestion()
  call s:RequestSuggestion()
endfunction

function! s:DisplaySuggestion(suggestion)
  if empty(a:suggestion)
    return
  endif

  let suggestion_lines = split(a:suggestion, "\n", 1)

  let b:llm_complete_suggestion = {
        \ 'lines': suggestion_lines,
        \ 'bufnr': bufnr('%'),
        \ 'line':  line('.'),
        \ 'col':   col('.'),
        \ }

  call s:DisplayInlineGhostText(b:llm_complete_suggestion)
endfunction

function! s:ClearSuggestion()
  if exists('b:llm_complete_suggestion')
    try
      call s:RemoveGhostText(b:llm_complete_suggestion)
    catch
      " Silently fail
    endtry

    unlet b:llm_complete_suggestion
  endif
endfunction

" Accept current suggestion
function! s:AcceptSuggestion()
  if !exists('b:llm_complete_suggestion')
    return
  endif

  let suggestion = b:llm_complete_suggestion
  call s:ClearSuggestion()

  if len(suggestion.lines) > 0
    " Get current suggestion line content
    let current_line_text = getline(suggestion.line)
    let before_cursor = current_line_text[:suggestion.col-2]
    let after_cursor = current_line_text[suggestion.col-1:]

    " Build list of new lines to replace current target line
    let new_lines = copy(suggestion.lines)
    let new_lines[0] = before_cursor . new_lines[0]
    let new_lines[-1] = new_lines[-1] . after_cursor

    " Set the current line (setline), insert any other lines
    call setline(suggestion.line, new_lines[0])
    if len(new_lines) > 1
      call append(suggestion.line, new_lines[1:])
    endif

    " Set cursor to end of last suggested content (on last line)
    let new_cursor_line = suggestion.line + len(new_lines) - 1
    let new_cursor_col = len(new_lines[-1]) - len(after_cursor) + 1
    call cursor(new_cursor_line, new_cursor_col)
  endif
endfunction

function! s:RequestSuggestion()
  if !get(b:, 'llm_complete_enabled', 0)
    return
  endif

  let suggestion = s:ExecuteCompletionRequest()
  if !empty(suggestion)
    call s:DisplaySuggestion(suggestion)
  endif
endfunction

function! s:ExecuteCompletionRequest()
  " Write context to temporary file
  let context = s:GetBufferContextAroundCursor()
  let tmpfile = tempname()
  call writefile(split(context, "\n"), tmpfile)

  " Call external script with context file as stdin
  " Redirect stderr to null to avoid ollama interactive ANSI
  let cmd = printf('%s < %s 2>/dev/null', g:llm_complete_script, tmpfile)
  let suggestion = system(cmd)

  " Clean up
  call delete(tmpfile)

  " Remove trailing whitespace
  return substitute(suggestion, '\v[\n\t ]*$', '', '')
endfunction

function! s:GetBufferContextAroundCursor()
  let line = line('.')
  let col = col('.') - 1

  let start_line = max([1, line - 20])
  let end_line = min([line('$'), line + 5])
  let lines = getline(start_line, end_line)

  " Insert cursor marker at current position
  let cursor_offset = line - start_line
  let current_line = lines[cursor_offset]
  let lines[cursor_offset] = current_line[:col-1] . '<@CURSOR@>' . current_line[col:]

  return join(lines, "\n")
endfunction

" ------------------
" External interface
" ------------------

" Commands:
command! AICompleteEnable call s:EnableCurrentBuffer()
command! AICompleteDisable call s:DisableCurrentBuffer()
command! AICompleteToggle call s:ToggleCurrentBuffer()
command! AICompleteSuggest call s:NextSuggestion()
command! AICompleteAccept call s:AcceptSuggestion()
command! AICompleteDismiss call s:ClearSuggestion()

" Mappings:
inoremap <Plug>(AICompleteSuggest) <Cmd>AICompleteSuggest<CR>
inoremap <Plug>(AICompleteAccept)  <Cmd>AICompleteAccept<CR>
inoremap <Plug>(AICompleteDismiss) <Cmd>AICompleteDismiss<CR>

" Suggested key mappings:
"inoremap <C-x><C-u> <Plug>(AICompleteSuggest)
"inoremap <C-l>      <Plug>(AICompleteSuggest)
"inoremap <C-y>      <Plug>(AICompleteAccept)
"inoremap <C-e>      <Plug>(AICompleteDismiss)
