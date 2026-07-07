" Protect against multiple loading
if exists('g:loaded_lsp')
  finish
endif
let g:loaded_lsp = 1

" Do not start LSP by default, only on demand (can be slow)
" Manually enable with :call lsp#enable()
let g:lsp_auto_enable = 0

" Log LSP messages
" let g:lsp_log_file = expand('~/vim-lsp.log')

" Optionally tweak the initialisation params to null the process id to allow
" for LSP servers running in a different process iff the discovered binary of
" the given name is a descendent of the current PWD.
"
" This is useful because I use little `binstub` wrappers to run commands
" inside an associated docker container.
function! <SID>NullifyProcessIfDescendant(cmd_name, init_params) abort
  let l:cmd_path = fnamemodify(a:cmd_name, ':p')
  let l:current_pwd = getcwd()

  return l:cmd_path =~ '^' . escape(l:current_pwd, '\')
        \ ? <SID>NullifyProcess(a:init_params)
        \ : a:init_params
endfunction

" Tweak the initialisation params to null the process id
" to allow for LSP servers running in a different process
" namespace to this client
function! <SID>NullifyProcess(init_params) abort
  let a:init_params['processId'] = v:null
  return a:init_params
endfunction

function! <SID>Vim_lsp_settings_vscode_json_language_server_capabilities() abort
  let l:capabilities = lsp#default_get_supported_capabilities('vscode-json-language-server')
  " Override snippetSupport: true for enable completion
  let l:capabilities.textDocument.completion.completionItem.snippetSupport = v:true
  return l:capabilities
endfunction

" Use the utils to find nearest parnet matching the matches or git, or
" fallback t
function! <SID>NearestParentWithOrPwd(matches) abort
  let l:markers = ['.git', '.git/'] + a:matches
  let l:root = lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), l:markers)
  if empty(l:root)
        let l:root = getcwd()
  endif
  return lsp#utils#path_to_uri(l:root)
endfunction

if executable('pylsp')
  autocmd User lsp_setup call lsp#register_server({
        \   'name': 'pylsp',
        \   'cmd': ['pylsp'],
        \   'allowlist': ['python'],
        \   'before_init': function('<SID>NullifyProcessIfDescendant', ['pylsp']),
        \ })
elseif executable('lsp-python')
  autocmd User lsp_setup call lsp#register_server({
        \   'name': 'lsp-python',
        \   'cmd': ['lsp-python'],
        \   'allowlist': ['python'],
        \ })
endif

if executable('csharp-ls')
  autocmd User lsp_setup call lsp#register_server({
        \   'name': 'csharp-ls',
        \   'cmd': ['csharp-ls'],
        \   'root_uri': { server_info-><SID>NearestParentWithOrPwd(['*.csproj', '*.sln']) },
        \   'allowlist': ['cs'],
        \   'before_init': function('<SID>NullifyProcessIfDescendant', ['csharp-ls']),
        \ })
elseif executable('roslyn-language-server')
  autocmd User lsp_setup call lsp#register_server({
        \   'name': 'roslyn-language-server',
        \   'cmd': ['roslyn-language-server', '--stdio'],
        \   'root_uri': { server_info-><SID>NearestParentWithOrPwd(['*.csproj', '*.sln']) },
        \   'allowlist': ['cs'],
        \   'before_init': function('<SID>NullifyProcessIfDescendant', ['roslyn-language-server']),
        \ })
elseif executable('lsp-csharp')
  autocmd User lsp_setup call lsp#register_server({
        \   'name': 'lsp-csharp',
        \   'cmd': ['lsp-csharp'],
        \   'allowlist': ['cs'],
        \   'before_init': function('<SID>NullifyProcess'),
        \ })
endif

if executable('lsp-json')
  autocmd User lsp_setup call lsp#register_server({
        \   'name': 'lsp-json',
        \   'cmd': ['lsp-json'],
        \   'allowlist': ['json'],
        \   'before_init': function('<SID>NullifyProcess'),
        \ })
elseif executable('vscode-json-languageserver')
  autocmd User lsp_setup call lsp#register_server({
        \   'name': 'vscode-json-languageserver',
        \   'cmd': ['vscode-json-languageserver', '--stdio'],
        \   'allowlist': ['json', 'jsonc'],
        \   'initialization_options': {
        \     'provideFormatter': v:true
        \   },
        \   'capabilities': <SID>Vim_lsp_settings_vscode_json_language_server_capabilities(),
        \   'before_init': function('<SID>NullifyProcessIfDescendant', ['vscode-json-languageserver']),
        \ })
