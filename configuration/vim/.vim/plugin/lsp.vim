" Protect against multiple loading
if exists('g:loaded_lsp')
  finish
endif
let g:loaded_lsp = 1

" Show errors inline
let g:lsp_diagnostics_echo_cursor = 1

" Tweak the initialisation params to null the process id
" to allow for LSP servers running in a different process
" namespace to this client
function! <SID>NullifyProcess(init_params) abort
  let a:init_params['processId'] = v:null
  return a:init_params
endfunction

if executable('lsp-python')
  autocmd User lsp_setup call lsp#register_server({
        \   'name': 'lsp-python',
        \   'cmd': { server_info->['lsp-python'] },
        \   'allowlist': ['python'],
        \ })
endif

if executable('lsp-csharp')
  autocmd User lsp_setup call lsp#register_server({
        \   'name': 'lsp-csharp',
        \   'cmd': { server_info->['lsp-csharp'] },
        \   'allowlist': ['cs'],
        \   'before_init': function('<SID>NullifyProcess'),
        \ })
endif

if executable('lsp-json')
  autocmd User lsp_setup call lsp#register_server({
        \   'name': 'lsp-json',
        \   'cmd': { server_info->['lsp-json'] },
        \   'allowlist': ['json'],
        \   'before_init': function('<SID>NullifyProcess'),
        \ })
endif

if executable('solargraph')
  autocmd User lsp_setup call lsp#register_server({
        \   'name': 'solargraph',
        \   'cmd': { server_info->['solargraph', 'stdio'] },
        \   'allowlist': ['ruby'],
        \   'initialization_options': {
        \     'completion': 'true',
        \     'hover': 'true',
        \     'symbols': 'true',
        \     'definitions': 'true',
        \     'rename': 'true',
        \     'references': 'true',
        \     'diagnostics': 'true',
        \     'formatting': 'true',
        \     'folding': 'true',
        \     'highlights': 'true',
        \   },
        \ })
elseif executable('lsp-ruby')
  autocmd User lsp_setup call lsp#register_server({
        \   'name': 'lsp-ruby',
        \   'cmd': { server_info->['lsp-ruby'] },
        \   'allowlist': ['ruby'],
        \   'initialization_options': {
        \     'completion': 'true',
        \     'hover': 'true',
        \     'symbols': 'true',
        \     'definitions': 'true',
        \     'rename': 'true',
        \     'references': 'true',
        \     'diagnostics': 'true',
        \     'formatting': 'true',
        \     'folding': 'true',
        \     'highlights': 'true',
        \   },
        \ })
endif

if executable('typescript-language-server')
  autocmd User lsp_setup call lsp#register_server({
        \   'name': 'typescript-language-server',
        \   'cmd': { server_info->['typescript-language-server', '--stdio'] },
        \   'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json')) },
        \   'allowlist': ['javascript', 'typescript', 'typescript.tsx', 'typescriptreact'],
        \   'before_init': function('<SID>NullifyProcess'),
        \ })
elseif executable('lsp-typescript')
  autocmd User lsp_setup call lsp#register_server({
        \   'name': 'lsp-typescript',
        \   'cmd': { server_info->['lsp-typescript'] },
        \   'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json')) },
        \   'allowlist': ['javascript', 'typescript', 'typescript.tsx', 'typescriptreact'],
        \   'before_init': function('<SID>NullifyProcess'),
        \ })
endif

if executable('rust-analyzer')
  autocmd User lsp_setup call lsp#register_server({
        \   'name': 'rust-analyzer',
        \   'cmd': { server_info->['rust-analyzer'] },
        \   'whitelist': ['rust'],
        \   'initialization_options': {
        \     'cargo': {
        \       'loadOutDirsFromCheck': v:true,
        \     },
        \     'procMacro': {
        \       'enable': v:true,
        \     },
        \   },
        \ })
elseif executable('lsp-rust')
  autocmd User lsp_setup call lsp#register_server({
        \   'name': 'lsp-rust',
        \   'cmd': { server_info->['lsp-rust'] },
        \   'whitelist': ['rust'],
        \   'initialization_options': {
        \     'cargo': {
        \       'loadOutDirsFromCheck': v:true,
        \     },
        \     'procMacro': {
        \       'enable': v:true,
        \     },
        \   },
        \ })
endif

if executable('kotlin-language-server')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'kotlin-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'kotlin-language-server']},
        \ 'whitelist': ['kotlin']
        \ })
endif
