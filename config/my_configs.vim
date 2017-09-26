" solarize
if has('gui_running')
  set background=dark
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

let g:ale_fixers = {
\  'javascript': ['prettier', 'eslint']
\}
let g:ale_fix_on_save = 1

if has('gui_running')
  if has('toolbar')
    set go-=T
  endif

  set columns=90
  set lines=50

  if has("mac")
    set guifont=Fira\ Code\ 14,Hasklig:h14,Hack:h14
  elseif has("unix")
    set guifont=Fira\ Code\ 11,Hasklig:h11,Hack:h11
  endif
endif

