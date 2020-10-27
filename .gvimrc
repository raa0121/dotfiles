colorscheme evening
nnoremap <silent> <C-F2> :if &guioptions =~# 'T' <Bar> 
            \set guioptions-=T <Bar> 
            \set guioptions-=m <Bar>
            \else <Bar> 
            \set guioptions+=T <Bar> 
            \set guioptions+=m <Bar>
            \endif<CR>
 
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim
set guioptions-=T
set guioptions-=m
set guioptions-=r
set guioptions-=L
set guioptions+=!

if has('win32') || has('win64')
  set guifont=Cica:h12:cSHIFTJIS
elseif has('unix')
  set guifont=Cica\ 12
endif
if has('multi_byte_ime') || has('xim')
  highlight Cursor guifg=NONE guibg=Red
  highlight CursorIM guifg=NONE guibg=Green
endif
gui
if has('win32') || has('win64') || has('win32unix')
  set transparency=220
endif

