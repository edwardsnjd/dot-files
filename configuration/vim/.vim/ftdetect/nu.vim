autocmd BufRead,BufNewFile * call <SID>CheckForNuShebang()

fun <SID>CheckForNuShebang()
  if getline(1) =~ "\\v^#!\\s*/usr/bin/env\>.*\<nu\>"
    setfiletype nu
  endif
endfun
