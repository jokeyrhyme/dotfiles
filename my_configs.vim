" solarize
if has('gui_running')
  set background=light
else
  set background=dark
  let g:solarized_termcolors=256
  let g:solarized_termtrans=1
endif
:colorscheme solarized

" disable additional junk files
set noswapfile
set nobackup
set nowritebackup

let g:syntastic_javascript_checkers=['eslint']

"set gfn=Hack\ 11,Source\ Code\ Pro\ 11,Menlo\ 11,Consolas\ 11,Bitstream\ Vera\ Sans\ Mono\ 11

if has('gui_running')
  if has('toolbar')
    set go-=T
  endif

  set columns=90
  set lines=50
endif