endif

if executable('solargraph')
  autocmd User lsp_setup call lsp#register_server({
        \   'name': 'solargraph',
        \   'cmd': ['solargraph', 'stdio'],
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
        \   'before_init': function('<SID>NullifyProcessIfDescendant', ['solargraph']),
        \ })
elseif executable('lsp-ruby')
  autocmd User lsp_setup call lsp#register_server({
        \   'name': 'lsp-ruby',
        \   'cmd': ['lsp-ruby'],
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
        \   'before_init': function('<SID>NullifyProcess'),
        \ })
endif

if executable('typescript-language-server')
  autocmd User lsp_setup call lsp#register_server({
        \   'name': 'typescript-language-server',
        \   'cmd': ['typescript-language-server', '--stdio'],
        \   'root_uri': { server_info-><SID>NearestParentWithOrPwd([]) },
        \   'allowlist': ['javascript', 'javascript.jsx', 'javascriptreact', 'typescript', 'typescript.tsx', 'typescriptreact'],
        \   'before_init': function('<SID>NullifyProcessIfDescendant', ['typescript-language-server']),
        \ })
elseif executable('lsp-typescript')
  autocmd User lsp_setup call lsp#register_server({
        \   'name': 'lsp-typescript',
        \   'cmd': ['lsp-typescript'],
        \   'root_uri': { server_info-><SID>NearestParentWithOrPwd([]) },
        \   'allowlist': ['javascript', 'javascript.jsx', 'javascriptreact', 'typescript', 'typescript.tsx', 'typescriptreact'],
        \   'before_init': function('<SID>NullifyProcess'),
        \ })
endif

if executable('rust-analyzer')
  autocmd User lsp_setup call lsp#register_server({
        \   'name': 'rust-analyzer',
        \   'cmd': ['rust-analyzer'],
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
        \   'cmd': ['lsp-rust'],
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

if executable('kotlin-lsp')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'kotlin-lsp',
        \ 'cmd': [&shell, &shellcmdflag, 'JDK_JAVA_OPTIONS="-Xmx16g" kotlin-lsp --stdio'],
        \ 'root_uri': { server_info-><SID>NearestParentWithOrPwd([]) },
        \ 'initialization_options': {
        \ },
        \ 'whitelist': ['kotlin'],
        \ 'before_init': function('<SID>NullifyProcessIfDescendant', ['kotlin-lsp']),
        \ })
elseif executable('kotlin-language-server')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'kotlin-language-server',
        \ 'cmd': [&shell, &shellcmdflag, 'JDK_JAVA_OPTIONS="-Xmx16g" kotlin-language-server'],
        \ 'initialization_options': {
        \ },
        \ 'whitelist': ['kotlin'],
        \ 'before_init': function('<SID>NullifyProcessIfDescendant', ['kotlin-language-server']),
        \ })
endif

if executable('elm-language-server')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'elm-language-server',
        \ 'cmd': [&shell, &shellcmdflag, 'elm-language-server'],
        \ 'whitelist': ['elm'],
        \ })
endif

if executable('uiua')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'uiua-lsp',
        \ 'cmd': ['uiua', 'lsp'],
        \ 'whitelist': ['uiua'],
        \ })
endif

if executable('ccls')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'ccls',
      \ 'cmd': ['ccls'],
      \ 'root_uri': { server_info-><SID>NearestParentWithOrPwd([]) },
      \ 'initialization_options': {},
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      \ })
endif

if executable('openscad-lsp')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'openscad-lsp',
      \ 'cmd': ['openscad-lsp', '--stdio'],
      \ 'whitelist': ['openscad'],
      \ })
endif

if executable('fsautocomplete')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'fsautocomplete',
      \ 'cmd': ['fsautocomplete'],
      \ 'root_uri': { server_info-><SID>NearestParentWithOrPwd([]) },
      \ 'whitelist': ['fsharp'],
      \ 'initialization_options': {
      \   'AutomaticWorkspaceInit': 'true'
      \ },
      \ 'before_init': function('<SID>NullifyProcessIfDescendant', ['fsautocomplete']),
      \ })
endif
