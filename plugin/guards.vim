
  let s:IncludeGuard_Tag_ifndef = "#ifndef __"
  let s:IncludeGuard_Tag_define = "#define __"
  let s:IncludeGuard_Tag_endif = "#endif //__"

  let s:IncludeGuard_Tag_cpp_open = "#ifdef __cplusplus\<enter>"
  let s:IncludeGuard_Tag_cpp_open = s:IncludeGuard_Tag_cpp_open."extern \"C\" {\<enter>"
  let s:IncludeGuard_Tag_cpp_open = s:IncludeGuard_Tag_cpp_open."#endif\<enter>"

  let s:IncludeGuard_Tag_cpp_close = "#ifdef __cplusplus\<enter>"
  let s:IncludeGuard_Tag_cpp_close = s:IncludeGuard_Tag_cpp_close."}\<enter>"
  let s:IncludeGuard_Tag_cpp_close = s:IncludeGuard_Tag_cpp_close."#endif\<enter>"

function! InsertCIncludeGuard()
    let s:Filename = split(expand('%:t'), '/')[-1]
    echo s:Filename
    exec "normal ggo"
    exec "normal gga".s:IncludeGuard_Tag_ifndef.s:Filename
    exec "normal 0f.r_"
    exec "normal gUaw"
    exec "normal o".s:IncludeGuard_Tag_define.s:Filename
    exec "normal 0f.r_"
    exec "normal gUaw"
    exec "normal Go".s:IncludeGuard_Tag_endif.s:Filename
    exec "normal 0f.r_"
    exec "normal gUaw"
    call InsertExternCGuard()
endfunc

function! InsertExternCGuard()
    exec "normal gg2jo"
    exec "normal o".s:IncludeGuard_Tag_cpp_open
    "Hack to play nice with nerdcommenter
    exec "normal dd"
    exec "normal Gko"
    exec "normal o".s:IncludeGuard_Tag_cpp_close
endfunc

command! CIncGuard call InsertCIncludeGuard()

