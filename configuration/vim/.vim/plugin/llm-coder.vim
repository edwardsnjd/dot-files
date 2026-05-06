if exists('g:loaded_llm_coder')
  finish
endif
let g:loaded_llm_coder = 1

" Commands:
command!        LlmCoderDiscussFile       set noshelltemp | exec "%               write ! llm-coder"
command!        LlmCoderChangeFile        set noshelltemp | exec "%                     ! llm-coder" | redraw!
command! -range LlmCoderDiscussSelection  set noshelltemp | exec "<line1>,<line2> write ! llm-coder"
command! -range LlmCoderChangeSelection   set noshelltemp | exec "<line1>,<line2>       ! llm-coder" | redraw!

" Mappings:
nnoremap <Plug>(LlmCoderDiscussFile)      :LlmCoderDiscussFile<CR>
nnoremap <Plug>(LlmCoderChangeFile)       :LlmCoderChangeFile<CR>
vnoremap <Plug>(LlmCoderDiscussSelection) :LlmCoderDiscussSelection<CR>
vnoremap <Plug>(LlmCoderChangeSelection)  :LlmCoderChangeSelection<CR>
