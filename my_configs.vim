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
  if has('toolbar')
    set go-=T
  endif

  set columns=90
  set lines=50

  set guifont=Fira_Code:h14,Hasklig:h14,Hack:h14
endif

