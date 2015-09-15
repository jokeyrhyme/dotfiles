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

if has('gui_running')
  set nofullscreen

  set guifont=Hack:h14,Source\ Code\ Pro:h14,Menlo:h13,Consolas:h12

  if has('mac')
    set transparency=2
  endif

  if has('toolbar')
    set go-=T
  endif

  set columns=90
  set lines=50
endif
